# Stage 1: build
FROM node:20-alpine AS build
WORKDIR /app

# Copy package.json and lockfile
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .
RUN npm run build

# Stage 2: serve
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]