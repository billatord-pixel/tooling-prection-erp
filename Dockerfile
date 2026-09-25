FROM node:22-bookworm-slim AS build

WORKDIR /app
ADD tooling-prection-source.tar.gz /app/
RUN corepack enable && pnpm install --frozen-lockfile && pnpm db:generate && pnpm build

FROM node:22-bookworm-slim

WORKDIR /app
COPY --from=build /app /app
ENV NODE_ENV=production
ENV PORT=3000
EXPOSE 3000
CMD ["sh", "-c", "pnpm db:bootstrap && pnpm start"]
