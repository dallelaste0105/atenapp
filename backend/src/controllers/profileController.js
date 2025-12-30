const db = require("../models/lessonModel");

async function getBasicDataController(req, res) {
    const {id, userType} = req.user;
    try {
        const basicData = await db.getBasicDataModel(id, userType);
        return res.status(200).json({msg:"basicData"});
    } catch (error) {
        return res.status(500).json({msg:"Erro crítico"});
    }

}

module.exports = {
    getBasicDataController
}