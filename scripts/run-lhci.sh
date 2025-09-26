cp .env.local .env.temp
cp env/.env.ci .env.local

yarn install --network-concurrency 1
yarn build:local
lhci autorun
cp .env.temp .env.local
rm .env.temp