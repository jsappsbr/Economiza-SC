import puppeteer from 'puppeteer'
import fs from "node:fs";

const MARKETS = [
    {
        id: 'Lj115',
        name: 'Balneário Camboriú - Estados',
        zip: '88339-035',
    },
    // {
    //     id: 'Lj310',
    //     name: 'Itajaí - Centro',
    //     zip: '88301-360',
    // },
    // {
    //     id: 'Lj195',
    //     name: 'Blumenau - Itoupavazinha',
    //     zip: '89066-001',
    // },
    // {
    //     id: 'Lj810',
    //     name: 'Florianópolis - Santo Antônio de Lisboa',
    //     zip: '88050-001',
    // },
    // {
    //     id: 'Lj810',
    //     name: 'São José - Kobrasol',
    //     zip: '88102-340',
    // },
    // {
    //     id: 'LJ145',
    //     name: 'Florianópolis - Campeche',
    //     zip: '88065-000',
    // },
]


const run = async () => {

    const browser = await puppeteer.launch({
        headless: true,
        devtools: false,
        defaultViewport: null,
        args: ['--start-maximized'],
    });

    const pageLinks = [
        'https://www.deliveryfort.com.br/alimentacao-saudavel',
        'https://www.deliveryfort.com.br/bebidas',
        'https://www.deliveryfort.com.br/carnes-aves-e-peixes',
        'https://www.deliveryfort.com.br/casa-e-lazer',
        'https://www.deliveryfort.com.br/congelados',
        'https://www.deliveryfort.com.br/food-service',
        'https://www.deliveryfort.com.br/frios-e-laticinios',
        'https://www.deliveryfort.com.br/higiene-e-beleza',
        'https://www.deliveryfort.com.br/hortifruti',
        'https://www.deliveryfort.com.br/infantil',
        'https://www.deliveryfort.com.br/limpeza',
        'https://www.deliveryfort.com.br/mercearia',
        'https://www.deliveryfort.com.br/pet-shop',
    ]

    const allProducts = []

    const page = await browser.newPage();
    page.setDefaultTimeout(60_000)
    await page.setRequestInterception(true);
    page.on('request', (request) => {
        if (request.url('https://af-origin.vtex.com/api/activity-flow/page-views')) {
            // request.respond({status: 200})
        } else if (['image', 'stylesheet', 'font'].indexOf(request.resourceType()) !== -1) {
            request.abort();
        } else {
            request.continue();
        }
    });

    for (const market of MARKETS) {
        await setMarket(page, market)

        for (const initialPageLink of pageLinks) {
            const products = await scrapeProducts(page, initialPageLink)
            allProducts.push(...products)
        }
    }

    await page.close()

    fs.writeFileSync('storage/app/scraper/fort_atacadista_products.json', JSON.stringify(allProducts, null, 2))

    await browser.close();
}

async function setMarket(page, market) {
    await page.goto('https://www.deliveryfort.com.br/pet-shop');
    await page.waitForSelector('.modalCep-content--insertPostalCode-postalCodeContainer')
    await page.evaluate((market) => {
        const input = document.querySelector('.modalCep-content--insertPostalCode-postalCodeContainer input')
        input.value = market.zip

        const button = document.querySelector('#cepInsertedAction')
        button.click()
    }, market)

    await page.waitForNetworkIdle()

    const marketInput = `input[data-id="${market.id}"]`

    await page.waitForSelector(marketInput)
    await page.evaluate((marketInput) => {
        const input = document.querySelector(marketInput)
        input.click()

        const button = document.querySelector('#deliveryTypeSelected')
        button.click()
    }, marketInput)

    await page.waitForNetworkIdle()
}

async function scrapeProducts(page, pageLink) {
    console.info(`Scraping ${pageLink}`)

    const allProducts = []
    await page.goto(pageLink);

    while (true) {
        await page.waitForNetworkIdle()

        const products = await page.evaluate(async () => {
            const products = []
            const listContainer = document.querySelector('div.main-shelf.n32colunas').children[0]

            for (const item of listContainer.children) {
                products.push({
                    name: item.querySelector('a.shelf-item__title-link').innerText,

                    price: item.querySelector('span.shelf-item__best-price').children[0].innerText
                        .replace('R$', '')
                        .replace(',', '.')
                        .trim(),

                    picture: item.querySelector('a.shelf-item__img-link').children[0].src,

                    link: item.querySelector('a.shelf-item__img-link').href,

                    sku: item.querySelector('div.shelf-item').getAttribute('data-product-id')
                })
            }

            return products
        })

        allProducts.push(...products)

        await page.evaluate(() => {
            const paginationContainer = document.querySelector('.pagination')
            const nextLink = paginationContainer.querySelector('a.pagination__button--next')
            nextLink.click()
        })

        await Promise.all([
            page.waitForNetworkIdle(),
            page.waitForSelector('div.main-shelf.n32colunas')
        ])

        const hasMoreProducts = await page.evaluate(() => {
            return document.querySelector('div.main-shelf.n32colunas').children[0].childElementCount !== 0
        })

        if (!hasMoreProducts) {
            console.log('No more products found')
            break
        }
    }

    return allProducts
}

export default run
