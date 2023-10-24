<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\Store;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@test.com',
            'password' => bcrypt('password'),
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Itajaí e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj5',
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Itapema e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj9',
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Penha e Região',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj23',
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Florianópolis Ilha',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj47',
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Florianópolis Ilha',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj47',
        ]);

        Store::factory()->create([
            'name' => 'Supermercado Koch - Navegantes',
            'website' => 'https://www.superkoch.com.br',
            'code' => 'website_lj44',
        ]);
    }
}
