# Build BASE
FROM node:16-alpine as BASE
LABEL author="nhutlv"

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile \
    && yarn cache clean

# Build Image
FROM node:16-alpine AS BUILD
LABEL author="nhutlv"

WORKDIR /app
COPY --from=BASE /app/node_modules ./node_modules
COPY . .
RUN yarn build \
    && rm -rf node_modules \
    && yarn install --production --frozen-lockfile --ignore-scripts --prefer-offline
    # Follow https://github.com/ductnn/Dockerfile/blob/master/nodejs/node/16/alpine/Dockerfile

# Build production
FROM node:16-alpine AS PRODUCTION
LABEL author="nhutlv"

WORKDIR /app

COPY --from=BUILD /app/package.json /app/yarn.lock ./
COPY --from=BUILD /app/node_modules ./node_modules
COPY --from=BUILD /app/.next ./.next
COPY --from=BUILD /app/public ./public

EXPOSE 3000

CMD ["yarn", "start"]
