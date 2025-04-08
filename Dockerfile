# Используем официальный образ Node.js
FROM node:18-alpine

# Создаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем все файлы проекта
COPY . .
COPY themes /app/public/themes
# Собираем статические файлы (если нужно)
# RUN npm run build

# Открываем порт
EXPOSE 3000

# Запускаем приложение
CMD ["node", "server.js"]