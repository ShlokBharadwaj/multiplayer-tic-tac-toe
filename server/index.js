const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const Room = require('./models/room');

var io = require('socket.io')(server);
// middle ware 
app.use(express.json)

const DB = "mongodb+srv://<MongodbUsername>:<MongodbPassword>@cluster0.agpq7tt.mongodb.net/?retryWrites=true&w=majority";

io.on("connection", (socket) => {
    console.log("New user connected");
    socket.on("create-room", async ({ roomName }) => {
        console.log(roomName);
        try {
            let room = new Room();
            let player = {
                socketID: socket.id,
                roomName,
                playerType: 'X',
            }
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            console.log(room);
            const roomId = room._id.toString();
            socket.join(roomId);

            io.to(roomId).emit("room-created", room);

            // socket.on("disconnect", () => {
            //     console.log("User disconnected");
            // });
        }
        catch (err) {
            console.log(err);
        }

    });
});

mongoose
    .connect(DB)
    .then(() => {
        console.log("Connection successful");
    }).catch((err) => {
        console.log(err);
    });

server.listen(port, '0.0.0.0', () => {
    console.log(`Server running on port ${port}`);
});