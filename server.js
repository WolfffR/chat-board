const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

let messages = [];

app.use(express.static('public'));

io.on('connection', (socket) => {
    console.log(`Новое подключение: ${socket.id.slice(0, 5)}...`);

    socket.on('themeChangeAttempt', (data) => {
        console.log(`[${new Date().toLocaleTimeString()}] Попытка смены темы:`, {
            theme: data.theme,
            ip: socket.handshake.address,
            timestamp: data.timestamp
        });
    });

    const now = Date.now();
    socket.emit('initialMessages', messages.filter(msg => now - msg.timestamp < 10000));

    socket.on('newMessage', (messageText) => {
        const newMessage = {
            id: Date.now().toString(),
            text: messageText,
            timestamp: Date.now()
        };
        
        messages.push(newMessage);
        io.emit('newMessage', newMessage);

        setTimeout(() => {
            messages = messages.filter(msg => msg.id !== newMessage.id);
        }, 10000);
    });
});

server.listen(3000, () => {
    console.log('Сервер работает на порту 3000');
});