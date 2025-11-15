const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');
const jwtMiddleware = require('../controllers/otherControllers/jwtMiddlewareController');


// routes mounted at /credential

router.post('/signup', credentialController.credentialControllerSignup);// POST to /signup using the controller: credentialControllerSignup
router.post('/login', credentialController.credentialControllerLogin);// POST to /login using the controller: credentialControllerLogin
router.post('/schoolsignup', credentialController.schoolSignupCredentialController);// POST to /signup using the controller: credentialControllerSignup
router.post('/schoollogin', credentialController.schoolLoginCredentialController);// POST to /login using the controller: credentialControllerLogin

module.exports = router;