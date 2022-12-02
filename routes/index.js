var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'expres' });
});

router.route('/identificacion')
	.get((req, res, next) => {
		res.render('signin');
	})
	.post((req, res, next) => {
		res.status(200).json('OK');
	});

router.route('/registro')
	.get((req, res, next) => {
		res.render('signup');
	})
	.post((req, res, next) => {
		res.status(200).json('OK');
	});

module.exports = router;
