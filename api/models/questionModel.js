const db = require("../db");

async function getQuestionByAllModel(subject, topic, subTopic, difficulty) {
    return new Promise((resolve, reject) => {
        const query = "SELECT * FROM question WHERE subject = ? AND topic = ? AND subTopic = ? AND difficulty = ?";
        db.query(query, [subject, topic, subTopic, difficulty], (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result && result.length > 0 ? result[0] : null);
        });
    });
}

module.exports = {getQuestionByAllModel}