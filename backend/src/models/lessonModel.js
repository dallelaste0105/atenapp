const db = require("../config");

async function getSubjectsModel() {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT name FROM subjects";
        db.query(query1, [], (error1, result1) => {
            if (error1) {
                return reject(false);
            }
            return resolve(result1);
        })
    })
}

module.exports = {
    getSubjectsModel
}