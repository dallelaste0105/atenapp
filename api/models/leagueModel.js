const db = require("../db");

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
    const query = `SELECT id FROM league WHERE type = ? AND participants < 50`;
    db.query(query, [league], (error, result) => {
      if (error) return reject(error);
      return resolve(result && result.length > 0 ? result[0].id : null);
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

async function getCompetitorsLeague(leagueId) {
  return new Promise((resolve, reject) => {
    // ⚙️ Query com JOIN — elimina necessidade de duas consultas separadas
    const query = `
      SELECT u.id, u.name, u.email, ul.points
      FROM userleague AS ul
      INNER JOIN user AS u ON ul.userId = u.id
      WHERE ul.leagueId = ?;
    `;

    db.query(query, [leagueId], (error, result) => {
      if (error) {
        console.error("❌ Erro no getCompetitorsLeague:", error);
        return reject(error);
      }

      if (!result || result.length === 0) {
        console.warn("⚠️ Nenhum competidor encontrado para essa liga:", leagueId);
        return resolve([]); // retorna lista vazia (não quebra o app)
      }

      console.log("✅ Competidores encontrados:", result);
      resolve(result); // lista de objetos {id, name, email, points}
    });
  });
}




module.exports = {
  addUserLeague,
  existLeagues,
  createNewLeague,
  getCompetitorsLeague
}