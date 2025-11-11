const db = require("../db");

async function getQuestionByAllModel(subTopicName, difficultyString, howMany) {
  return new Promise((resolve, reject) => {
    const query = `
      SELECT q.* 
      FROM atena.question AS q 
      JOIN atena.content AS c 
      ON q.subtopic = c.id 
      WHERE c.subtopic = ? AND q.difficulty = ? 
      LIMIT ?;
    `;

    db.query(query, [subTopicName, difficultyString, howMany], (error, result) => {
      if (error) {
        return reject(error);
      }
      return resolve(result && result.length > 0 ? result : []);
    });
  });
}

async function addPoints(userId, leagueId, points) {
  return new Promise((resolve, reject) => {
    const query = `UPDATE userleague SET points = ? WHERE userId = ? AND leagueId = ?`;

    db.query(query, [points, userId, leagueId], (error, result) => {
      if (error) {
        console.error("❌ Erro no UPDATE addPoints:", error);
        return reject(error);
      }

      if (result.affectedRows === 0) {
        console.error("⚠ Nenhum registro foi atualizado. Verifique userId e leagueId.");
        return reject(new Error("Nenhum registro foi atualizado. userId/leagueId inválido."));
      }

      console.log("✅ Pontos atualizados com sucesso no banco!");
      resolve({ message: "Pontos atualizados com sucesso." });
    });
  });
}

async function getQuestionInfoModel() {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM content";
    db.query(query, (error, result) => {
      if (error) {
        return reject(error);
      }
      return resolve(result);
    });
  });
}

module.exports = { 
  getQuestionByAllModel, 
  getQuestionInfoModel,
  addPoints 
};
