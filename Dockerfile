FROM oven/bun:1-alpine AS base

WORKDIR /losi-online

FROM base AS dev-deps

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --ignore-scripts

FROM base AS prod-deps

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production --ignore-scripts

FROM base AS pre-release

COPY --from=dev-deps /losi-online/node_modules ./node_modules
COPY . .

ENV NODE_ENV=production

RUN bun run build

FROM base AS release

ENV NODE_ENV=production
ENV HOST=0.0.0.0

COPY package.json ./
COPY --from=prod-deps /losi-online/node_modules ./node_modules
COPY --from=pre-release /losi-online/dist ./dist

USER bun
EXPOSE 4321

CMD ["bun", "./dist/server/entry.mjs"]
