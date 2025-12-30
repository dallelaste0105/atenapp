const express = require('express');
const router = express.Router();
const lessonController = require('../controllers/lessonController');
const jwtMiddleware = require('../jwtMiddleware');

router.get('/getsubjects', jwtMiddleware.verifyToken, lessonController.getSubjectsController);

module.exports = router;