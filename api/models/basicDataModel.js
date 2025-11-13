const db = require("../db");

async function userBasicDataLoader(id, userType) {
  return new Promise((resolve, reject) => {
    const query1 = `SELECT leagueId FROM userleague WHERE userId = ?`;
    db.query(query1, [id], (error1, result1) => {
      if (error1) return reject(error1);
      if (!result1 || result1.length === 0) {
        return resolve({ name: null, leagueId: null, leagueType: null });
      }
      const leagueId = result1[0].leagueId;

      const query2 = `SELECT type FROM league WHERE id = ?`;
      db.query(query2, [leagueId], (error2, result2) => {
        if (error2) return reject(error2);
        const leagueType = (result2 && result2.length > 0) ? result2[0].type : null;

        const query3 = `SELECT name FROM \`${userType}\` WHERE id = ?`;
        db.query(query3, [id], (error3, result3) => {
          if (error3) return reject(error3);
          const name = (result3 && result3.length > 0) ? result3[0].name : null;

          resolve({ "name": name, "leagueId": leagueId, "leagueType": leagueType, "userType": userType });
        });
      });
    });
  });
}

module.exports = { userBasicDataLoader };
