const express = require('express');
const router = express.Router();
const profileController = require('../controllers/profileController');
const jwtMiddleware = require('../jwtMiddleware');

router.get('/getbasicdata', jwtMiddleware.verifyToken, profileController.getBasicDataController);

module.exports = router;