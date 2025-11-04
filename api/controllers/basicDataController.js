const basicDataModel = require("../models/basicDataModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function userBasicDataLoader(req, res) {
    const {context} = req.body;
    const {id, userType} = req.userData;

    try {
        const nameLeagueName = basicDataModel.userBasicDataLoader(id, userType);
        return res.status(200).json({message:nameLeagueName});
    } catch (error) {
        res.status(500).json({message:"Erro ao criar campeonato"});
    }
    
}

module.exports = {userBasicDataLoader};