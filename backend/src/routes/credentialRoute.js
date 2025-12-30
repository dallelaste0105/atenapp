const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');
const jwtMiddleware = require('../jwtMiddleware');

router.post('/signup', credentialController.signupController);
router.post('/login', credentialController.loginController);
router.post('/saveuserfcmtoken', jwtMiddleware.verifyToken, credentialController.saveUserFCMTokenController);
router.get('/verifyuserfcmtoken', jwtMiddleware.verifyToken, credentialController.verifyUserFCMTokenController);

module.exports = router;