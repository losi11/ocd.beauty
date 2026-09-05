FROM oven/bun:1-alpine AS base

WORKDIR /losi-online

COPY package.json ./
COPY bun.lock ./

RUN bun install --frozen-lockfile --ignore-scripts

COPY . .

RUN bun run build

FROM oven/bun:1-alpine AS final

WORKDIR /app

COPY --from=base /losi-online/package.json ./
COPY --from=base /losi-online/node_modules ./node_modules
COPY --from=base /losi-online/dist ./dist

ENV HOST=0.0.0.0
ENV PORT=80
ENV NODE_ENV=production

EXPOSE 80

CMD ["bun", "./dist/server/entry.mjs"]
