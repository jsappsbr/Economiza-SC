import puppeteer from 'puppeteer';
import fs from 'node:fs';

(async () => {
    const browser = await puppeteer.launch({
        headless: true,
        devtools: false,
        defaultViewport: null,
        args: ['--start-maximized']
    });

    const pageLinks = [
        'https://www.superkoch.com.br/mercearia',
        'https://www.superkoch.com.br/frios-laticinios',
        'https://www.superkoch.com.br/carnes',
        'https://www.superkoch.com.br/horta-pomar-granja-floric',
        'https://www.superkoch.com.br/bebidas',
        'https://www.superkoch.com.br/limpeza',
        'https://www.superkoch.com.br/higiene',
        'https://www.superkoch.com.br/outros'
    ]

    const allProducts = []

    for (const initialPageLink of pageLinks) {
        const products = await scrapeProducts(browser, initialPageLink)
        allProducts.push(...products)
    }

    fs.writeFileSync('storage/app/scraper/products.json', JSON.stringify(allProducts, null, 2))

    await browser.close();
})();

async function scrapeProducts(browser, pageLink) {
    const allProducts = []
    let currentPageLink = pageLink

    while (true) {
        console.info(`Scraping ${currentPageLink}`)

        const page = await browser.newPage();

        await page.goto(currentPageLink);

        const products = await page.evaluate(async () => {
            const products = []
            const listContainer = document.querySelector('.products.list.items.product-items')

            for (const item of listContainer.children) {
                const link = item.querySelector('a.product.photo.product-item-photo').href
                const sku = link.split('-').at(-1)

                products.push({
                    name: item.querySelector('a.product-item-link').innerText,
                    price: item.querySelector('span.price').innerText
                        .replace('R$', '')
                        .replace(',', '.')
                        .trim(),
                    picture: item.querySelector('img.product-image-photo').src,
                    link,
                    sku
                })
            }

            return products
        })

        allProducts.push(...products)

        const nextPageLink = await page.evaluate(() => {
            return document.querySelector('a.action.next')?.href
        })

        await page.close()

        if (!nextPageLink) {
            break
        } else {
            currentPageLink = nextPageLink
        }
    }

    return allProducts
}
