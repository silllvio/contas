<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Lista de contas!</title>
</head>
<body>
	<table>
		<tr>
			<th>Código</th>
			<th>Descrição</th>
			<th>Valor</th>
			<th>Paga?</th>
			<th>Data do pagamento</th>
			<th>Tipo</th>
		</tr>
		<tr>
			<td>${conta.id}</td>
			<td>${conta.descricao}</td>
			<td>${conta.valor}</td>
			<td>${conta.paga}</td>
			<td>${conta.dataPagamento}</td>
			<td>${conta.tipo}</td>
		</tr>
	</table>
	<h3></h3>

	<form action="buscaconta" method="post">
		<div>
			<label>Digite o número da conta</label> <input type="text" name="id"
				placeholder="id da conta">
		</div>
		<div>
			<input type="submit" value="Buscar" />
		</div>
	</form>


	<h3>Alterar Conta</h3>
	<form action="alteraConta" method="post">
		Descrição: <br />
		<textarea name="descricao" rows="5" cols="100">${conta.descricao}</textarea>
		<br /> Valor: <br /> <input type="text" name="valor"
			value="${conta.valor}" /><br /> Tipo: <br /> <select name="tipo">
			<option value="ENTRADA" ${conta.tipo=='ENTRADA' ? 'selected':''}>Entrada</option>
			<option value="SAIDA" ${conta.tipo=='SAIDA' ? 'selected':''}>Saída</option>
		</select> <br /> Pago? <input type="checkbox" name="paga"
			${conta.paga?'checked':''} /> <br /> Data de Pagamento: <input
			type="text" name="dataPagamento"
			value="<fmt:formatDate value="${conta.dataPagamento.time}" pattern="dd/MM/yyyy" />" />
		<br /> <input type="hidden" name="id" value="${conta.id}" /> <input
			type="submit" value="Alterar" />
	</form>

</body>
</html>