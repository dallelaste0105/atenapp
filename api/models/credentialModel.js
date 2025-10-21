const db = require("../db");

async function credentialModelWhichSchool(school_name) {
    return new Promise((resolve, reject) => {
        const query = "SELECT * FROM school WHERE name = ?";
        db.query(query, [school_name], (error, result) => {
            if (error) {
                return reject(error);
            }
            return resolve(result && result.length > 0 ? result[0] : null);
        });
    });
}

async function credentialModelTeacherSignup(name, email, password) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO teacher (name, email, password) VALUES (?, ?, ?)";
        db.query(query, [name, email, password], (error, result) => {
            if (error) {
                console.error('credentialModelTeacherSignup error:', error);
                return reject(error);
            }
            return resolve(result);
        });
    });
}

async function credentialModelStudentSignup(name, email, password) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO student (name, email, password) VALUES (?, ?, ?)";
        db.query(query, [name, email, password], (error, result) => {
            if (error) {
                console.error('credentialModelStudentSignup error:', error);
                return reject(error);
            }
            return resolve(result);
        });
    });
}

async function credentialModelUserSignup(name, email, password) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO user (name, email, password) VALUES (?, ?, ?)";
        db.query(query, [name, email, password], (error, result) => {
            if (error) {
                console.error('credentialModelUserSignup error:', error);
                return reject(error);
            }
            return resolve(result);
        });
    });
}

async function credentialModelSearchTeacher(name) {
    return new Promise((resolve, reject) => {
        const query = "SELECT * FROM teacher WHERE name = ?";
        db.query(query, [name], (error, result) => {
            if (error) {
                console.error('credentialModelSearchTeacher error:', error);
                return reject(error);
            }
            return resolve(result && result.length > 0 ? result[0] : null);
        });
    });
}

async function credentialModelSearchStudent(name) {
    return new Promise((resolve, reject) => {
        const query = "SELECT * FROM student WHERE name = ?";
        db.query(query, [name], (error, result) => {
            if (error) {
                console.error('credentialModelSearchStudent error:', error);
                return reject(error);
            }
            return resolve(result && result.length > 0 ? result[0] : null);
        });
    });
}

async function credentialModelDoSchoolTeacherRelation(school_id, teacher_id) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO schoolteacher (school_id, teacher_id) VALUES (?,?)";
        db.query(query, [school_id, teacher_id], (error, result) => {
            if (error) {
                console.error('credentialModelDoSchoolTeacherRelation error:', error);
                return reject(error);
            }
            return resolve(result);
        });
    });
}

async function credentialModelDoSchoolStudentRelation(school_id, student_id) {
    return new Promise((resolve, reject) => {
        const query = "INSERT INTO schoolstudent (school_id, student_id) VALUES (?,?)";
        db.query(query, [school_id, student_id], (error, result) => {
            if (error) {
                console.error('credentialModelDoSchoolStudentRelation error:', error);
                return reject(error);
            }
            return resolve(result);
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


module.exports = {credentialModelWhichSchool, credentialModelTeacherSignup, credentialModelStudentSignup, credentialModelUserSignup, credentialModelSearchTeacher, credentialModelSearchStudent, credentialModelDoSchoolTeacherRelation, credentialModelDoSchoolStudentRelation,
  credentialModelMainTableLoginVerification, credentialModelRelationTableLoginVerification,
};