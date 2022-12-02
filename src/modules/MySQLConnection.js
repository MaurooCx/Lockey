const mysql = require('mysql2');

// console.log(`mysql -h ${process.env.MYSQL_HOST} -P ${process.env.MYSQL_PORT} -u ${process.env.MYSQL_USER} -p ${process.env.MYSQL_DATABASE}\n${process.env.MYSQL_PASSWORD}`);

var con = mysql.createConnection({
	host:		process.env.MYSQL_HOST,
	port:		process.env.MYSQL_PORT,
	user: 		process.env.MYSQL_USER,
	password:	process.env.MYSQL_PASSWORD,
	database:	process.env.MYSQL_DATABASE,
});

// loop if fails to connect
function connect() {
	con.connect((err) => {
		if (err) {
			console.error(err);
			console.log('Connection to MySQL failed. Retrying in 2 seconds...');
			// setTimeout(connect, 2*1000);	// try again in 2 seconds
		}
		else console.log("Connected!");
	});
}

connect();

con.on('error', function(err) {
	console.log('db error', err);
	if(err.code === 'PROTOCOL_CONNECTION_LOST') {
		connect();
	} else {
		throw err;
	}
});

// Here goes MySQL queries


// End of queries

module.exports = con;