const express = require('express');
const router = express.Router();
const classController = require('../controllers/classController');
const jwtMiddleware = require('../controllers/otherControllers/jwtMiddlewareController');


// routes mounted at /class getSchoolClass

router.post('/createclass', jwtMiddleware.jwtMiddleware, classController.createClass);
router.post('/enterclass', jwtMiddleware.jwtMiddleware, classController.enterClass);
router.get('/getclass', jwtMiddleware.jwtMiddleware, classController.getSchoolClass);

module.exports = router;