const db = require("../config");

//verify if user exist yet
async function userExist(name) {
    return new Promise((resolve, reject) => {
        let userExistList = [];

        //just try find a user with the same name
        const queryOne = "SELECT name FROM user WHERE name = ?";
        const queryTwo = "SELECT name FROM student WHERE name = ?";
        const queryThree = "SELECT name FROM teacher WHERE name = ?";
        const queryFour = "SELECT name FROM school WHERE name = ?";

        //execute all querys, if user exist, userExistList recive the name
        db.query(queryOne, [name], (error, result) => {
            if (error) {
                userExistList.push(null);
            }
            userExistList.push(result);
        });
        db.query(queryTwo, [name], (error, result) => {
            if (error) {
                userExistList.push(null);
            }
            userExistList.push(result);
        });
        db.query(queryThree, [name], (error, result) => {
            if (error) {
                userExistList.push(null);
            }
            userExistList.push(result);
        });
        db.query(queryFour, [name], (error, result) => {
            if (error) {
                userExistList.push(null);
            }
            userExistList.push(result);
        });
        return resolve(userExistList);
    });
}

//verify whitch school and user type based in code
async function whitchSchoolAndUserType(code) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT id FROM school WHERE studentcode = ?";
        const query2 = "SELECT id FROM school WHERE teachercode = ?";
        db.query(query1, [code], (error1, result1) => {
            db.query(query2, [code], (error2, result2) => {
                if (error1 && error2) {
                    return reject(false);
                }
                else if (result1.length>0) {
                    return resolve(["student",result1]);
                }
                return resolve(["teacher",result2]);
            })
        })
    })
}

//a main function to do signup for all type of users
async function signup(name, password, userType) {
    return new Promise((resolve, reject) => {
        const query1 = "INSERT INTO user (name, password) VALUES (?, ?)";
        const query2 = "INSERT INTO student (name, password) VALUES (?, ?)";
        const query3 = "INSERT INTO teacher (name, password) VALUES (?, ?)";
        const query4 = "INSERT INTO school (name, password) VALUES (?, ?)";

        //query to verify if is a valid school
        const query5 = "SELECT schoolcode FROM schoolcode WHERE schoolcode = ?";

        //query's to do the relation between the tables
        if (userType == "user") {
            return db.query(query1, [name, password], (err) => {
            if (err) return reject(err);
            return resolve(true);
        });
        }

        if (userType == "student") {
            return db.query(query2, [name, password], (err) => {
                if (err) return reject(err);
                return resolve(true);
            });
        }

        if (userType == "teacher") {
            return db.query(query3, [name, password], (err) => {
                if (err) return reject(err);
                return resolve(true);
            });
        }

        if (userType == "school") {
            return db.query(query4, [name, password], (err) => {
                if (err) return reject(err);
                return resolve(true);
            });
        }
    })
}

async function findUser(name) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT * FROM user WHERE name=?";
        const query2 = "SELECT * FROM student WHERE name=?";
        const query3 = "SELECT * FROM teacher WHERE name=?";
        const query4 = "SELECT * FROM school WHERE name=?";
        
        db.query(query1, [name], (error1, result1) => {
            if (!error1 && result1.length > 0) return resolve(["user", result1]);

            db.query(query2, [name], (error2, result2) => {
                if (!error2 && result2.length > 0) return resolve(["student", result2]);

                db.query(query3, [name], (error3, result3) => {
                    if (!error3 && result3.length > 0) return resolve(["teacher", result3]);

                    db.query(query4, [name], (error4, result4) => {
                        if (!error4 && result4.length > 0) return resolve(["school", result4]);
                        return reject(false);
                    });
                });
            });
        });
    });
}

async function saveUserFCMTokenModel(id, userType, FCM) {
    return new Promise((resolve, reject) => {
        const query1 = "INSERT INTO userDevices (userId, FCMToken) VALUES (?,?)";
        db.query(query1, [id, FCM], (error1, result1) => {
            if (error1) {
                return reject(false);
            }
            return resolve(true);
        })
    })
}

async function verifyUserFCMTokenModel(id, userType) {
    return new Promise((resolve, reject) => {
        const query1 = "SELECT FCMToken FROM userDevices WHERE userId = ?";
        db.query(query1, [id], (error1, result1) => {
            if (error1) {
                return reject(false);
            }
            return resolve(result1);
        })
    })
}

module.exports = {
    userExist,
    whitchSchoolAndUserType,
    signup,
    findUser,
    saveUserFCMTokenModel,
    verifyUserFCMTokenModel
}