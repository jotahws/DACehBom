/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Cargo;
import beans.Funcionario;
import beans.HorasTrabalhadas;
import facade.Facade;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author JotaWind
 */
@WebServlet(name = "FolhaPagamentoServlet", urlPatterns = {"/FolhaPagamentoServlet"})
public class FolhaPagamentoServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        Facade facade = new Facade();
        String status = "";
        if ("fechar".equals(action)) {
            try {
                String mes = request.getParameter("mes");
                int year = Calendar.getInstance().get(Calendar.YEAR);
                String dataInicio = year + "-" + mes + "-01";
                String dataFim = year + "-" + mes + "-30";
                List<Funcionario> funcs = facade.carregaListaFunc();
                List<HorasTrabalhadas> horas = new ArrayList();
                for (Funcionario func : funcs) {
                    List<HorasTrabalhadas> lista = facade.getHorastrabalhadas(dataInicio, dataFim, func);
                    for (HorasTrabalhadas item : lista) {
                        horas.add(item);
                    }
                }
                facade.fecharFolha(horas);
                request.setAttribute("horas", horas);
                status = "success";

                RequestDispatcher rd = getServletContext().getRequestDispatcher("/fecharFolha.jsp?status=" + status);
                rd.forward(request, response);
            } catch (NullPointerException | ClassNotFoundException | SQLException ex) {
                status = "errorEx";
            }

        } else if ("holeriteFunc".equals(action)) {
            HttpSession session = request.getSession();
            Funcionario func = (Funcionario) session.getAttribute("funcionarioLogado");
            int id = func.getId();
            String mes = request.getParameter("mes");

            try {
                HorasTrabalhadas hTrab = facade.buscaHoleriteFuncionario(id, mes);
                //Calculo liquido = bruto * imposto/10
                hTrab.getFunc().getCargo().setLiquido((hTrab.getFunc().getCargo().getSalario()
                        * hTrab.getFunc().getCargo().getDescImposto()) / 10);
                //conferir se horas trabalhadas é menoir que hora minina do cargo
                if (hTrab.getFunc().getCargo().getCargaMinima() < hTrab.getHorasTrabalhadas()) {
                    hTrab.getFunc().getCargo().setSalario((hTrab.getFunc().getCargo().getSalario()
                            * hTrab.getHorasTrabalhadas()) / hTrab.getFunc().getCargo().getCargaMinima());
                }
                request.setAttribute("func", hTrab);

                RequestDispatcher rd = getServletContext().getRequestDispatcher("/contraCheque.jsp");
                rd.forward(request, response);

            } catch (ClassNotFoundException | SQLException ex) {
                status = "erroH";
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}