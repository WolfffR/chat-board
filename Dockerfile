FROM node:18-alpine
WORKDIR /app

# 1. Копируем зависимости
COPY package*.json ./
RUN npm install

# 2. Копируем основные файлы
COPY server.js ./
COPY public/index.html public/index.html
COPY public/styles.css public/styles.css

# 3. Создаем папку themes и копируем файлы
RUN mkdir -p public/themes
COPY public/themes/*.css public/themes/

# 4. Проверка
RUN ls -la public/themes/

EXPOSE 3000
CMD ["node", "server.js"]