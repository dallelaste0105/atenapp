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
    }

    catch{
        res.status(200).json({message: "credentialControllerSignup500"});
    }
};

async function credentialControllerLogin(req, res) {
  try {
    
  } catch (error) {
    
  }
}

module.exports = {credentialControllerSignup, credentialControllerLogin};
