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
	// res.render("shippingdetails") 
	if (req.session.user) {
		let traking=req.path.match(/\d{18}/)[0]
		console.log (traking)
		db.getshippingdetails(traking).then((results)=>{
			debug('results', results);
			if (results.length) {
				res.render('shippingdetails' , { title: 'sendiit - panel', path: req.path, user: req.session.user, shipping:results[0]});
			}
			else {
				res.status(401).json({response:'ERROR', message:'Envío no encontrado'});
			}
		});
	
	} else {
		res.redirect('/');
	}
});

router.get('/envio/crearEnvio', (req,res,next) =>{
	res.render("createSender") 
	if (req.session.user) {
		res.render('createSender' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/');
	}
});

router.get('/envio/crearEnvio/createSender', (req,res,next) =>{
	res.render("createAddressee") 
	if (req.session.user) {
		res.render('createAddressee' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/');
	}
});

router.get('/envio/crearEnvio/createSender/createAddressee', (req,res,next) =>{
	res.render("createSize") 
	if (req.session.user) {
		res.render('createSize' , { title: 'sendiit - panel', path: req.path, user: req.session.user });
	} else {
		res.redirect('/');
	}
});

module.exports = router;
