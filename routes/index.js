var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.get('/identificacion', function(req, res, next) {
	res.render('signin');
});

router.get('/registro', function(req, res, next) {
	res.render('signup');
});

module.exports = router;
