FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm install

COPY . .

# Expose Vite's default dev port
EXPOSE 5173

# Start the dev server and bind to all network interfaces so Docker maps it
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
