const championshipModel = require("../models/championshipModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


async function createChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const { name, participantcode, admcode } = req.body;
}

async function searchChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name} = req.body;
    
}

async function enterChampionshipController(req, res) {
    const { id, userType } = req.userData;
    const {name, code} = req.body;
}

async function createChampionshipEventController(req, res) {
    const { id, userType } = req.userData;
    
}

async function getChampionships(req, res) {
    const { id, userType } = req.userData;

}

module.exports = {createChampionshipController, searchChampionshipController, enterChampionshipController, createChampionshipEventController, getChampionships};