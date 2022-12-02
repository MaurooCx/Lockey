FROM node:18.12.1-alpine3.16
WORKDIR /lockey
COPY package*.json .
RUN npm install
COPY src .
CMD ["npm", "run", "start"]
