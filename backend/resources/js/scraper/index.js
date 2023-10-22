import {Command} from 'commander';
import runSupermercadoKoch from './supermercadoKoch.js'
import runFortAtacadista from './fortAtacadista.js'

const program = new Command();

program.name('scraper')
    .version('0.0.1')

program
    .command('supermercado-koch')
    .description('Scrape products from Supermercado Koch')
    .action(runSupermercadoKoch)

program
    .command('fort-atacadista')
    .description('Scrape products from Fort Atacadista')
    .action(runFortAtacadista)

program.parse(process.argv)
