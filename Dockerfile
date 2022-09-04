FROM node:18-alpine3.15

WORKDIR /app

COPY package.json .
RUN npm install
ENV REDIS_URL=redis://redis:6379
COPY . .
CMD ["npm", "start"]