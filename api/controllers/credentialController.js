const credentialModel = require("../models/credentialModel");
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

async function SignUpController(req, res) {
    const {name, email, password, cod} = req.body;
    
    try{
      if (await credentialModel.IsSchool(cod)) {
        if (await credentialModel.IsTeacher(name, cod)) {
          
        } else {
          
          res.status(500).json({message:"IsStudent"})
        }
      }
      else{
        res.status(500).json({message: "Schoolwasnotfind"})
      }
        
    }
    catch{
        res.status(500).json({message: "UserSignUpControllerError"});
    }
    
};

async function LoginController(req, res) {
  const { name, email, password, position } = req.body;
  try {
    const user = await credentialModel.UserLoginModel(name, email);
    const match = await bcrypt.compare(password, user.password);
    if (match) {
      const token = jwt.sign({'name':name, 'email':email}, process.env.JWT_SECRET, {expiresIn:'1h'});

      res.status(200).json({ token:token });
    } else {
      res.status(500).json({ message: "UserLoginControllerError" });
    }
  } catch (err) {
    res.status(500).json({ message: "UserLoginControllerError" });
  }
}


module.exports = {SignUpController, LoginController};