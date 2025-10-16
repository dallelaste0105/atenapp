const db = require("../db");

// Returns the school row matching the provided school_name.
// Resolves with the first row object if found, rejects with 500 on error or if not found.
async function credentialModelWhichSchool(school_name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM school WHERE name = ?";
    db.query(query, [school_name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

// Inserts a new teacher row with the provided name, email, and password.
// Resolves with 200 on success, rejects with 500 on error.
async function credentialModelTeacherSignup(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO teacher (name, email, password) VALUES (?, ?, ?)";
    db.query(query, [name, email, password], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

// Inserts a new student row with the provided name, email, and password.
// Resolves with 200 on success, rejects with 500 on error.
async function credentialModelStudentSignup(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO student (name, email, password) VALUES (?, ?, ?)";
    db.query(query, [name, email, password], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

async function credentialModelUserSignup(name, email, password) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO user (name, email, password) VALUES (?, ?, ?)";
    db.query(query, [name, email, password], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

// Returns the teacher row matching the provided name.
// Resolves with the first row object if found, rejects with 500 on error or if not found.
async function credentialModelSearchTeacher(name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM teacher WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

// Returns the student row matching the provided name.
// Resolves with the first row object if found, rejects with 500 on error or if not found.
async function credentialModelSearchStudent(name) {
  return new Promise((resolve, reject) => {
    const query = "SELECT * FROM student WHERE name = ?";
    db.query(query, [name], (error, result) => {
      if (error) {
        return reject(500);
      }
      if (result.length > 0) {
        return resolve(result[0]);
      } else {
        return reject(500);
      }
    });
  });
}

// Creates a relation between a school and a teacher using their IDs.
// Resolves with 200 on success, rejects with 500 on error.
async function credentialModelDoSchoolTeacherRelation(school_id, teacher_id) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO schoolteacher (school_id, teacher_id) VALUES (?,?)";
    db.query(query, [school_id, teacher_id], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

// Creates a relation between a school and a student using their IDs.
// Resolves with 200 on success, rejects with 500 on error.
async function credentialModelDoSchoolStudentRelation(school_id, student_id) {
  return new Promise((resolve, reject) => {
    const query = "INSERT INTO schoolstudent (school_id, student_id) VALUES (?,?)";
    db.query(query, [school_id, student_id], (error, result) => {
      if (error) {
        return reject(500);
      }
      else {
        return resolve(200);
      }
    });
  });
}

//-----Login part-----

async function credentialModelMainTableLoginVerification(main_table, name) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM \`${main_table}\` WHERE name = ?`;
    db.query(query, [name], (error, results) => {
      if (error) return reject(500);
      if (results && results.length > 0){return resolve(results[0])}
      else{return reject(501)}
    });
  });
}

async function credentialModelRelationTableLoginVerification(relation_table, relation_id, id) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM \`${relation_table}\` WHERE \`${relation_id}\` = ?`;
    db.query(query, [id], (error, results) => {
      if (error) return reject(500);
      if (results && results.length > 0){return resolve(results[0])}
      else{return reject(501)}
    });
  });
}

async function credentialModelUserSchoolLogin(table, name) {
  return new Promise((resolve, reject) => {
    const query = `SELECT * FROM \`${table}\` WHERE name = ?`;
    db.query(query, [name], (error, results) => {
      if (error) return reject(500);
      if (results && results.length > 0){return resolve(results[0])}
      else{return reject(501)}
    });
  });
}


module.exports = {credentialModelWhichSchool, credentialModelTeacherSignup, credentialModelStudentSignup, credentialModelUserSignup, credentialModelSearchTeacher, credentialModelSearchStudent, credentialModelDoSchoolTeacherRelation, credentialModelDoSchoolStudentRelation,
  credentialModelMainTableLoginVerification, credentialModelRelationTableLoginVerification,credentialModelUserSchoolLogin
};