const credentialRoute = require('../api/routes/credentialRoute');

const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./db');
const cookieParser = require('cookie-parser');
const app = express();
const PORT = process.env.PORT || 3000;
app.use(cors({
  origin: "http://192.168.1.2:62731",
  methods: ['GET', 'POST'],
  allowedHeaders: ['Content-Type']
}));
app.use(express.json());
app.use(cookieParser());
app.use('/credential', credentialRoute);

app.listen(PORT, '0.0.0.0', () => {
 console.log(`Servidor rodando em http://localhost:${PORT}`);
});