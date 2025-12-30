const db = require("../models/lessonModel");

async function getSubjectsController(req, res) {
    const {id, userType} = req.user;
    try {
        const subjects = await db.getSubjectsModel();
        if (subjects) {
            console.log(subjects);
            return res.status(200).json({msg:subjects});
        }
    } catch (error) {
        return res.status(500).json({msg:"Erro crítico"});
    }
}

module.exports = {
    getSubjectsController
}