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

async function userGeneralBasicDataModel(id) {
  return new Promise((resolve, reject) => {

    // 1) Nome
    const q1 = "SELECT name FROM user WHERE id = ?";
    db.query(q1, [id], (e1, r1) => {
      if (e1) return reject(e1);

      const name = r1.length > 0 ? r1[0].name : null;

      // 2) Pega leagueId
      const q2 = "SELECT leagueId FROM userleague WHERE userId = ?";
      db.query(q2, [id], (e2, r2) => {
        if (e2) return reject(e2);

        const leagueId = r2.length > 0 ? r2[0].leagueId : null;

        if (!leagueId) {
          return resolve({ name, leagueType: null });
        }

        // 3) Pega leagueType
        const q3 = "SELECT type FROM league WHERE id = ?";
        db.query(q3, [leagueId], (e3, r3) => {
          if (e3) return reject(e3);

          const leagueType = r3.length > 0 ? r3[0].type : null;

          resolve({
            "name":name,
            "leagueType":leagueType
          });
        });
      });
    });
  });
}

async function studentGeneralBasicDataModel(id) {
  new Promise((resolve, reject) => {
    const query1 = "SELECT name FROM student WHERE id = ?";
    const studentName = db.query(query1, [id], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }
      else{
        return resolve({"name":studentName});
      }
    })
  })
}

async function teacherGeneralBasicDataModel(id) {
  new Promise((resolve, reject) => {
    const query1 = "SELECT name FROM teacher WHERE id = ?";
    const teacherName = db.query(query1, [id], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }
      else{
        return resolve({"name":teacherName});
      }
    })
  })
}

async function schoolGeneralBasicDataModel(id) {
  new Promise((resolve, reject) => {
    const query1 = "SELECT name FROM school WHERE id = ?";
    const schoolName = db.query(query1, [id], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }
      else{
        return resolve({"name":schoolName});
      }
    })
  })
}

module.exports = { userBasicDataLoader, userGeneralBasicDataModel, studentGeneralBasicDataModel, teacherGeneralBasicDataModel, schoolGeneralBasicDataModel};
