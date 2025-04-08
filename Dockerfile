FROM node:18-alpine
WORKDIR /app

# 1. Копируем только package.json для оптимизации кэширования
COPY package*.json ./
RUN npm install

# 2. Копируем ВСЕ файлы (включая public/themes)
COPY . .

# 3. Убедимся, что темы скопировались правильно
RUN ls -la public/themes/

EXPOSE 3000
CMD ["node", "server.js"]