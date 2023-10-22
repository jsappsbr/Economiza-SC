<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        \App\Models\User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@test.com',
            'password' => bcrypt('password'),
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Itajaí e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj5',
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Itapema e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj9',
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Penha e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj23',
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Florianópolis Ilha',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj47',
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Florianópolis Ilha',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj47',
        ]);

        \App\Models\Store::factory()->create([
            'name' => 'Supermercado Koch - Navegantes',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj44',
        ]);
    }
}
