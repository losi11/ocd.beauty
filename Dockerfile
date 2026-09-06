FROM oven/bun:1-alpine AS base

WORKDIR /losi-online

FROM base AS development-dependencies

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --ignore-scripts

FROM base AS production-dependencies

COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production --ignore-scripts

FROM base AS pre-release

COPY --from=development-dependencies /losi-online/node_modules ./node_modules
COPY . .

ARG COMMIT_HASH
ARG PUBLIC_LAST_FM_API_KEY
ARG PUBLIC_LAST_FM_USER

ENV COMMIT_HASH=$COMMIT_HASH
ENV NODE_ENV=production
ENV PUBLIC_LAST_FM_API_KEY=$PUBLIC_LAST_FM_API_KEY
ENV PUBLIC_LAST_FM_USER=$PUBLIC_LAST_FM_USER

RUN bun run build

FROM base AS release

ENV HOST=0.0.0.0
ENV NODE_ENV=production

COPY package.json ./
COPY --from=production-dependencies /losi-online/node_modules ./node_modules
COPY --from=pre-release /losi-online/dist ./dist

USER bun
EXPOSE 4321

CMD ["node", "./dist/server/entry.mjs"]
