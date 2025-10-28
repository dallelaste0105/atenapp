const questionModel = require("../models/questionModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function getQuestionController(req, res) {
    const {subject, topic, subTopic, difficulty, searchType} = req.body;
    const questions = {};
    try {
        if (searchType == all) {
            questions = await questionModel.getQuestionByAllModel(subject, topic, subTopic, difficulty);
            if (questions.length > 0) {
                res.status(200).json({message:questions});
            }
            else{
                res.status(500).json({message:"Nenhuma questão encontrada"});
            }
        }
        
    } catch (error) {
        res.status(500).json({message:"Invalid search type"});
    }
    
}

module.exports = {createQuestionController, getQuestionController};