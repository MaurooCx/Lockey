var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'expres' });
});

//Below showing to alternatives to redirect to another page
// Fer, elige el que mejor quieras

router.route('/identificacion')
	.get((req, res, next) => { 
		res.render('signin');
	})
	.post((req, res, next) => {
		console.log(req.body);
		console.log('name', req.body.name);

		// Dummy process
		if (req.body.name === 'admin' && req.body.pwd === 'admin')
			// Backend redirects
			res.status(200).redirect('/panel');
		else {
			res.status(401).json('Contraseña incorrecta');
		}
	});

router.route('/registro')
	.get((req, res, next) => {
		res.render('signup');
	})
	.post((req, res, next) => {
		console.log(req.body);
		console.log('name', req.body.name);

		// Dummy process
		if (req.body.name === 'admin' && req.body.pwd === 'admin')
			res.status(200).json('OK');
		else {
			// Front redirects
			res.status(401).json('Contraseña incorrecta');
		}
	});

module.exports = router;
