<?php

namespace App\Console\Commands;

use App\Models\Store;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Process;
use Illuminate\Support\Facades\Storage;

class ProductsScraper extends Command
{
    protected $signature = 'app:products-scraper {--skip-scraper} {--skip-save}';
    protected $description = 'Scrape products from all stores and save them to the database';


    public function handle(): void
    {
        $this->scrapeProducts();
        $this->saveScrapedProducts();
    }

    private function scrapeProducts(): void
    {
        if ($this->option('skip-scraper')) {
            Log::info('Skipping scraper');
            return;
        }

        Log::info('Running scraper');

        $processResult = Process::forever()->run('npm run scraper:supermercado-koch');

        if ($processResult->successful()) {
            Log::info('Scraper finished successfully');
        } else {
            throw new \DomainException("Scraper failed: " . $processResult->output());
        }

        Log::info('Scraper finished');
    }


    private function saveScrapedProducts(): void
    {
        if ($this->option('skip-save')) {
            Log::info('Skipping saving products');
            return;
        }

        $rawJson = Storage::get('scraper/supermercado_koch_products.json');
        $allProducts = json_decode($rawJson, true, flags: JSON_THROW_ON_ERROR);

        foreach ($allProducts as $storeCode => $products) {
            $store = Store::query()->where('code', $storeCode)->firstOrFail();

            Log::info("Saving " . count($products) . " products for store $store->name");

            foreach ($products as $product) {
                $now = now();

                $pictureUrl = $product['picture'];
                $pictureUrl = $pictureUrl ? explode("?", $pictureUrl)[0] : null;

                $product['picture'] = $pictureUrl;
                $product['created_at'] = $now;
                $product['updated_at'] = $now;
                $product['store_id'] = $store->id;

                $store->products()->updateOrCreate(
                    ['sku' => $product['sku'], 'store_id' => $store->id],
                    $product
                );
            }
        }

        Log::info('Products saved!');
    }
}
