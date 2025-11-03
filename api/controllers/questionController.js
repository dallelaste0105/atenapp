const questionModel = require("../models/questionModel");
const leagueModel = require("../models/leagueModel");
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

async function addPointsContextConnection(req, res) {
    const {context, accuracy} = req.body;
    const {userId, userType} = req.userData;
    try {
        if (context == "league") {
            let points;
            for (let i = 0; i < accuracy.length; i++) {
                points += accuracy[i];
            }
            const leagueId = await leagueModel.verifyUserLeagueAndPoints(userId);
            const newPoints = leagueId[1] + points;
            await questionModel.addPoints(userId, leagueId, newPoints);
        }
    } catch (error) {
        
    }
}


module.exports = {getQuestionController};