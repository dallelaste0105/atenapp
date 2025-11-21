const credentialRoute = require('../api/routes/credentialRoute');
const questionRoute = require('../api/routes/questionRoute');
const championshipRoute = require('../api/routes/championshipRoute');
const leagueRoute = require('../api/routes/leagueRoute');
const basicData = require('../api/routes/basicDataRoute');
const classRoute = require('../api/routes/classRoute');

const express = require('express');
const cors = require('cors');
require('dotenv').config();
const db = require('./db');
const cookieParser = require('cookie-parser');
const app = express();
const PORT = process.env.PORT || 3000;
app.use(cors({
  origin: '*',
}));
app.use(express.json());
app.use(cookieParser());

app.use('/championship', championshipRoute);
app.use('/credential', credentialRoute);
app.use('/question', questionRoute);
app.use('/league', leagueRoute);
app.use('/basicdata', basicData);
app.use('/class', classRoute);

app.listen(PORT, () => {
 console.log(`Servidor rodando em http://localhost:${PORT}`);
});