<%-- 
    Document   : editar
    Created on : May 27, 2017, 10:14:32 AM
    Author     : JotaWind
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <title>Editar Funcion�rio - Sistema RHINDO</title>
    </head>
    <body>
        <%@include file="../pre-fabricado/cabecalho.jsp" %>
        <c:choose>
            <c:when test="${funcionarioLogado.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${(funcionarioLogado.perfil != 'GERENTE-RH')}">
                        <div class="container">
                            <h1>Acesso Negado.</h1>
                            <h2>Voc� n�o pode acessar a essa p�gina</h2>
                        </div>
                    </c:when>
                    <c:otherwise> 
                        <div class="container">
                            <!-- Row do input pesquisar: -->
                            <div class="row row-busca-titulo">
                                <div class="col-md-8 titulo">
                                    <h1 class="col-md-12">Editar Dados de ${func.nome}</h1>
                                </div>
                            </div>
                            <!-- Row do cadastro: -->
                            <div class="row row-lista-corpo">
                                <c:choose>
                                    <c:when test="${(param.status == 'errorID')}">
                                        <div class="alert alert-danger alert-dismissable">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <p> <strong>Ops!</strong> Voc� deve selecionar um funcion�rio para poder edit�-lo. <a href="CarregaListaFuncServlet?action=listaFuncionarios">Lista de Funcion�rios</a></p>
                                        </div>
                                    </c:when>
                                    <c:when test="${(param.status == 'error')}">
                                        <div class="alert alert-danger alert-dismissable">
                                            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                            <p> <strong>Ops!</strong> Ocorreu um erro ao <strong>editar</strong> um funcion�rio. Um ou mais dados s�o inv�lidos. <a href="CarregaListaFuncServlet?action=listaFuncionarios">Lista de Funcion�rios</a></p>
                                        </div>
                                    </c:when>
                                </c:choose>
                                <!-- corpo da p�gina -->
                                <div class="col-md-12 corpo">
                                    <fieldset>
                                        <form action="${pageContext.request.contextPath}/FuncionarioServlet?action=edit" method="POST" class="cadastro">
                                            <div class="row">
                                                <legend>Geral</legend>
                                                <div class="form-group col-md-4">
                                                    <label for="nome">Nome:</label>
                                                    <input type="text" class="form-control" id="nome" name="nome" value="${func.nome}">
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="cpf">CPF:</label>
                                                    <input type="text" class="form-control" id="cpf" name="cpf" value="${func.cpf}">
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="rg">RG:</label>
                                                    <input type="text" class="form-control" id="rg" name="rg" value="${func.rg}">
                                                </div>
                                               <!-- <div class="form-group col-md-3"> 
                                                    <label for="senha">Senha:</label> -->
                                                    <input type="hidden" class="form-control" id="senha" name="senha" value="${func.senha}">
                                               <!-- </div> -->
                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-2">
                                                    <label for="celular">Celular</label>
                                                    <input type="text" class="form-control" id="celular" name="celular" value="${func.celular}">
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label for="email">Email</label>
                                                    <input type="email" class="form-control" id="email" name="email" value="${func.email}">
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="depto">Departamento</label>
                                                    <select class="form-control" id="depto" name="depto">
                                                        <jsp:useBean id="depto" class="beans.Departamento"/>
                                                        <c:set var="lista" value="${deptos}"/>
                                                        <c:forEach var="item" items="${lista}">
                                                            <option value="${item.id}" <c:if test="${func.departamento.nome == item.nome}">selected</c:if> >
                                                                <c:out value="${item.nome}"/>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label for="cargo">Cargo</label>
                                                    <select class="form-control" id="cargo" name="cargo">
                                                        <jsp:useBean id="cargo" class="beans.Cargo"/>
                                                        <c:set var="lista" value="${cargos}"/>
                                                        <c:forEach var="item" items="${lista}">
                                                            <option value="${item.id}" <c:if test="${func.cargo.nome == item.nome}">selected</c:if> >
                                                                <c:out value="${item.nome}"/>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="perfil">Perfil do Funcion�rio</label>
                                                    <select class="form-control" id="perfil" name="perfil">
                                                        <option value="FUNCIONARIO" <c:if test="${func.perfil == 'FUNCIONARIO'}">selected</c:if>>
                                                                Funcion�rio Comum
                                                            </option>
                                                            <option value="GERENTE" <c:if test="${func.perfil == 'GERENTE'}">selected</c:if>>
                                                                Gerente
                                                            </option>
                                                            <option value="GERENTE-RH" <c:if test="${func.perfil == 'GERENTE-RH'}">selected</c:if>>
                                                                Gerente de RH
                                                            </option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <legend>Endere�o</legend>
                                                    <div class="form-group col-md-4">
                                                        <label for="cep">CEP</label>
                                                        <input type="text" class="form-control" id="cep" name="cep" value="${func.endereco.cep}"/>
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label for="rua">Rua</label>
                                                    <input type="text" class="form-control" id="rua" name="rua" value="${func.endereco.rua}"/>
                                                </div>
                                                <div class="form-group col-md-2">
                                                    <label for="numero">N�mero</label>
                                                    <input type="number" class="form-control" id="numero" name="numero" value="${func.endereco.numero}"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="bairro">Bairro</label>
                                                    <input type="text" class="form-control" id="bairro" name="bairro" value="${func.endereco.bairro}"/>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <label for="cidade">Cidade</label>
                                                    <input type="text" class="form-control" id="cidade" name="cidade" value="${func.endereco.cidade.nome}"/>
                                                    <input type="hidden" name="idFunc" value="${func.id}"/>
                                                </div>
                                                <div class="form-group col-md-1">
                                                    <label for="uf">UF</label>
                                                    <select class="form-control" id="uf" name="uf">
                                                        <jsp:useBean id="uf" class="beans.Estado"/>
                                                        <c:set var="lista" value="${estados}"/>
                                                        <c:forEach var="item" items="${lista}">
                                                            <option <c:if test="${func.endereco.cidade.estado.uf == item.uf}">selected</c:if> >
                                                                <c:out value="${item.uf}"/>
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="form-group col-md-3">
                                                    <label for="estado">Estado</label>
                                                    <input type="text" class="form-control" disabled id="estado" name="estado" value="${func.endereco.cidade.estado.nome}"/>
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <a href="FuncionarioServlet?action=delete&idFunc=${func.id}" class="btn btn-danger" onclick="return confirm('Voc� tem certeza que deseja excluir este funcion�rio?');">Excluir Funcion�rio</a>  
                                                <input onclick = "return confirm('Alterar os dados deste funcionario?')" type="submit" id="btnSubmitFunc" class="btn btn-primary form-group" value="Salvar Altera��es" />
                                            </div>
                                        </form>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
    <script src="${pageContext.request.contextPath}/javascript/scripts.js"></script>
    <script src="${pageContext.request.contextPath}/javascript/jquery.maskedinput.js"></script>

</html>
