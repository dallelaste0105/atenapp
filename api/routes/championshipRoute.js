const express = require('express');
const router = express.Router();
const championshipController = require('../controllers/championshipController');
const jwtMiddlewareController = require('../controllers/otherControllers/jwtMiddlewareController');

// routes mounted at /championship

router.post('/createchampionship', jwtMiddlewareController.jwtMiddleware, championshipController.createChampionshipController);
router.post('/searchchampionship', jwtMiddlewareController.jwtMiddleware, championshipController.searchChampionshipController);
router.post('/enterchampionship', jwtMiddlewareController.jwtMiddleware, championshipController.enterChampionshipController);
router.post('/createvent', jwtMiddlewareController.jwtMiddleware, championshipController.createChampionshipEventController);
router.post('/excludechampionship', jwtMiddlewareController.jwtMiddleware, championshipController.excludeChampionshipController);
router.get('/getchampionships', jwtMiddlewareController.jwtMiddleware, championshipController.getYourChampionshipsController);


module.exports = router;