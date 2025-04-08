FROM node:18-alpine
WORKDIR /app

# 1. Копируем только package.json для оптимизации кэширования
COPY package*.json ./
RUN npm install

# 2. Копируем ВСЕ файлы (включая public/themes)
COPY . .
COPY public/themes/space-theme.css public/themes/space-theme.css
COPY public/themes/paper-theme.css public/themes/paper-theme.css
COPY public/themes/neon-theme.css public/themes/neon-theme.css

COPY public/themes/paper.png themes/paper.png
COPY public/themes/space-theme.css themes/space-theme.css
COPY public/themes/paper-theme.css themes/paper-theme.css
COPY public/themes/neon-theme.css themes/neon-theme.css
# 3. Убедимся, что темы скопировались правильно
RUN ls -la public/themes/

EXPOSE 3000
CMD ["node", "server.js"]