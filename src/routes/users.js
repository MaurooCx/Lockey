var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('Has iniciado sesion. Bienvenido!\nroutes/users.js');
});

module.exports = router;
