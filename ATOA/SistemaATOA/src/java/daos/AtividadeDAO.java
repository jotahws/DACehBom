/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package daos;

import beans.Atividade;
import beans.Departamento;
import beans.Funcionario;
import beans.TipoAtividade;
import conecao.ConnectionFactory;
import facede.Facade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

/**
 *
 * @author JotaWind
 */
public class AtividadeDAO {

    private final String iniciaAtividade = "INSERT INTO FuncionarioAtividade (idFuncionario, idAtividade, statusAtividade, inicio) VALUES (?,?,?,CURRENT_TIMESTAMP)";
    private final String buscaAtividadeIniciada = "select * from TipoAtividade t, funcionarioatividade a where a.idAtividade = t.id AND idFuncionario=? AND statusAtividade=1;";
    private final String EncerraAtividade = "UPDATE FuncionarioAtividade SET statusAtividade=2, fim=CURRENT_TIMESTAMP WHERE idFuncionario=? AND statusAtividade=1;";
    
    private Connection con = null;
    private PreparedStatement stmt = null;
    private ResultSet rs = null;

    public void criaAtividade(int idTipo, Funcionario funcionario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(iniciaAtividade, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, funcionario.getId());
            stmt.setInt(2, idTipo);
            stmt.setInt(3, 1);
            //stmt.setTimestamp(4, );
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

    public Atividade getAtividadeIniciada(Funcionario func) throws ClassNotFoundException, SQLException {
        try {
            Facade facade = new Facade();
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(buscaAtividadeIniciada);
            stmt.setInt(1, func.getId());
            rs = stmt.executeQuery();
            if (rs.next()) {
                //Dados da Atividade
                int idAtiv = rs.getInt("a.id");
                String descricao = rs.getString("a.descricao");
                int statusAtividade = rs.getInt("a.statusAtividade");
                Date inicio = rs.getDate("a.inicio");
                Date fim = rs.getDate("a.inicio");
                //Dados do TIPO
                int idTipo = rs.getInt("t.id");
                int idDepto = rs.getInt("t.idDepartamento");
                String nome = rs.getString("t.nome");
                //Criando objetos Tipo
                TipoAtividade tipo = facade.getTipoPorID(idTipo);
                //Criando atividade
                Atividade atividade = new Atividade();
                atividade.setId(idAtiv);
                atividade.setDescricao(descricao);
                atividade.setStatusAtividade(statusAtividade);
                atividade.setFuncionario(func);
                atividade.setTipo(tipo);
                //atividade.setInicio(inicio);
                //atividade.setFim(fim);
                return atividade;
            }
        } finally {
            try {
                stmt.close();
                con.close();
                rs.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
        return null;
    }

    public void encerraAtividade(Funcionario funcionario) throws ClassNotFoundException, SQLException {
        try {
            con = new ConnectionFactory().getConnection();
            stmt = con.prepareStatement(EncerraAtividade);
            stmt.setInt(1, funcionario.getId());
            stmt.executeUpdate();
        } finally {
            try {
                stmt.close();
                con.close();
            } catch (SQLException ex) {
                System.out.println("Erro ao fechar parâmetros: " + ex.getMessage());
            }
        }
    }

}
