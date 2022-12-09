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

router.get('/envio/crear envio', (req,res,next) =>{
	res.render("createSender") 
	if (req.session.user) {
		res.render('createSender' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/envio/crear envio');
	}
});

router.get('/envio/crear envio/createSender', (req,res,next) =>{
	res.render("createAddressee") 
	if (req.session.user) {
		res.render('createAddressee' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/envio/crear envio');
	}
});

router.get('/envio/crear envio/createSender/createAddressee', (req,res,next) =>{
	res.render("createSize") 
	if (req.session.user) {
		res.render('createSize' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/envio/crear envio');
	}
});

module.exports = router;
