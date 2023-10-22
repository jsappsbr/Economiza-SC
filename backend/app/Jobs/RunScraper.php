<?php

namespace App\Jobs;

use App\Models\Store;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Process;
use Illuminate\Support\Facades\Storage;

class RunScraper implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $timeout = 60 * 60; // 1 hour

    public function handle(): void
    {
        Log::info('Running scraper');
        $processResult = Process::forever()->run('npm run scraper:supermercado-koch');

        if ($processResult->successful()) {
            Log::info('Scraper finished successfully');
        } else {
            $this->fail("Scraper failed: " . $processResult->output());
        }

        Log::info('Scraper finished');

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
