import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: 'https://sp1ke.dev',
  base: '/',
  output: 'static',
  build: {
    assets: 'assets'
  }
});
