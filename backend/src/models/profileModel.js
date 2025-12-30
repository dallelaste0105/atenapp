const db = require("../config");

async function getBasicDataModel(id, userType) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT name FROM user WHERE id = ?";
        db.query(query1, [id], (error1, result1) => {
            if (error1) {
                return reject(false);
            }
            return resolve(result1);
        })
    })
}

module.exports = {
    getBasicDataModel
}