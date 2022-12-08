var debug = require('debug')('lockey:router:index');
var express = require('express');
var router = express.Router();
var crypto = require('node:crypto');
var db = require('../modules/MySQLConnection');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title:'sendiit', path:req.path, user:req.session.user });
});


router.route('/identificacion')
	.post((req, res, next) => {
		debug(req.body);
		let {email, password} = req.body;
		password = crypto.createHash('sha256').update(password).digest('hex');

		db.checkCredentials(email, password).then((results) => {
			debug('results', results);
			if (results.length) {
				req.session.user = {
					name: results[0].nm_usr,
					email: results[0].em_usr,
					type: results[0].type_usr
				};
				debug('/identificacion session.user:', req.session.user);
				
				res.status(200).json({
					response: 'OK',
					message: 'Usuario autenticado',
					redirect: '/panel'
				});
			} else {
				// res.redirect(401, '/identificacion');
				res.status(401).json({response:'ERROR', message:'Correo o contraseña incorrectos'});
			}
		}).catch((err) => {
			debug(err);
			// res.redirect(402, '/identificacion');
			res.status(402).json({response:'ERROR', message:err});
		});
	});

router.route('/registro')
	.post((req, res, next) => {
		debug(req.body);
		let {name, email, tel, password} = req.body;
		password = crypto.createHash('sha256').update(password).digest('hex');

		// create new user
		db.createUser(name, email, tel, password, db.ROLES.CLIENT).then((results) => {
			debug('results', results);
			if (results.affectedRows > 0) {
				// get user by id
				db.getUserById(results.insertId).then((results) => {
					debug('results', results);
					if (results.length > 0) {
						req.session.user = {
							name: results[0].nm_usr,
							email: results[0].em_usr,
							type: results[0].type_usr
						};
						debug('/registro session.user:', req.session.user);
						res.status(200).json({
							response: 'OK',
							message: 'Usuario creado correctamente',
							redirect: '/panel'
						});
					} else {
						res.status(401).json({response:'ERROR', message:'Usuario no encontrado tras registro'});
					}
				}).catch((err) => {
					debug(err);
					res.status(402).json({response:'ERROR', message:err});
				});
			} else {
				res.status(401).json({response:'ERROR', message:'No se pudo crear el usuario'});
			}
		}).catch((err) => {
			debug(err);
			res.status(402).json({response:'ERROR', message:err});
		});
	});



module.exports = router;
