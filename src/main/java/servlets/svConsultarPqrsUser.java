/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.umariana.pqrs2.PQRS;
import com.umariana.pqrs2.gestionarPQRS;
import com.umariana.pqrs2.listarPqrs;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author esney
 */
@WebServlet(name = "svConsultarPqrsUser", urlPatterns = {"/svConsultarPqrsUser"})
public class svConsultarPqrsUser extends HttpServlet {
    gestionarPQRS gestionar = new gestionarPQRS();

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
        response.setContentType("text/html;charset=UTF-8");
       
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
    HttpSession session = request.getSession(false);
    
    // Verificar si hay una sesión válida
    if (session != null && session.getAttribute("idUsuario") != null) {
        int idUsuario = (int) session.getAttribute("idUsuario");
        
        // Llamar al método listarPqrs para obtener las PQRS del usuario
        List<PQRS> pqrsList = gestionar.consultarPqrsUsuario(idUsuario);
        // Colocar la lista de PQRS en el atributo de la solicitud para que la página JSP pueda acceder a ella
        request.setAttribute("pqrsList", pqrsList);
        // Redirigir a la página JSP que mostrará las PQRS del usuario
        request.getRequestDispatcher("PQRSUser.jsp").forward(request, response);
        request.getRequestDispatcher("mostrarPQRS.jsp").forward(request, response);
    } else {
        // Si no hay una sesión válida, redirigir al usuario a iniciar sesión
        response.sendRedirect("index.jsp");
    }
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
