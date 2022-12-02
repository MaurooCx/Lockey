const formulario = document.getElementById('formulario');
const inputs = document.querySelectorAll('#formulario Input');
//const forms = document.querySelectorAll('.needs-validation');
const expresiones = {
	nombre: /^[a-zA-ZÀ-ÿ\s]{1,40}$/, // Letras y espacios, pueden llevar acentos.
	password: /^ (?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}/,// 4  12 digitos.
	correo: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/,
	telefono: /^\d{10}$/ // 7 a 14 numeros.
}


const campos = {
	nombre: false,
	password: false,
	correo: false,
	telefono: false
}

const validarFormulario = (e) => {
	
	switch (e.target.id) {

		case "nombre":
			console.log('val')
			validarCampo(expresiones.nombre, e.target,'nombre');
		break;
		case "password":
			validarCampo(expresiones.password, e.target, 'password');
			validarPassword2();
			
		break;
		case "password2":
			validarPassword2();
		break;
		case "correo":
			validarCampo(expresiones.correo, e.target, 'correo');
		break;
		case "telefono":
			validarCampo(expresiones.telefono, e.target, 'telefono');
		break;
	}
}
const validarCampo = (expresion, input, campo) => {
	if(expresion.test(input.value)||input.value==''){
		console.log('F');
		document.querySelector(`#grupo__${campo} .invalid-feedback`).classList.remove('error-activo');
		campos[campo] = true;
	} else {
		console.log('t');
		document.querySelector(`#grupo__${campo} .invalid-feedback`).classList.add('error-activo');
		campos[campo] = false;
	}
}
inputs.forEach((input) => {
	input.addEventListener('blur', validarFormulario);
});

const validarPassword2 = () => {
	const inputPassword1 = document.getElementById('password');
	const inputPassword2 = document.getElementById('password2');

	if(inputPassword1.value !== inputPassword2.value){
	
		document.querySelector(`#grupo__password2 .invalid-feedback`).classList.add('error-activo');
		campos['password'] = false;
	} else {
		document.querySelector(`#grupo__password2 .invalid-feedback`).classList.remove('error-activo');
		campos['password'] = true;
	}
}



formulario.addEventListener('submit', (e) => {
	e.preventDefault();
	if((campos.nombre && campos.password && campos.correo && campos.telefono ) == true ){

	//coloca el codigo aqui 

	}
	return true;

});