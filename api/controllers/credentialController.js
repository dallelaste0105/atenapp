const credentialModel = require("../models/credentialModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function credentialControllerSignup(req, res) {
    const {name, email, password, school_name, your_code} = req.body;//store request values
    
    try{
      const whichSchool = await credentialModel.whichSchool(school_name);//check which school it is
      const school_id = whichSchool.id;//save the school's id
      const teacher_code = whichSchool.teachercode;//save the school's teacher code
      const student_code = whichSchool.studentcode;//save the school's student code

      if (teacher_code == your_code) {//check if it's a teacher
        const bcrypt_password = await bcrypt.hash(password, 10);//hash the password
        await credentialModel.teacherSignup(name, email, bcrypt_password);//insert into teacher table
        const teacher = await credentialModel.searchTeacher(name);//create an object from teacher table
        await credentialModel.doSchoolTeacherRelation(school_id, teacher.id);//insert the ids into the relation table
        res.status(200).json({message: "credentialControllerSignup200"});
      }

      if (student_code == your_code) {//check if it's a student
        const bcrypt_password = await bcrypt.hash(password, 10);
        await credentialModel.studentSignup(name, email, bcrypt_password)//insert into student table
        const student = await credentialModel.searchStudent(name);//create an object from student table
        await credentialModel.doSchoolStudentRelation(school_id, teacher.id);//insert the ids into the relation table
        res.status(200).json({message: "credentialControllerSignup201"});
      }

      else{
        const bcrypt_password = await bcrypt.hash(password, 10);
        await credentialModelUserSignup(name, email, bcrypt_password);
        res.status(200).json({message: "credentialControllerSignup201"});
      }
    }

    catch{
        res.status(200).json({message: "credentialControllerSignup500"});
    }
};

/*
-verifica se é de fato um aluno/professor/escola/usuário
-verificar qual escola é (armazena o id)
-procura na tabela de relação
-verifica na tabela aluno/professor pra ver se a senha tá certa
*/
async function credentialControllerLogin(req, res) {
  const {name, password, user_type} = req.body;//A VERIFICAÇÃO SE É ALUNO/PROFESSOR/ESCOLA DEVE SER FEITA AINDA NO CONNECTIONS(FUNÇÃO DIFERENTE PRA CADA UMA [CADA UMA CHAMADA POR UM BOTÃO DIFERENTE DA PÁGINA])
  try {
    if (user_type == user) {
      const user = await credentialModel.credentialModelUserLogin("user", name);
      if (await bcrypt.compare(password, user.password)) {
        res.status(200).json({message:user.id})
      }
      else{
        res.status(500).json({message:"credentialControllerLogin500"})
      }
    }
    if (user_type == student) {
      const student = await credentialModel.credentialModelMainTableLoginVerification("student", name);
      if (await bcrypt.compare(password, student.password)) {
        const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolstudent", "student_id", student.id);
        res.status(200).json({"student_id":student.id, "school_id":school.id});
      }
      else{
        res.status(500).json({message:"credentialControllerLogin501"})
      }
    }
    if (user_type == teacher) {
      const teacher = await credentialModel.credentialModelMainTableLoginVerification("teacher", name);
      if (bcrypt.compare(password, teacher.password)) {
        const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolteacher", "teacher_id", teacher.id);
        res.status(200).json({"teacher_id":student.id, "school_id":school.id});
      }
      else{
        res.status(500).json({message:"credentialControllerLogin502"})
      }
    }
    if (user_type == school) {
      const school = await credentialModel.credentialModelUserLogin("school", name);
      if (await bcrypt.compare(password, user.password)) {
        res.status(200).json({message:school.id})
      }
      else{
        res.status(500).json({message:"credentialControllerLogin503"})
      }
    }
  } catch (error) {
    
  }
}

module.exports = {credentialControllerSignup, credentialControllerLogin};
