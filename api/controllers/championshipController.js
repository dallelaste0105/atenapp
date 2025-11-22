const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


async function createChampionshipController(req, res) {
  const { id, userType } = req.userData;
  const { name, code } = req.body;

  try {
    const result = await championshipModel.createChampionshipModel(name, code, id, userType);

    if (result && result.insertId) {
      return res.status(200).json({ message: "Campeonato criado com sucesso" });
    }

    return res.status(500).json({ message: "Erro ao criar campeonato" });

  } catch (error) {
    console.log("ERRO NO MODEL:", error);
    return res.status(500).json({ message: error.message || error });
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
    try {
        const yourChampionships = await championshipModel.getYourChampionshipsModel;
        if (yourChampionships) {
            res.status(200).json({message:yourChampionships});
        } else {
            res.status(500).json({message:"Erro ao buscar campeonatos"});
        }
    } catch (error) {
        return res.status(500).json({message:"Erro crítico"});
    }

}

module.exports = {
    createChampionshipController,
    searchChampionshipController,
    enterChampionshipController,
    createChampionshipEventController,
    getYourChampionshipsController,
    excludeChampionshipController
};