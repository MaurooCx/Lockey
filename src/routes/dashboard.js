var debug = require('debug')('lockey:router:dashboard');
var express = require('express');
var router = express.Router();
var db = require('../modules/MySQLConnection');

router.get('/', (req, res, next) => {
	debug('session.user:', req.session.user);
	if (req.session.user) {
		res.render('dashboard', { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/');
	}
});

router.get('/cerrarsesion', (req, res, next) => {
	debug('session.user:', req.session.user);
	if (req.session.user) {
		req.session.destroy();
		res.redirect('/');
	} else {
		res.redirect('/');
	}
});
router.get('/envio');//envios historicos (esto de momento no)

router.get('/envio/detalles/[0-9]{18}', (req,res,next) =>{
	res.render("shippingdetails") 
	if (req.session.user) {
		res.render('shippingdetails' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/');
	}
});

module.exports = router;
