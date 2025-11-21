const db = require("../db");

async function createClass(name, teachercode, studentcode, schoolcode) {
    return new Promise((resolve, reject) => { 
        const query = "INSERT INTO class (name, teachercode, studentcode, schoolcode) VALUES (?,?,?,?)";
        db.query(query, [name, teachercode, studentcode, schoolcode], (error, result) => {
            if (error) {
                return resolve(false);
            } else {
                return resolve(true);
            }
        })
    })
}

async function enterClass(name, code, userId) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT id FROM class WHERE name = ?";
        const classId = db.query(query1, [name], (error1, result1) => {
            if (error1) {
                return reject(error1);
            }
        })

        const query2 = "SELECT * FROM class WHERE id = ?"
        const selectedClass = db.query(query2, [classId], (error2, result2) => {
            if (error2) {
                return reject(error2);
            }
        })


        const query3 = "INSERT INTO teacherclass (teacherid, classid) VALUES (?,?)";
        const query4 = "INSERT INTO studentclass (studentid, classid) VALUES (?,?)";
        if (code == selectedClass[0]["teachercode"]) {
            db.query(query3, [userId, classId], (error3, result3) => {
                if (error3) {
                    return reject(error3);
                } else {
                    return resolve(result3);
                }
            })
        }

        else if (code == selectedClass[0]["studentcode"]) {
            db.query(query4, [userId, classId], (error4, result4) => {
                if (error4) {
                    return reject(error4);
                } else {
                    return resolve(result4);
                }
            })
        }
        else{
            return reject(error);
        }

    })
}

async function getSchoolClass(userId, userType) {
    return new Promise((resolve, reject) => {
        if (userType == "student") {
            const query = "SELECT classid FROM studentclass WHERE studentid = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
            })
            const query2 = "SELECT name FROM class WHERE id = ?";
            db.query(query2, [classesId], (error, result) => {
                if (error) {
                    return reject(error);
                } else {
                    return resolve(result);
                }
            })
        }

        else if (userType == "teacher") {
            const query = "SELECT classid FROM teacherclass WHERE teacherid = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
            })
            const query2 = "SELECT name FROM class WHERE id = ?";
            db.query(query2, [classesId], (error, result) => {
                if (error) {
                    return reject(error);
                } else {
                    return resolve(result);
                }
            })
        }

        else if (userType == "school"){
            const query = "SELECT name FROM class WHERE schoolcode = ?";
            const classesId = db.query(query, [userId], (error, result) => {
                if (error) {
                    return reject(error);
                }
                else{
                    return resolve(result);
                }
            })
        }

        else{
            return reject(error);
        }
    })
}

module.exports = {
    createClass,
    enterClass,
    getSchoolClass
}