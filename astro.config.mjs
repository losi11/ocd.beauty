// @ts-check
import node from "@astrojs/node";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig, fontProviders } from "astro/config";

export default defineConfig({
  adapter: node({ mode: "standalone" }),
  build: {
    inlineStylesheets: "always",
  },
  fonts: [
    {
      cssVariable: "--font-tiny5",
      fallbacks: ["cursive", "sans-serif"],
      name: "Tiny5",
      options: {
        variants: [
          {
            src: ["./src/assets/fonts/tiny5-v3-latin-regular.woff2"],
            style: "normal",
            weight: "normal",
          },
        ],
      },
      provider: fontProviders.local(),
    },
    {
      cssVariable: "--font-ibm-plex-mono",
      fallbacks: ["monospace"],
      name: "IBM Plex Mono",
      options: {
        variants: [
          {
            src: ["./src/assets/fonts/ibm-plex-mono-v20-latin-regular.woff2"],
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
    plugins: [tailwindcss()],
  },
});
