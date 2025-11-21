const questionModel = require("../models/questionModel");
const leagueModel = require("../models/leagueModel");
require('dotenv').config();

async function createClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, teacher, student} = req.body;
    try {
       
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
    
}

async function enterClass(req, res) {
    const {userId, userType} = req.userData;
    const {name, teacher, student} = req.body;
    try {
       
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
    
}

async function getSchoolClass(req, res) {
    const {userId, userType} = req.userData;

    try {
       
    } catch (error) {
       res.status(500).json({message:"Erro crítico"}); 
    }
    
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}