# Build Phase
FROM node:16-alpine as builder

WORKDIR '/app'
COPY ./package.json ./
RUN npm install
COPY . .

RUN npm run build

# Run phase
FROM nginx 
EXPOSE 80
# Copy from folder build phase to nginx static content area
COPY --from=builder /app/build /usr/share/nginx/html
