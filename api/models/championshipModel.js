const db = require("../db");

async function createChampionshipModel(name, participantcode, admcode, id, userType) {
  let championshipId = "";
  new Promise((resolve, reject) => {
    const query1 = "INSERT INTO championship (name, participantcode, admcode) VALUES (?,?,?)";
    db.query(query1, [name, participantcode, admcode], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }

      else if(result1){
        const query2 = "SELECT id FROM championship WHERE name = ?";
        db.query(query2, [id], (error2, result2) => {
          if (error2) {
            return reject(error2)
          }
          else{
            championshipId = result2
          }
        })
      }

      else if (userType == "school") {
        const query3 = "INSERT INTO schoolchampionship (schoolid, championshipid) VALUES (?, ?)";
        db.query(query3, [id, championshipId], (error3, result3)=>{
          if (error3) {
            return reject(error3);
          } else {
            return resolve(result3);
          }
        })
      }

      else{
        const query4 = "INSERT INTO teacherchampionship (teacherid, championshipid) VALUES (?, ?)";
        db.query(query4, [id, championshipId], (error4, result4)=>{
          if (error4) {
            return reject(error4);
          } else {
            return resolve(result4);
          }})
      }
    })
  })
}

async function excludeChampionshipModel(championshipName, id, userType) {
  new Promise((resolve, reject) => {
    
    const query1 = "SELECT id FROM school WHERE name = ?";
    const championshipId = db.query(query1, [championshipName], (error1, result1) => {
      if (error1) {
        return reject(error1);
      }
    })

      const query2 = "DELETE * FROM championshipparticipant WHERE (schoolid, championshipid) VALUES (?, ?)";
      db.query(query2, [id, championshipId], (error2, result2) => {
        if (error2) {
          return reject(error2);
        }
      const query3 = "DELETE FROM championship WHERE id = ?";
      db.query(query3, [championshipId], (error3, result3) => {
        if (error3) {
          return reject(error3);
        }
        else{
          return resolve(result3);
        }
      })
      })
    })
  }

async function searchChampionshipModel(name) {
  new Promise((resolve, reject) => {
    const query = "SELECT * FROM championship WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(error);
      } else {
        return resolve(result);
      }
    })
  })
}

async function enterChampionshipModel(name, code, hierarchyType, id) {
  new Promise((resolve, reject) => {
    const query1 = "SELECT * FROM championship WHERE (name, admcode) VALUES (?,?)";
    const query3 = "SELECT * FROM championship WHERE (name, participantcode) VALUES (?,?)";
    const query2 = "INSERT INTO championshipparticipant (participantId, championshipId, hierarchy) VALUES (?,?,?)";
    if (hierarchyType>2) {
      db.query(query1, [name, code], (error, result) => {
        if(error){
          return reject(error);
        }
        else{
          db.query(query2, [id, result[0][0], hierarchyType], (error2, result2) => {
            if (error2) {
              return reject(error2);
            }
            else{
              return resolve(result2);
            }
          })
        }
      })
    } else {
      db.query(query3, [name, code], (error3, result3)=>{
        if (error3) {
          return reject(error3);
        }
        else{
          db.query(query2, [id, result3[0][0], hierarchyType], (error4, result4)=>{
            if (error4) {
              return reject(error4);
            } else {
              return resolve(result4);
            }
          })
        }
      })
    }
  })
}

async function createChampionshipEventModel(params) {
  
}

async function getYourChampionshipsModel(id) {
  new Promise((resolve, reject) => {
    
  })
}



module.exports = {
  createChampionshipModel,
  searchChampionshipModel,
  enterChampionshipModel,
  createChampionshipEventModel,
  excludeChampionshipModel,
  getYourChampionshipsModel
};
