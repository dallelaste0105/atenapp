const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();
const credential = require("../src/routes/credentialRoute");
const lesson = require("../src/routes/lessonRoute");
const profile = require("../src/routes/profileRoute");

const app = express();

app.use(cors());
app.use(bodyParser.json()); 

app.use("/credential", credential);
app.use("/lesson", lesson);
app.use("/profile", profile);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});