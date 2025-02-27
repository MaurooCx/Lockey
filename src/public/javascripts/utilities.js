let toastContainer

(() => { 
	toastContainer = document.querySelector('.toast-container');
})()

const TOAST_TYPES = {
	PRIMARY: 'primary',
	SECONDARY: 'secondary',
	INFO: 'info',
	SUCCESS: 'success',
	WARNING: 'warning',
	DANGER: 'danger'
}

function toast(message, type=TOAST_TYPES.DANGER, duration=3000) {
	let toastElem = document.createElement('div');
	
	toastElem.classList.add('toast', `text-bg-${type}`, 'border-0');
	toastElem.setAttribute('role', 'alert');
	toastElem.setAttribute('aria-live', 'assertive');
	toastElem.setAttribute('aria-atomic', 'true');
	toastElem.setAttribute('data-bs-delay', `${duration}`);
	toastElem.setAttribute('data-bs-autohide', `${duration?true:false}`);
	toastElem.innerHTML = `
		<div class="d-flex">
			<div class="toast-body">
				${message}
			</div>
			<button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
		</div>
	`; 

	toastElem.addEventListener('hidden.bs.toast', () => toastElem.remove())

	toastContainer.appendChild(toastElem);
	let toastBs = new bootstrap.Toast(toastElem);  

    toastBs.show();
	return toastElem;
 }
