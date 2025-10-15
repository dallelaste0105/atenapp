const express = require('express');
const router = express.Router();
const credentialController = require('../controllers/credentialController');

router.post('/signup', credentialController.credentialControllerSignup);
router.post('/signup', credentialController.credentialControllerLogin);


module.exports = router;