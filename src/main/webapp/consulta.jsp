<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.List, model.JavaBeans"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Monte Sua Bike - Consultar Peças</title>
    <link rel="icon" href="imagens/icon1.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="base.css">
    <link rel="stylesheet" href="style_consulta.css">
    <!--font-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pragati+Narrow:wght@400;700&display=swap" rel="stylesheet">
</head>
<body>
    <header class="site-header">
        <img class="logo" src="imagens/logo.png" alt="Monte Sua Bike">

        <nav class="site-nav">
            <ul>
                <li><img class="bandeira" src="imagens/brasil.jpg" alt="Brasil"></li>
                <li><a class="home" href="index.html">Home</a></li>
                <li><a class="menu-montar" href="montar.html">Montar bike</a></li>
                <li><a class="menu-pecas" href="pecas.jsp">Cadastrar peças</a></li>
                <li><a class="menu-consulta" href="consulta" aria-current="page">Consultar peças</a></li>
            </ul>
        </nav>
    </header>

    <main class="consulta-wrap">
        <div class="consulta-header">
            <h1 class="form-title">Peças cadastradas</h1>
            <input type="search" id="busca-pecas" class="busca-pecas" placeholder="Buscar por produto ou fabricante...">
        </div>

        <%
            List<JavaBeans> listaPecas = (List<JavaBeans>) request.getAttribute("listaPecas");
            if (listaPecas != null && !listaPecas.isEmpty()) {
        %>
        <table class="tabela-pecas" id="tabela-pecas">
            <caption><%= listaPecas.size() %> peça(s) cadastrada(s)</caption>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Produto</th>
                    <th>Fabricante</th>
                    <th>Valor</th>
                </tr>
            </thead>
            <tbody>
                <% for (JavaBeans peca : listaPecas) { %>
                <tr>
                    <td data-label="ID"><%= peca.getIdcon() %></td>
                    <td data-label="Produto"><%= peca.getProduto() %></td>
                    <td data-label="Fabricante"><%= peca.getFabricante() %></td>
                    <td data-label="Valor" class="valor-cell">R$ <%= peca.getValor() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div class="estado-vazio">
            Nenhuma peça cadastrada ainda. <a href="pecas.jsp">Cadastre a primeira peça</a>.
        </div>
        <% } %>
    </main>

    <script>
        (function () {
            var busca = document.getElementById('busca-pecas');
            var tabela = document.getElementById('tabela-pecas');
            if (!busca || !tabela) return;
            var linhas = tabela.querySelectorAll('tbody tr');
            busca.addEventListener('input', function () {
                var termo = busca.value.trim().toLowerCase();
                linhas.forEach(function (linha) {
                    var texto = linha.textContent.toLowerCase();
                    linha.style.display = texto.indexOf(termo) !== -1 ? '' : 'none';
                });
            });
        })();
    </script>

    <footer class="footer">
        <div class="texto-copy">
            Copyright @ 2023
        </div>
    </footer>
</body>
</html>
