const db = require("../config");

async function userExist(name) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT name FROM user WHERE name = ?";
        db.query(query1, [name], (err, res) => {
            if (!err && res && res.length > 0) return resolve(res);
            const query2 = "SELECT name FROM student WHERE name = ?";
            db.query(query2, [name], (err, res) => {
                if (!err && res && res.length > 0) return resolve(res);
                const query3 = "SELECT name FROM teacher WHERE name = ?";
                db.query(query3, [name], (err, res) => {
                    if (!err && res && res.length > 0) return resolve(res);
                    const query4 = "SELECT name FROM school WHERE name = ?";
                    db.query(query4, [name], (err, res) => {
                        if (!err && res && res.length > 0) return resolve(res);
                        return resolve([]);
                    });
                });
            });
        });
    });
}

async function whitchSchoolAndUserType(code) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT id FROM school WHERE studentcode = ?";
        const query2 = "SELECT id FROM school WHERE teachercode = ?";

        db.query(query1, [code], (error1, result1) => {
            if (error1) return reject(error1);

            db.query(query2, [code], (error2, result2) => {
                if (error2) return reject(error2);

                if (result1.length > 0) return resolve(["student", result1]);
                if (result2.length > 0) return resolve(["teacher", result2]);

                return resolve(false);
            });
        });
    });
}


async function signup(name, password, userType) {
    return new Promise((resolve, reject) => {
        const query1 = "INSERT INTO user (name, password) VALUES (?, ?)";
        const query2 = "INSERT INTO student (name, password) VALUES (?, ?)";
        const query3 = "INSERT INTO teacher (name, password) VALUES (?, ?)";
        const query4 = "INSERT INTO school (name, password) VALUES (?, ?)";
        let query = "";
        if (userType == "user") query = query1;
        else if (userType == "student") query = query2;
        else if (userType == "teacher") query = query3;
        else if (userType == "school") query = query4;

        db.query(query, [name, password], (err) => {
            if (err) { return reject(err); }
            return resolve(true);
        });
    })
}

async function findUser(name) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT * FROM user WHERE name=?";
        const query2 = "SELECT * FROM student WHERE name=?";
        const query3 = "SELECT * FROM teacher WHERE name=?";
        const query4 = "SELECT * FROM school WHERE name=?";
        
        db.query(query1, [name], (error1, result1) => {
            if (!error1 && result1 && result1.length > 0) return resolve(["user", result1]);
            db.query(query2, [name], (error2, result2) => {
                if (!error2 && result2 && result2.length > 0) return resolve(["student", result2]);
                db.query(query3, [name], (error3, result3) => {
                    if (!error3 && result3 && result3.length > 0) return resolve(["teacher", result3]);
                    db.query(query4, [name], (error4, result4) => {
                        if (!error4 && result4 && result4.length > 0) return resolve(["school", result4]);
                        return reject(false);
                    });
                });
            });
        });
    });
}

async function LARCARCODIGOESTUDANTE(id, cod) {
    return new Promise((resolve, reject) => {
        const queryOne = "UPDATE school SET studentcode = ? WHERE id = ?";
        db.query(queryOne, [cod, id], (errorOne, resultOne) => {
            if (errorOne) return reject(false);
            if (resultOne.affectedRows > 0) return resolve(true);
            return resolve(false);
        })
    })
}

async function LARCARCODIGOPROFESSOR(id, cod) {
    return new Promise((resolve, reject) => {
        const queryOne = "UPDATE school SET teachercode = ? WHERE id = ?";
        db.query(queryOne, [cod, id], (errorOne, resultOne) => {
            if (errorOne) return reject(false);
            if (resultOne.affectedRows > 0) return resolve(true);
            return resolve(false);
        })
    })
}

async function validSchool(code){
    return new Promise((resolve, reject) => {
        const queryOne = "SELECT schoolcode FROM schoolcode WHERE schoolcode = ?";
        db.query(queryOne, [code], (errorOne, resultOne) => {
            if (errorOne) return reject(false);
            if (resultOne && resultOne.length > 0) return resolve(true);
            return resolve(false);
        })
    })
}

async function sendNotificationModel(schoolId) {
    return new Promise((resolve, reject) => {
        const query = `
            SELECT ud.FCMToken 
            FROM userDevices ud
            JOIN student s ON ud.userId = s.id
            WHERE s.schoolId = ? AND ud.userType = 'student'
        `;
        db.query(query, [schoolId], (err, results) => {
            if (err) {return reject(err); }
            const tokens = results.map(row => row.FCMToken);
            resolve(tokens);
        });
    })
}

async function saveUserFCMTokenModel(id, userType, FCM) {
    return new Promise((resolve, reject) => {
        const query = `
            INSERT INTO userDevices (userId, userType, FCMToken) 
            VALUES (?, ?, ?) 
            ON DUPLICATE KEY UPDATE FCMToken = VALUES(FCMToken)
        `;
        
        db.query(query, [id, userType, FCM], (error, result) => {
            if (error) {
                return reject(false);
            }
            return resolve(true);
        })
    })
}

async function verifyUserFCMTokenModel(id, userType) {
    return new Promise((resolve, reject) => {
        const query = "SELECT FCMToken FROM userDevices WHERE userId = ? AND userType = ?";
        db.query(query, [id, userType], (error, result) => {
            if (error) return reject(false);
            if (result && result.length > 0) return resolve(result[0].FCMToken);
            return resolve(null);
        })
    })
}

module.exports = {
    userExist, whitchSchoolAndUserType, signup, findUser, validSchool,
    saveUserFCMTokenModel, verifyUserFCMTokenModel,
    LARCARCODIGOESTUDANTE, LARCARCODIGOPROFESSOR, sendNotificationModel
}