const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');
const jwtMiddleware = require('../jwtMiddleware');

router.post('/signup', credentialController.signupController);
router.post('/login', credentialController.loginController);
router.post('/saveuserfcmtoken', jwtMiddleware.verifyToken, credentialController.saveUserFCMTokenController);
router.get('/verifyuserfcmtoken', jwtMiddleware.verifyToken, credentialController.verifyUserFCMTokenController);
router.post('/lancarcodigoestudante', jwtMiddleware.verifyToken, credentialController.LARCARCODIGOESTUDANTE);
router.post('/lancarcodigoprofessor', jwtMiddleware.verifyToken, credentialController.LARCARCODIGOPROFESSOR);
router.post('/mandarnotificacao', jwtMiddleware.verifyToken, credentialController.sendNotificationController);

module.exports = router;