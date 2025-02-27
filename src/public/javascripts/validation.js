const patterns = {
	name: /[a-zA-Zà-ÿÀ-Ÿ]{3,} ([a-zA-Zà-ÿÀ-Ÿ]{2,} *)+/,
	tel: /[0-9]{10}/,
	email: /[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}/,
	password: /(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[^a-zA-Z0-9\s:])([^\s]){8,16}/,
}

function validateForm(form) {
	return Array.from(form.elements)
		.every((element) => element.checkValidity() )
}

function validatePassword(form) {
	if (form.elements['password-confirm']) {
		if (form.elements['password'].value !== form.elements['password-confirm'].value) {
			// toast('Passwords do not match')
			form.elements['password-confirm'].setCustomValidity('Las contraseñas no coinciden');
			return false;
		}
		form.elements['password-confirm'].setCustomValidity('');
	}
	return true;
}

(() => {
	// Fetch all the forms we want to apply custom Bootstrap validation styles to
	const forms = document.querySelectorAll('.needs-validation')	

	// Loop over them and prevent submission
	Array.from(forms).forEach(form => {
		Array.from(form.elements).forEach((element) => {
			// set pattern
			if (element.pattern === '') {
				if (element.name in patterns)
					element.setAttribute('pattern', patterns[element.name].source)
				else if (element.type in patterns)
					element.setAttribute('pattern', patterns[element.type].source)
			}

			element.addEventListener('keypress', event => 
				form.classList.remove('was-validated'));
		});

		form.addEventListener('submit', event => {
			event.preventDefault();
			event.stopPropagation();

			if (!validatePassword(form) || !validateForm(form)) {
				Array.from(form.elements).forEach(element => {
					let parent = element.parentElement;
					
					let feedback = parent.querySelector('.invalid-feedback');
					if (!element.checkValidity() || element.type === 'password')
						// Nombre
						if (element.name === 'name')
							if (element.validity.patternMismatch)
								feedback.textContent = 'El nombre debe tener al menos 3 letras por nombre y 2 por apellido';
							else
								feedback.textContent = 'El nombre es requerido';
						// Correo electrónico
						else if (element.type === 'email')
							if (element.validity.patternMismatch)
								feedback.textContent = 'El correo electrónico es requerido';
							else
								feedback.textContent = element.validationMessage;
						// Teléfono
						else if (element.type === 'tel')
							if (element.validity.patternMismatch)
								feedback.textContent = 'El número de teléfono debe tener 10 dígitos';
							else
								feedback.textContent = 'El número de teléfono es requerido';
						// Contraseña
						else if (element.type === 'password')
							if (element.validity.tooShort)
								feedback.textContent = 'La contraseña debe tener al menos 8 caracteres';
							else if (element.validity.tooLong)
								feedback.textContent = 'La contraseña debe tener máximo 16 caracteres';
							else if (element.validity.valueMissing)
								feedback.textContent = 'La contraseña es requerida';
							else if (element.validity.patternMismatch)
								feedback.textContent = 'La contraseña debe ser entre 8 y 16 caracteres y debe contener al menos una letra mayúscula, una minúscula, un número y un carácter especial';
							else if (element.validity.customError)
								feedback.innerHTML = element.validationMessage;
						// Otros
						else 
							feedback.innerHTML = element.validationMessage;
				});
			}
			else {
				let action = form.getAttribute('action'),
					method = form.getAttribute('method'),
					urlencoded = new URLSearchParams();
					
				Array.from(form.elements)
					.filter(element => element.name !== '')
					.forEach(element => {
						console.log(element.name, element.value);
						urlencoded.append(element.name, element.value)
					});
				
				fetch(action, {
					method: method,
					body: urlencoded
				})
				.then(res => res.json())
				.then(data => {
					if (data.response == 'OK')
						if (data.redirect)
							window.location.href = data.redirect;
						else if(data.modal) {
							let oldModalElem = document.querySelector(data.modal.old);
							let oldModal = bootstrap.Modal.getOrCreateInstance(oldModalElem);
							let newModal = bootstrap.Modal.getOrCreateInstance(document.querySelector(data.modal.new)/*, {focus:true}*/);

							oldModalElem.addEventListener('hidden.bs.modal', (event) => {
								newModal.show();
							}, { once: true });
							oldModal.hide()
						} 
						else{
							console.log(data.message);
							toast(data.message, TOAST_TYPES.SUCCESS);
						}
					else {
						console.log(data.message);
						form.classList.remove('was-validated');
						toast(data.message, TOAST_TYPES.DANGER);
					}
					
				})
				.catch(err => {
					toast('Error al enviar el formulario');
					console.log(err);
				});
			}

			form.classList.add('was-validated');
		}, false)
	})
})()