const formulario = document.getElementById('row g-3 needs-validation');
const inputs = document.querySelectorAll('#floatingInput');
const forms = document.querySelectorAll('.needs-validation');

const validarFormulario = (e) => {
	console.log("se ejecuto");
	Array.from(forms).forEach(form => {
		form.addEventListener('keyup', event => {
		  if (!form.checkValidity()) {
			event.preventDefault()
			event.stopPropagation()
		  }
	
		  form.classList.add('was-validated')
		}, false)
	  })

};

inputs.forEach((input) => {
	input.addEventListener('keyup', validarFormulario);
	input.addEventListener('blur', validarFormulario);
});