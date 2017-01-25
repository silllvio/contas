<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<script src="resources/js/jquery.js" /></script>

<script type="text/javascript">

	function contaPaga(DadosDaResposta){
		alert("Conta paga com sucesso"); 
	}

	function pagarConta(id){
	$.post("contas/pagaConta", {'id' : id}, function(){$("#conta_"+id).html("Conta paga");} );
// 	$.post("contas/pagaConta", {'id' : id}, contaPaga);
	}

</script>


<title>Cadastro de contas!</title>
</head>

<body>

	<nav class="navbar navbar-inverse">
	<div>
		
		<ul class="pager">
    <li class="previous"><a href="contas"><span aria-hidden="true">&larr;</span> Cadastro de contas! </a></li>
<!--     <li class="next"><a href="contas">Newer <span aria-hidden="true">&rarr;</span></a></li> -->
  </ul>
	</div>
	</nav>
	<div>
		<h1>Contas cadastradas:</h1>
		<br /> <br />
	</div>

	<div class="container">
		<table class="table table-striped table-hover">
			<tr>
				<th>Código</th>
				<th>Descrição</th>
				<th>Valor</th>
				<th>Tipo</th>
				<th>Paga ?</th>
				<th>Data de pagamento</th>
				<th>Ação</th>
			</tr>
			<c:forEach items="${contas}" var="conta">
				<tr>
					<td>${conta.id}</td>
					<td>${conta.descricao}</td>
					<td>${conta.valor}</td>
					<td>${conta.tipo}</td>
					<td id="conta_${conta.id}"><c:if test="${conta.paga eq false}">Não paga.</c:if>
						<c:if test="${conta.paga eq true}">Conta paga</c:if></td>
					<td><fmt:formatDate value="${conta.dataPagamento.time}"
							pattern="dd/MM/yyyy" /></td>
					<td><a href="contas/removeConta?id=${conta.id}">Remover</a> <c:if
							test="${conta.paga eq false}">
					 |
						<a href="#" onclick="pagarConta(${conta.id})"> Pagar</a>
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</div>

	<h3>Cadastro de contas:</h3>

	<br />
	<br />
	<br />
	<div class="container">
		<form class="form-horizontal" action="contas" method="POST">
			<div class="form-group">
				<label>Descrição:</label> <input class="form-control"
					id="exampleInputName2" type="texarea" name="descricao" rows="5"
					cols="100">
				<form:errors path="conta.descricao" />
			</div>
			<div class="form-group">
				<input type="text" placeholder="Valor" name="R$ 00">
				<form:errors path="conta.valor" />

			</div>
			<div>
				<label>Paga</label> <input class="checkbox" name="paga"
					type='checkbox' value="true" />
			</div>
			<div class="form-group">
				<label>Data do Pagamento</label> <input type="text"
					name="dataPagamento" value="">
			</div>
			<div class="form-group">
				<select name="tipo">
					<option value="ENTRADA">Entrada</option>
					<option value="SAIDA">Saída</option>
				</select>
			</div>
			<div>
				<button type="submit" class="btn btn-primary">Salvar</button>
			</div>
		</form>
	</div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
</body>
</html>