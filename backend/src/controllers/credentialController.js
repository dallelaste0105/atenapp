const db = require("../models/credentialModel");
const bCrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const admin = require("firebase-admin");
const serviceAccount = require("../serviceAccountKey.json"); 

if (!admin.apps.length) {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });
}

async function signupController(req, res) {
    let {name, noEncriptedPassword, code} = req.body;
    if(name) name = name.trim(); 

    const password = await bCrypt.hash(noEncriptedPassword, 10);
    console.log(name, password);
    try {
        if (!name || !noEncriptedPassword) {
            return res.status(500).json({ok:false, msg:"Preencha todos os campos"});
        }
        const userExist = await db.userExist(name);
        if(userExist.length>0){
            return res.status(500).json({ok:false, msg:"Este usuário já existe"});
        }

        if (!code) {
            const userSignup = await db.signup(name, password, "user");
            if (userSignup) return res.status(200).json({ok:true, msg:"Cadastro como usuário realizado com sucesso"});
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como usuário"});
        }

        const whitchSchoolAndUserType = await db.whitchSchoolAndUserType(code);

        if (whitchSchoolAndUserType === false) {
            const ok = await db.validSchool(code);
            if (ok) {
                const schoolSignup = await db.signup(name, password, "school");
                if (schoolSignup) return res.status(200).json({ok:true, msg:"Cadastro como escola realizado com sucesso"});
                return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como escola"});
            }
            return res.status(500).json({ok:false, msg:"Código inválido"});
        }

        if (whitchSchoolAndUserType[0] === "student") {
            const studentSignup = await db.signup(name, password, "student");
            if (studentSignup) return res.status(200).json({ok:true, msg:"Cadastro como aluno realizado com sucesso"});
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como estudante"});
        }

        if (whitchSchoolAndUserType[0] === "teacher") {
            const teacherSignup = await db.signup(name, password, "teacher");
            if (teacherSignup) return res.status(200).json({ok:true, msg:"Cadastro como professor realizado com sucesso"});
            return res.status(500).json({ok:false, msg:"Erro ao realizar o cadastro como professor"});
        }

        
    } catch (error) {
    console.error("[SIGNUP ERROR]", error);
    return res.status(500).json({ok:false, msg:"Erro crítico"});
    }
}

async function loginController(req, res) {
    let { name, noEncriptedPassword } = req.body;
    if (name) name = name.trim();

    try {
        const result = await db.findUser(name);
        if (!result || !result[1] || result[1].length === 0) {
            return res.status(404).json({ ok: false, msg: "Usuário não encontrado" });
        }

        const userType = result[0];
        const userData = result[1][0];
        const userDatabasePassword = userData["password"];

        const passwordOk = await bCrypt.compare(noEncriptedPassword, userDatabasePassword);

        if (passwordOk) {
            const token = jwt.sign(
                { id: userData["id"], userType: userType },
                process.env.JWT_SECRET,
                { expiresIn: "7d" }
            );

            return res.status(200).json({
                ok: true,
                jwt: token,
                user: {
                    id: userData["id"],
                    name: userData["name"],
                    type: userType
                }
            });
        }

        return res.status(401).json({ ok: false, msg: "Senha incorreta" });

    } catch (error) {
        console.error(error);
        return res.status(500).json({ ok: false, msg: "Erro interno no servidor" });
    }
}

async function LARCARCODIGOESTUDANTE(req, res) {
    const {id, userType} = req.user;
    const {cod} = req.body;
    try {
        const ok = await db.LARCARCODIGOESTUDANTE(id, cod);
        if (ok) return res.status(200).json({ok:true, msg:"Código de estudante criado com sucesso"});
        return res.status(500).json({ok:false, msg:"Erro ao criar código de estudante"});
    } catch (error) { return res.status(500).json({ok:false, msg:"Erro crítico"}); }
}

async function LARCARCODIGOPROFESSOR(req, res) {
    const {id, userType} = req.user;
    const {cod} = req.body;
    try {
        const ok = await db.LARCARCODIGOPROFESSOR(id, cod);
        if (ok) return res.status(200).json({ok:true, msg:"Código de professor criado com sucesso"});
        return res.status(500).json({ok:false, msg:"Erro ao criar código de professor"});
    } catch (error) { return res.status(500).json({ok:false, msg:"Erro crítico"}); }
}

async function sendNotificationController(req, res) {
    const {id, userType} = req.user; 
    try {
        const usersTokens = await db.sendNotificationModel(id);
        if (!usersTokens || usersTokens.length === 0) {
             return res.status(200).json({ok:false, msg:"Nenhum aluno com token encontrado para esta escola."});
        }

        const message = {
            notification: {
                title: 'Aviso da Escola',
                body: 'Teste de notificação enviado agora!'
            },
            tokens: usersTokens,
        };
        const response = await admin.messaging().sendEachForMulticast(message);
        if (response.failureCount > 0) {
            const failedTokens = [];
            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    console.log(`[DEBUG FIREBASE] Erro no token ${idx}:`, resp.error);
                }
            });
        }
        return res.status(200).json({ok:true, msg:`Enviado: ${response.successCount}, Falhas: ${response.failureCount}`});
    } catch (error) {
        return res.status(500).json({ok:false, msg:"Erro ao enviar notificação"});
    }
}

async function saveUserFCMTokenController(req, res) {
    if (!req.user) {
        return res.status(401).json({ok:false, msg:"Token inválido ou não enviado"});
    }

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
        if (FCM != null) return res.status(200).json({ok:true, msg:FCM});
        return res.status(500).json({ok:false, msg:"FCM não pode ser encontrado"});
    } catch (error) {
        return res.status(500).json({ok:false, msg:"Erro crítico"});
    }
}

module.exports = {
    signupController,
    loginController,
    saveUserFCMTokenController,
    verifyUserFCMTokenController,
    LARCARCODIGOESTUDANTE,
    LARCARCODIGOPROFESSOR,
    sendNotificationController
}