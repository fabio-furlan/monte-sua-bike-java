<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Monte Sua Bike - Cadastro de Peças</title>
    <link rel="icon" href="imagens/icon1.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <link rel="stylesheet" href="base.css">
    <link rel="stylesheet" href="style_pecas.css">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
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
                <li><a class="menu-pecas" href="pecas.jsp" aria-current="page">Cadastrar peças</a></li>
                <li><a class="menu-consulta" href="consulta">Consultar peças</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <form name="frmPecas" action="insert" method="get" class="form-card" onsubmit="return validar()">
            <h1 class="form-title">Cadastro de Peças</h1>

            <% if ("1".equals(request.getParameter("cadastrado"))) { %>
            <div class="form-alert">Peça cadastrada com sucesso!</div>
            <% } %>

            <div class="field">
                <label for="pecas-produto">Produto</label>
                <select name="cars" id="pecas-produto" required>
                    <option value="Quadro">Quadro</option>
                    <option value="Suspensao">Suspensão</option>
                    <option value="Garfo Rigido">Garfo rígido</option>
                    <option value="Pedal">Pedal</option>
                </select>
            </div>

            <div class="field">
                <label for="pecas-fabricante">Fabricante</label>
                <input id="pecas-fabricante" type="text" placeholder="Fabricante" name="fabricante" required>
            </div>

            <div class="field">
                <label for="pecas-valor">Valor</label>
                <input id="pecas-valor" type="text" placeholder="Valor" name="valor" required>
            </div>

            <div class="form-actions">
                <input class="btn-gold" type="submit" value="Cadastrar">
            </div>
        </form>
        <script src="scripts/validador.js"></script>
    </main>

    <footer class="footer">
        <div class="texto-copy">
            Copyright @ 2023
        </div>
    </footer>
</body>
</html>
