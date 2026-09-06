// @ts-check
import node from "@astrojs/node";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig, fontProviders } from "astro/config";

export default defineConfig({
  adapter: node({ mode: "standalone" }),
  build: {
    inlineStylesheets: "always",
  },
  compressHTML: true,
  fonts: [
    {
      cssVariable: "--font-barriecito",
      fallbacks: ["cursive", "sans-serif"],
      name: "Barriecito",
      options: {
        variants: [
          {
            src: ["./src/assets/fonts/barriecito-v18-latin-regular.woff2"],
            style: "normal",
            weight: "normal",
          },
        ],
      },
      provider: fontProviders.local(),
    },
  ],
  output: "server",
  prefetch: {
    prefetchAll: true,
  },
  site: "https://ocd.beauty",
  vite: {
    css: {
      transformer: "lightningcss",
    },
    plugins: [tailwindcss()],
  },
});
