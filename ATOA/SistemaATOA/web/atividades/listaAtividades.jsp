<%-- 
    Document   : listaAtividades
    Created on : 11/05/2017, 16:06:20
    Author     : MauMau
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quadro de Atividades</title>
    </head>
    <body>
        <%@include file="/pre-fabricado/cabecalho.jsp" %>
        <c:choose>
            <c:when test="${funcionarioLogado.email == null}">
                <c:redirect url="/login.jsp"/>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${(funcionarioLogado.perfil != 'GERENTE' && funcionarioLogado.perfil != 'FUNCIONARIO' )}">
                        <div class="container">
                            <h1>Acesso Negado.</h1>
                            <h2>Voc� n�o pode acessar a essa p�gina</h2>
                        </div>
                    </c:when>
                    <c:otherwise> 
                        <div class="container">
                            <!-- Row do input pesquisar: -->
                            <div class="col-md-2"><h1>&nbsp;</h1></div>
                            <div class="row col-md-8">
                                <div class="col-md-12 text-center titulo">
                                    <h1>Quadro de Atividades</h1>
                                </div>
                            </div>
                            <div class="col-md-2"><h1>&nbsp;</h1></div>
                            <div class="col-md-2"><h1>&nbsp;</h1></div>
                            <!-- corpo da p�gina -->
                            <div class=" col-md-8 " style=" margin-top: 30px;">
                                <!-- TABELA -->
                                <div class=" panel panel-primary">
                                    <div class="panel-heading">Inicie ou encerre uma atividade:</div>
                                    <c:if test="${listaTipos != null}" >
                                        <table class="table">
                                            <tr>
                                                <th>Tipo Atividade</th>
                                                <th>Departamento</th>
                                                <th>Localiza��o</th>

                                                <th></th>
                                            </tr>

                                            <c:forEach var="item" items="${listaTipos}" >
                                                <tr>
                                                    <td><p>${item.nome}</p></td>
                                                    <td><p>${item.departamento.nome}</p></td>
                                                    <td><p>${item.departamento.localizacao}</p></td>
                                                    <td class="tg-031e"><a class="col-md-12 btn btn-primary">Iniciar</a></td>
                                                    <td class="tg-031e"><a href="atividades/corrigir.jsp" class="btn btn-warning">Corrigir Atividade</a></td>

                                                </tr>
                                            </c:forEach>         
                                        </table>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-2"><h1>&nbsp;</h1></div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </body>
</html>
