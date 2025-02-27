var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');

var index = require('./routes/index');
var dashboard = require('./routes/dashboard');

var app = express();

// View Maps
import { Loader } from '@googlemaps/js-api-loader';
const apiOptions = {
	apiKey: "YOUR API KEY"
  }

const loader = new Loader(apiOptions);

loader.load().then(() => {
	console.log('Maps fue cargado exitosamente');
	
  });

// view engine setup jaddas
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

// uncomment after placing your favicon in /public
////app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/javascripts', express.static(path.join(__dirname, '../node_modules/bootstrap/dist/js')));
app.use('/javascripts', express.static(path.join(__dirname, '../node_modules/masonry-layout/dist')));



app.use(session({
	secret: 'foo',
	resave: false,
	saveUninitialized: true,
	cookie: { maxAge: 3600000 }	// 1 minute = 60 units
}));

app.use('/', index);
app.use('/panel', dashboard);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
	var err = new Error('Not Found');
	err.status = 404;
	next(err);
});

// error handler
app.use(function (err, req, res, next) {
	if (req.app.get('env') === 'development') {
		// set locals, only providing error in development
		res.locals.message = err.message;
		res.locals.error = req.app.get('env') === 'development' ? err : {};
	
		// render the error page
		res.status(err.status || 500);
		res.render('error');
	}
	else {
		res.redirect('/');
	}
});

module.exports = app;
