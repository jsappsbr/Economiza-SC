<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->get('search');
        $storeIds = $request->get('store_ids', []);

        $products = Product::query()
            ->when($search, fn($query) => $query->where('name', 'like', "%{$search}%"))
            ->when($storeIds, fn($query) => $query->whereIn('store_id', $storeIds))
            ->limit(200)
            ->get();

        return response()->json($products);
    }
}
