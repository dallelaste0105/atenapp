const credentialModel = require("../models/credentialModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

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
        else if(await credentialModelMainTableLoginVerification('user', name) || await credentialModelMainTableLoginVerification('student', name) || await credentialModelMainTableLoginVerification('teacher', name)){
            res.status(500).json({message:"Já existe um usuário com esse nome"})
        }

        const bcrypt_password = await bcrypt.hash(password, 10);
        let school = await credentialModel.credentialModelWhichSchool(schoolName);

        if (!school) {
            const ok = await credentialModel.credentialModelUserSignup(name, email, bcrypt_password);
            if (ok) return res.status(200).json({ message: 'Usuário cadastrado com sucesso!' });
            return res.status(500).json({ message: 'Problemas ao cadastrar usuário' });
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
            return res.status(200).json({ message: 'Aluno cadastrado com sucesso!' });
        }

        return res.status(400).json({ message: 'Código inválido!' });
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
                return res.status(200).json({ message: "Usuário fez login com sucesso" });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        if (userType === "student") {
            const student = await credentialModel.credentialModelMainTableLoginVerification("student", name);
            if (!student) return res.status(500).json({ message: 'Estudante não encontrado' });
            
            const passwordMatch = await bcrypt.compare(password, student.password);
            if (passwordMatch) {
                const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolstudent", "student_id", student.id);
                return res.status(200).json({ student_id: student.id, school_id: school.school_id });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        if (userType === "teacher") {
            const teacher = await credentialModel.credentialModelMainTableLoginVerification("teacher", name);
            if (!teacher) return res.status(500).json({ message: 'Professor não encontrado' });
            
            const passwordMatch = await bcrypt.compare(password, teacher.password);
            if (passwordMatch) {
                const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolteacher", "teacher_id", teacher.id);
                return res.status(200).json({ teacher_id: teacher.id, school_id: school.school_id });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        if (userType === "school") {
            const school = await credentialModel.credentialModelMainTableLoginVerification("school", name);
            if (!school) return res.status(500).json({ message: 'Escola não encontrada' });
            
            const passwordMatch = await bcrypt.compare(password, school.password);
            if (passwordMatch) {
                return res.status(200).json({ message: school.id });
            }
            return res.status(500).json({ message: 'Credenciais inválidas' });
        }

        return res.status(500).json({ message: 'Os dados não batem' });
    } catch (error) {
        console.error('credentialControllerLogin error:', error);
        return res.status(500).json({ message: 'Erro no servidor' });
    }
}

module.exports = { credentialControllerSignup, credentialControllerLogin };