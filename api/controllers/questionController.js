const questionModel = require("../models/questionModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


//fazer filtro pra se o subtopico n for compatível com o tópico dar erro!
async function getQuestionController(req, res) {
    const {subject, topic, subTopic, difficulty, searchType, howMany} = req.body;
    try {
        if (searchType == "all") {
            const questions = await questionModel.getQuestionByAllModel(subject, topic, subTopic, difficulty, howMany);
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

module.exports = {getQuestionController};