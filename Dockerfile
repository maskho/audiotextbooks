# Install dependencies only when needed
FROM node:16.18.1 AS deps

WORKDIR /app
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile

# If using npm with a `package-lock.json` comment out above and use below instead
COPY package.json package-lock.json /app
COPY ./node_modules/@mathigon/studio ./node_modules/@mathigon/studio
# RUN npm ci --only=production && npm cache clean --force

RUN npx patch-package@6.4.7 @mathigon/studio
RUN npm install

# Rebuild the source code only when needed

# Next.js collects completely anonymous telemetry data about general usage.
# Learn more here: https://nextjs.org/telemetry
# Uncomment the following line in case you want to disable telemetry during the build.


# RUN yarn build

# If using npm comment out above and use below instead
RUN npm run build

COPY . /app

# You only need to copy next.config.js if you are NOT using the default configuration
# COPY --from=builder /app/next.config.js ./

# Automatically leverage output traces to reduce image size 
# https://nextjs.org/docs/advanced-features/output-file-tracing



EXPOSE 5000

CMD ["npm", "start"]