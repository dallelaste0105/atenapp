const db = require("../db");

async function createChampionshipModel(name, code, id, userType) {
  return new Promise((resolve, reject) => {

    if (userType === "school") {

      const query1 = `
        INSERT INTO championship (name, code, teacherid, schoolid)
        VALUES (?, ?, ?, ?)
      `;

      db.query(query1, [name, code, 0, id], (error1, result1) => {
        if (error1) {
          return reject(error1);
        }
        return resolve(result1);
      });

    } 
    
    else {

      const query2 = `
        SELECT school_id FROM schoolteacher WHERE teacher_id = ?
      `;

      db.query(query2, [id], (error2, result2) => {
        if (error2) return reject(error2);

        if (!result2 || result2.length === 0) {
          return reject("Professor não vinculado a nenhuma escola");
        }

        const schoolId = result2[0].school_id;

        const query3 = `
          INSERT INTO championship (name, code, teacherid, schoolid)
          VALUES (?, ?, ?, ?)
        `;

        db.query(query3, [name, code, id, schoolId], (error3, result3) => {
          if (error3) return reject(error3);
          return resolve(result3);
        });
      });
    }
  });
}


async function enterChampionshipModel(name, code, id) {
  return new Promise((resolve, reject) => {
    const query1 = "SELECT * FROM championship WHERE name = ?";
    db.query(query1, [name], (error1, result1) => {
      if (error1) {
        return reject(error1);
      } else {
        if (code == result1.code) {
          const query2 = "INSERT INTO studentchampionship (studentid, championshipid) VALUES (?,?)";
          db.query(query2, [id, result1.id], (error2, result2) => {
            if (error2) {
              return reject(error2);
            } else {
              return resolve(result2);
            }
          })
        } else {
          return reject("Os códigos não batem")
        }
      }
    })
  })
}

async function getStudentChampionshipsModel(id) {
  new Promise((resolve, reject) => {
    const query = "SELECT * FROM studentchampionship WHERE studentid = ?";
    db.query(query, [id], (error, result) => {
      if (error) {
        return reject(error);
      } else {
        return resolve(result);
      }
    })
  })
}

module.exports = {
  createChampionshipModel,
  enterChampionshipModel,
  getStudentChampionshipsModel
};
