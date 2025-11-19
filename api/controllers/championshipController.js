const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


async function createChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const { name, participantcode, admcode } = req.body;
    try {
        if(await championshipModel.createChampionshipModel(name, participantcode, admcode, id, userType)){
            res.status(200).json({message:"Campeonato criado com sucesso"});
        }
        else{
            res.status(500).json({message:"Erro ao criar campeonato"});
        }
    } catch (error) {
        res.status(500).json({message:"Erro crítico!"});
    }
}

async function excludeChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const { championshipName } = req.body;
    try {
        if (await championshipModel.excludeChampionshipModel(championshipName, id, userType)) {
            return res.status(200).json({message:"Campeonato excluído"});
        }
        else{
            return res.status(500).json({message:"Falha ao excluir campeonato"});
        } 
    } catch (error) {
        return res.status(500).json({message:"Erro crítico"});
    }
}

async function searchChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name} = req.body;
    try{
    const championship = await championshipModel.searchChampionshipModel
    if (championship) {
        return res.status(200).json({message:championship});
    }
    else{
        return res.status(500).json({message:"Nenhum campeonato encontrado"});
    }
    }
    catch{
        return res.status(500).json({message:"Erro crítico"});
    }
}

async function enterChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name, code, hierarchyType} = req.body;
    try {
        if (await championshipModel.enterChampionshipModel(name, code, hierarchyType, id)) {
            res.status(200).json({message:"Você entrou no campeonato"})
        }
        else{
            res.status(500).json({message:"Erro ao entrar em campeonato"});
        }
    } catch (error) {
        return res.status(500).json({message:"Erro crítico"});
    }
}

async function createChampionshipEventController(req, res) {
    const { id, userType } = req.userData;
    const {championshipName, EventName, finishDate} = req.body;
    
}

async function createChampionshipEventBlockController(req, res) {
    const { id, userType } = req.userData;
    const {eventName, questionIds/*lista com os id's das questões ou licões*/, type} = req.body;
}

async function getYourChampionshipsController(req, res) {
    const { id, userType } = req.userData;

}

module.exports = {
    createChampionshipController,
    searchChampionshipController,
    enterChampionshipController,
    createChampionshipEventController,
    getYourChampionshipsController,
    excludeChampionshipController
};