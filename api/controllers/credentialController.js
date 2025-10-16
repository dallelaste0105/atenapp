const credentialModel = require("../models/credentialModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function credentialControllerSignup(req, res) {
  const { name, email, password, school_name, your_code } = req.body;

  try {
    const whichSchool = await credentialModel.credentialModelWhichSchool(school_name);
    const bcrypt_password = await bcrypt.hash(password, 10);

    // se não encontrou escola, trata como usuário normal
    if (!whichSchool) {
      await credentialModel.credentialModelUserSignup(name, email, bcrypt_password);
      return res.status(200).json({ message: 202 });
    }

    const { id: school_id, teachercode, studentcode } = whichSchool;

    if (your_code === teachercode) {
      await credentialModel.credentialModelTeacherSignup(name, email, bcrypt_password);
      const teacher = await credentialModel.credentialModelSearchTeacher(name);
      await credentialModel.credentialModelDoSchoolTeacherRelation(school_id, teacher.id);
      return res.status(200).json({ message: 200 });
    }

    if (your_code === studentcode) {
      await credentialModel.credentialModelStudentSignup(name, email, bcrypt_password);
      const student = await credentialModel.credentialModelSearchStudent(name);
      await credentialModel.credentialModelDoSchoolStudentRelation(school_id, student.id);
      return res.status(200).json({ message: 201 });
    }

    // se não é teacher nem student
    await credentialModel.credentialModelUserSignup(name, email, bcrypt_password);
    res.status(200).json({ message: 202 });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 501 });
  }
}

async function credentialControllerLogin(req, res) {
  const {name, password, user_type} = req.body;//A VERIFICAÇÃO SE É ALUNO/PROFESSOR/ESCOLA DEVE SER FEITA AINDA NO CONNECTIONS(FUNÇÃO DIFERENTE PRA CADA UMA [CADA UMA CHAMADA POR UM BOTÃO DIFERENTE DA PÁGINA])
  try {
    if (user_type == "user") {
      const user = await credentialModel.credentialModelUserSchoolLogin("user", name);
      if (await bcrypt.compare(password, user.password)) {
        res.status(200).json({message:user.id})
      }
      else{
        res.status(500).json({message:"credentialControllerLogin500"})
      }
    }
    if (user_type == "student") {
      const student = await credentialModel.credentialModelMainTableLoginVerification("student", name);
      if (await bcrypt.compare(password, student.password)) {
        const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolstudent", "student_id", student.id);
        res.status(200).json({"student_id":student.id, "school_id":school.id});
      }
      else{
        res.status(500).json({message:"credentialControllerLogin501"})
      }
    }
    if (user_type == "teacher") {
      const teacher = await credentialModel.credentialModelMainTableLoginVerification("teacher", name);
      if (bcrypt.compare(password, teacher.password)) {
        const school = await credentialModel.credentialModelRelationTableLoginVerification("schoolteacher", "teacher_id", teacher.id);
        res.status(200).json({"teacher_id":student.id, "school_id":school.id});
      }
      else{
        res.status(500).json({message:"credentialControllerLogin502"})
      }
    }
    if (user_type == "school") {
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
