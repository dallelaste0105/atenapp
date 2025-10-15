const db = require("../db");

async function IsSchool(cod) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM Schools WHERE cod = ?";
    db.query(query, [cod], (error, result) => {
      if (error) {
        return reject(error);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject("School was not find");
      }
    });
  });
}

async function IsTeacher(name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM TeacherSchools WHERE name = ? AND cod = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(error);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject("Student");
      }
    });
  });
}

async function SignUp(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO users name = ?..."//esse comando esta errado;
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(error);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject("Student");
      }
    });
  });
}



module.exports = {IsSchool, IsTeacher};