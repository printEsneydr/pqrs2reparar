/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author esney
 */
@WebServlet(name = "svActualizarEstadoPqrs", urlPatterns = {"/svActualizarEstadoPqrs"})
public class svActualizarEstadoPqrs extends HttpServlet {

        gestionarPQRS gestionar = new gestionarPQRS();

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    } 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idPqrs = request.getParameter("idPqrs");
        String nuevoEstado = request.getParameter("nuevoEstado");

        if (idPqrs != null && nuevoEstado != null) {
            gestionar.actualizarEstadoPQRS(idPqrs, nuevoEstado);
        }

        response.sendRedirect("mostrarPQRS.jsp");
    }
}
