/**
 * Validação do formulario de cadastro de pecas
 * @ Fabio Furlan
 */

function validar() {
	let produto = frmPecas.cars.value;
	let fabricante = frmPecas.fabricante.value;
	let valor = frmPecas.valor.value;

	if (produto === "") {
		alert('Preencha esse campo Produto');
		frmPecas.cars.focus();
		return false;
	} else if (fabricante.trim() === "") {
		alert('Preencha esse campo do Fabricante');
		frmPecas.fabricante.focus();
		return false;
	} else if (valor.trim() === "") {
		alert('Preencha esse campo Valor');
		frmPecas.valor.focus();
		return false;
	}
	return true;
}
