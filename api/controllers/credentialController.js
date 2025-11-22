const credentialModel = require("../models/credentialModel");
const leagueModel = require("../models/leagueModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();


function createJwt(id, userType) {
    const createdJwt = jwt.sign({ id : id , userType : userType}, process.env.JWT_SECRET, { expiresIn: "24h" });
    return createdJwt;
}

async function credentialControllerSignup(req, res) {
    const { name, email, password, schoolName, yourCode } = req.body;
    
    try {
        if (!name || !email || !password) {
            return res.status(500).json({ message: 'Campos obrigatórios faltando!' });
        }
        else if (schoolName && !yourCode) {
            return res.status(500).json({ message: 'Você precisa de um código!' });
        }
        else if(!schoolName && yourCode){
            return res.status(500).json({ message: 'Todo código tem uma escola!' });
        }
        else if(await credentialModel.credentialModelMainTableLoginVerification('user', name) || await credentialModel.credentialModelMainTableLoginVerification('student', name) || await credentialModel.credentialModelMainTableLoginVerification('teacher', name) || await credentialModel.credentialModelMainTableLoginVerification('school', name)){
            return res.status(500).json({message:"Já existe um usuário com esse nome"});
        }

        const bcrypt_password = await bcrypt.hash(password, 10);
        let school = await credentialModel.credentialModelWhichSchool(schoolName);

        if (!school && !schoolName && !yourCode) {
            const ok = await credentialModel.credentialModelUserSignup(name, email, bcrypt_password);
            const userId = await credentialModel.selectId(name, "user");
            const leagueId = await leagueModel.existLeagues("Iron")
            if (!leagueId) {
                await leagueModel.createNewLeague("Iron");
                const newLeagueId = await leagueModel.existLeagues("Iron");
                await leagueModel.addUserLeague(userId, newLeagueId);
            }
            else{
                await leagueModel.addUserLeague(userId, leagueId);
            }
                
            
            
            if (ok) return res.status(200).json({ message: 'Usuário cadastrado com sucesso!' });
            return res.status(500).json({ message: 'Problemas ao cadastrar usuário' });
        }
        if (!school) {
            return res.status(500).json({message:"Nome e/ou código de escola inválido(s)"});
        }


        if (yourCode === school.teachercode) {
            await credentialModel.credentialModelTeacherSignup(name, email, bcrypt_password);
            const teacher = await credentialModel.credentialModelSearchTeacher(name);
            await credentialModel.credentialModelDoSchoolTeacherRelation(school.id, teacher.id);
            return res.status(200).json({ message: 'Professor cadastrado com sucesso!' });
        }

        if (yourCode === school.studentcode) {
            await credentialModel.credentialModelStudentSignup(name, email, bcrypt_password);
            const student = await credentialModel.credentialModelSearchStudent(name);
            await credentialModel.credentialModelDoSchoolStudentRelation(school.id, student.id);
            const studentId = await credentialModel.selectId(name, "student");
            const leagueId = await leagueModel.existLeagues("Iron")
            if (!leagueId) {
                await leagueModel.createNewLeague("Iron");
                const newLeagueId = await leagueModel.existLeagues("Iron");
                await leagueModel.addUserLeague(studentId, newLeagueId);
            }
            else{
                await leagueModel.addUserLeague(studentId, leagueId);
            }
            return res.status(200).json({ message: 'Aluno cadastrado com sucesso!' });
        }

        if (name == credentialModel.credentialModelSchoolSignup) {
            
        }

        return res.status(500).json({ message: 'Código inválido!' });
    } catch (error) {
        console.error('credentialControllerSignup error:', error);
        return res.status(500).json({ message: 'Erro no servidor' });
    }
}   

async function credentialControllerLogin(req, res) {
    const { name, password, userType } = req.body;
   
    try {
        if (!name || !password || !userType) {
            return res.status(500).json({ message: 'Campos obrigatórios faltando!' });
        }

        if (userType === "user") {
            const user = await credentialModel.credentialModelMainTableLoginVerification("user", name);
            if (!user){
                return res.status(500).json({ message: 'Usuário não encontrado' });
            }
            const passwordMatch = await bcrypt.compare(password, user.password);
            if (passwordMatch) {
                const createdJwt = createJwt(user.id, userType);
                return res.status(200).json({message:"userLogin" , token: createdJwt }); 
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        if (userType === "student") {
            const student = await credentialModel.credentialModelMainTableLoginVerification("student", name);
            if (!student) return res.status(500).json({ message: 'Estudante não encontrado' });
            
            const passwordMatch = await bcrypt.compare(password, student.password);
            if (passwordMatch) {
                const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolstudent", "student_id", student.id);
                const createdJwt = createJwt(student.id, userType);
                return res.status(200).json({message:"studentLogin" , token: createdJwt });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        if (userType === "teacher") {
            const teacher = await credentialModel.credentialModelMainTableLoginVerification("teacher", name);
            if (!teacher) return res.status(500).json({ message: 'Professor não encontrado' });
            
            const passwordMatch = await bcrypt.compare(password, teacher.password);
            if (passwordMatch) {
                const createdJwt = createJwt(teacher.id, userType);   // <-- ERRO: passando 'school.id'
                return res.status(200).json({message:"teacherLogin" , token: createdJwt });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }


        return res.status(500).json({ message: 'Os dados não batem' });
    } catch (error) {
        console.error('credentialControllerLogin error:', error);
        return res.status(500).json({ message: 'Erro no servidor' });
    }
}

async function schoolSignupCredentialController(req, res) {
  const { name, email, password, schoolCode, teacherCode, studentCode } = req.body;

  try {
    if (!name || !email || !password || !schoolCode || !teacherCode || !studentCode) {
        return res.status(400).json({ message: 'Campos obrigatórios faltando!' });
    }
    else if(schoolCode == teacherCode){
        return res.status(500).json({message:"Os códigos de aluno e professor não podem ser iguais"});
    }

    const existSchool = await credentialModel.verifyExistSchool(name);
    if (existSchool) {
      return res.status(400).json({ message: "A escola já existe!" });
    }

    const existCode = await credentialModel.verifySchoolCodeExist(schoolCode);
    if (!existCode) {
      return res.status(400).json({ message: "O código da escola não existe!" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const signupResult = await credentialModel.schoolSignup(name, email, hashedPassword, teacherCode, studentCode);
    if (signupResult) {
      return res.status(200).json({ message: "Escola cadastrada com sucesso" });
    } else {
      return res.status(500).json({ message: "Erro ao cadastrar escola" });
    }
  } catch (error) {
    console.error('schoolSignupCredentialController error:', error);
    return res.status(500).json({ message: 'Erro no servidor' });
  }
}

async function schoolLoginCredentialController(req, res) {
    const { name, password } = req.body;
    const userType = "school";

    try {
        if (!name || !password) {
            return res.status(500).json({ message: "Campos obrigatórios faltando!" });
        }

        const school = await credentialModel.credentialModelMainTableLoginVerification("school", name);

        if (!school) {
            return res.status(500).json({ message: "Escola não encontrada" });
        }

        const passwordMatch = await bcrypt.compare(password, school.password);
        if (!passwordMatch) {
            return res.status(500).json({ message: "Credenciais inválidas" });
        }

        const token = createJwt(school.id, userType);

        return res.status(200).json({
            message: "Escola fez login com sucesso",
            token: token
        });
    } catch (error) {
        console.error("schoolLoginCredentialController error:", error);
        return res.status(500).json({ message: "Erro no servidor" });
    }
}


module.exports = { credentialControllerSignup, credentialControllerLogin,
    schoolSignupCredentialController, schoolLoginCredentialController,
    
};