	const nodemailer = require("nodemailer");


	const val = {
		// Roles
	/**
	 * 
	 * @param {string} email 

	 */
	// async..await is not allowed in global scope, must use a wrapper
	mailVerification: async(email, num) => { {
		// TODO Borrar PLOX
		

	  // Generate test SMTP service account from ethereal.email
	  // Only needed if you don't have a real mail account for testing
	  let testAccount = await nodemailer.createTestAccount();
	  var b = num.toString();
	
	  // create reusable transporter object using the default SMTP transport
	  let transporter = nodemailer.createTransport({
		host: "smtp.gmail.com",
		port: 465,
		secure: true, // true for 465, false for other ports
		auth: {
		  user: "lockeysendiit@gmail.com", // generated ethereal user
		  pass: "uryvmcthzjrbeung", // generated ethereal password
		},
	  });
	
	  // send mail with defined transport object
	  let info = await transporter.sendMail({
		from: '"Fred Foo 👻" ', // sender address
		to: email, // list of receivers
		subject: "Hello ✔", // Subject line
		text: b , // plain text body
		html: "<b>" + b +" </b>"});
	
	  console.log("Message sent: %S", info.messageId);
	  // Message sent: <b658f8ca-6296-ccf4-8306-87d57a0b4321@example.com>
	
	  // Preview only available when sending through an Ethereal account
	  //console.log("Preview URL: %s", nodemailer.getTestMessageUrl(info));
	  // Preview URL: https://ethereal.email/message/WaQKMgKddxQDoou...
	}

}
};

	module.exports = val;