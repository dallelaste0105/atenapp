const db = require("../db");
//ARMAZENA OS DADOS NO CONTROLLER, EXCLUI A RELAÇÃO DO USUÁRIO COM A LIGA ANTIGA E AI EXECUTA ESSA FUNÇÃO
async function addUserLeague(userId, newLeagueId) {
  return new Promise((resolve, reject) => {
    const query1 = `INSERT INTO userleague (userId, leagueId, points) VALUES (?, ?, ?)`;
    db.query(query1, [userId, newLeagueId, 0], (error, result1) => {
      if (error) return reject(error);

      const query2 = `SELECT participants FROM league WHERE id = ?`;
      db.query(query2, [newLeagueId], (error, result2) => {
        if (error) return reject(error);

        const currentParticipants = result2[0].participants;
        const updatedParticipants = currentParticipants + 1;

        const query3 = `UPDATE league SET participants = ? WHERE id = ?`;
        db.query(query3, [updatedParticipants, newLeagueId], (error, result3) => {
          if (error) return reject(error);

          resolve({ message: "Usuário adicionado e número de participantes atualizado." });
        });
      });
    });
  });
}


async function existLeagues(league) {
  return new Promise((resolve, reject) => {
        const query = `SELECT id FROM \`${league}\` WHERE participants<50`;
        db.query(query, (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result);
        });
    });
}

async function createNewLeague(league) {
  return new Promise((resolve, reject) => {
        const query = "INSERT INTO league (type, participants) VALUES (?, ?)";
        db.query(query, [league, 0], (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result);
        });
    })
}

module.exports = {
  addUserLeague,
  existLeagues,
  createNewLeague,
}