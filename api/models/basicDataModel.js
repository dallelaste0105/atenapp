const db = require("../db");

async function userBasicDataLoader(id, userType) {
  return new Promise((resolve, reject) => {
    
        const query1 = `SELECT leagueId FROM userleague WHERE userId = ?`;
        db.query(query1, [id], (error, result1) => {
        if (error) return reject(error);
        const leagueId = result1;

        const query2 = `SELECT type FROM league WHERE id = ?`;
        db.query(query2, [leagueId], (error, result2) => {
        if (error) return reject(error);
        const leagueId = result2;

        const query3 = `SELECT name FROM \`${userType}\` WHERE id = ?`;
        db.query(query3, [id], (error, result3) => {
        if (error) return reject(error);
        const leagueId = result3;

          resolve({ name: result3, leagueName : result2 });
        });
      
      });
    });
  })}

module.exports = {userBasicDataLoader};