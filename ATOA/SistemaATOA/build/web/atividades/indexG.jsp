<%-- 
    Document   : index
    Created on : 10/05/2017, 11:05:10
    Author     : MauMau
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Atividades - Sistema ATOA</title>
    </head>
    <body>

        <%@include file="/pre-fabricado/cabecalho.jsp" %>

        <c:choose>
            <c:when test="${funcionarioLogado.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${(funcionarioLogado.perfil != 'GERENTE') && (funcionarioLogado.perfil != 'GERENTE-RH')}">
                        <div class="container">
                            <h1>Acesso Negado.</h1>
                            <h2>Voc� n�o pode acessar a essa p�gina</h2>
                        </div>
                    </c:when>
                    <c:otherwise> 
                        <div class="container">
                            <!-- Row do input pesquisar: -->
                            <div class="row row-busca-titulo">
                                <div class="col-md-4"></div>

                                <div class="col-md-8 titulo">
                                    <h1 class="col-md-10">Atividades</h1>
                                    <div class="text-right">
                                        <a href="${pageContext.request.contextPath}/ListaDepartamentosServlet?action=register" class="btn btn-info col-md-2">
                                            Novo Tipo
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!-- Row da lista de departamentos e atividades de capa departamento e corpo da pagina: -->
                            <div class="row row-lista-corpo">
                                <!-- lista de departamentos e atividades -->
                                <div class="col-md-4 lista-lat">
                                    <div class="list-group">
                                        <jsp:useBean id="tipo" class="beans.TipoAtividade"/>
                                        <jsp:useBean id="depto" class="beans.Departamento"/>
                                        <c:set var="lista" value="${tipos}"/>
                                        <c:forEach var="item" items="${lista}">
                                            <a href="#${item.id}" role="tab" data-toggle="tab" class="list-group-item">
                                                <c:out value="${item.nome}"/>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- corpo da p�gina -->
                                <div class="col-md-8">
                                    <c:choose>
                                        <c:when test="${(param.status == 'successEdit')}">
                                            <div class="alert alert-success alert-dismissable">
                                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                <p> <strong>Successo!</strong> O novo tipo de atividade foi Editado.</p>
                                            </div>
                                        </c:when>
                                        <c:when test="${(param.status == 'successDelete')}">
                                            <div class="alert alert-warning alert-dismissable">
                                                <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
                                                <p> <span class="glyphicon glyphicon-trash"></span> O tipo de atividade foi <strong>exclu�do</strong> com sucesso.</p>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </div>
                                <div class="corpo col-md-8 corpo">
                                    <fieldset>
                                        <div class="tab-content">
                                            <div role="tabpanel" class="tab-pane active" id="">
                                                <h1 class="unselectable text-center cor-disabled">Selecione uma atividade</h1>
                                                <h1 class="text-center"><span class="glyphicon glyphicon-hand-left cor-disabled gi-5x"></span></h1>
                                            </div>
                                            <c:forEach var="item" items="${lista}">
                                                <div role="tabpanel" class="tab-pane fade" id="${item.id}">
                                                    <legend>
                                                        <h2>${item.nome}</h2>
                                                    </legend>
                                                    <h4 class="celula-corpo-tipo">Departamento: ${item.departamento.nome}</h4>
                                                    <div class="panel panel-primary">
                                                        <!-- Default panel contents -->
                                                        <div class="panel-heading">Funcion�rios</div>
                                                        <!-- Tabela -->
                                                        <table class="table">
                                                            <c:choose>
                                                                <c:when test="${item.atividades != '[]'}">
                                                                    <tr>
                                                                        <th class="">Nome</th>
                                                                        <th class="">Data de In�cio</th>
                                                                        <th class="">Cargo</th>
                                                                        <th class=""></th>
                                                                    </tr>
                                                                    <c:forEach var="itemAtv" items="${item.atividades}">
                                                                        <tr>
                                                                            <td class="tg-031e">${itemAtv.funcionario.nome}</td>
                                                                            <td class="tg-031e">
                                                                                <jsp:useBean id="data" class="java.util.Date"/>
                                                                                <c:choose>
                                                                                    <c:when test="${data.date == itemAtv.inicio.date && data.day == itemAtv.inicio.day}">
                                                                                        <c:out value="Hoje,"/>
                                                                                        <fmt:formatDate value="${itemAtv.inicio}" type="BOTH" pattern=" HH:mm"/>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <fmt:formatDate value="${itemAtv.inicio}" type="BOTH" pattern="dd/MM/yyy HH:mm"/>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td class="tg-031e">${itemAtv.funcionario.cargo.nome}</td>
                                                                            <td class="tg-031e"><a href="AtividadeServlet?action=EncerrarID&idFunc=${itemAtv.funcionario.id}" class="btn btn-primary">Encerrar atividade</a></td>
                                                                        </tr>  
                                                                    </c:forEach>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <h2 class="text-center unselectable cor-disabled">
                                                                        Nenhum funcion�rio est� fazendo essa tarefa.
                                                                    </h2>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </table>
                                                    </div>
                                                    <div class="text-right">         
                                                        <a href="${pageContext.request.contextPath}/ListaAtividadeServlet?action=edit&id=${item.id}" class="btn btn-success">Editar Tipo</a>
                                                        <a href="AtividadeServlet?action=EncerrarTudo&idTipo=${item.id}" class="btn btn-primary <c:if test="${item.atividades == '[]'}">disabled</c:if> " onclick="return confirm('Tem certeza que deseja encerrar atividade para todos os funcionarios?');">Encerrar para todos</a>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>
                                    </fieldset>
                                </div>                                
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
</html>
