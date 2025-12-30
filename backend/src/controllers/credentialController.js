const db = require("../models/credentialModel");
const bCrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

//main function to decide if data is valid and do the respective signup
async function signupController(req, res) {
    const {name, noEncriptedPassword, code} = req.body;
    const password = await bCrypt.hash(noEncriptedPassword, 10);
    console.log(name, password);
    try {
        //verify null data and if exist users with the same data yet
        if (!name || !noEncriptedPassword) {
            return res.status(500).json({ok:false, msg:"Preencha todos os campos"});
        }
        const userExist = await db.userExist(name);
        if(userExist.length>0){
            return res.status(500).json({ok:false, msg:"Este usuário já existe"});
        }

        //do user signup
        if (!code) {
            const userSignup = await db.signup(name, password, "user");
            console.log(userSignup);
            if (userSignup) {
                console.log(res);
                return res.status(200).json({ok:true, msg:"Cadastro como usuário realizado com sucesso"});
            }
            console.log(res);
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como usuário"});
        }

        //verify whitch school is the code and what is user type
        const whitchSchoolAndUserType = await db.whitchSchoolAndUserType(code);
        
        //do student signup
        if(whitchSchoolAndUserType[0]=="student"){
            const studentSignup = await db.signup(name, password, whitchSchoolAndUserType[0]);
            if (studentSignup) {
                return res.status(200).json({ok:true, msg:"Cadastro como aluno realizado com sucesso"});
            }
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como estudante"});
        }

        //do teacher signup
        else if(whitchSchoolAndUserType[0]=="teacher"){
            const teacherSignup = await db.signup(name, password, whitchSchoolAndUserType[0]);
            if (teacherSignup) {
                return res.status(200).json({ok:true, msg:"Cadastro como professor realizado com sucesso"});
            }
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como professor"});
        }

        //do school signup
        else{
            const schoolSignup = await db.signup(name, password, "school");
            if (schoolSignup) {
                return res.status(200).json({ok:true, msg:"Cadastro como escola realizado com sucesso"});
            }
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como escola"});
        }
        
    } catch (error) {
        return res.status(500).json({ok:false, msg:"Erro crítico"});
    }
    
}

async function loginController(req, res) {
    const {name, noEncriptedPassword} = req.body;
    try {
        const user = await db.findUser(name);
        const userDatabasePassword = user[1][0]["password"]; 
        const passwordOk = await bCrypt.compare(noEncriptedPassword, userDatabasePassword);
        if (passwordOk) {
            const token = jwt.sign({id: user[1][0]["id"], userType: user[0]}, process.env.DB_NAME, {expiresIn: "7d"});
            return res.status(200).json({ok: true, msg: "Login realizado com sucesso", jwt: token});
        }
        return res.status(500).json({ok: false, msg: "Senha incorreta"});
    } catch (error) {
        return res.status(500).json({ok: false, msg: "Usuário não encontrado"});
    }
}

async function saveUserFCMTokenController(req, res) {
    const {FCMToken} = req.body;
    const {id, userType} = req.user;
    try {
        const ok = await db.saveUserFCMTokenModel(id, userType, FCMToken);
        if (ok) {
            return res.status(200).json({ok:true, msg:"FCM salvo com sucesso"});
        }
        return res.status(500).json({ok:false, msg:"FCM não pode ser salvo"});
    } catch (error) {
        return res.status(500).json({ok:false, msg:"Erro crítico"});
    }
}

async function verifyUserFCMTokenController(req, res) {
    const {id, userType} = req.user;
    try {
        const FCM = await db.verifyUserFCMTokenModel(id, userType);
        if (FCM != null) {
                return res.status(200).json({ok:true, msg:FCM});
            }
            return res.status(500).json({ok:false, msg:"FCM não pode ser encontrado"});
    } catch (error) {
        return res.status(500).json({ok:false, msg:"Erro crítico"});
    }
}

module.exports = {
    signupController,
    loginController,
    saveUserFCMTokenController,
    verifyUserFCMTokenController
}