<?php

namespace App\Jobs;

use App\Models\Store;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
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

    /**
     * Create a new job instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
/*         Log::info('Running scraper');
        Process::forever()->run('node resources/js/scraper/supermercadoKoch.js');
        Log::info('Scraper finished'); */

        $koch = Store::supermercadoKoch();

        $rawJson = Storage::get('scraper/products.json');
        $products = json_decode($rawJson, true, depth: JSON_THROW_ON_ERROR);

        Log::info("Upserting " . count($products) . " products");

        foreach ($products as $product) {
            $now = now();
            $product['created_at'] = $now;
            $product['updated_at'] = $now;
            $product['store_id'] = $koch->id;
            $koch->products()->updateOrCreate(['sku' => $product['sku']], $product);
        }

        Log::info('Products saved!');
    }
}
