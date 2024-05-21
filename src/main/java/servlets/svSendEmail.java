/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.umariana.pqrs2.correo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author esney
 */
@WebServlet(name = "svSendEmail", urlPatterns = {"/svSendEmail"})
public class svSendEmail extends HttpServlet {

   
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

        String emailTo = request.getParameter("emailTo");
        String subject = request.getParameter("subject");
        String content = request.getParameter("content");

        String emailFrom = "pqrsibarra@gmail.com"; // Cambia esto a tu correo
        String passwordFrom = "gxpg qgfu oftz vprb"; // Cambia esto a tu contraseña

        correo envioCorreos = new correo();
        envioCorreos.setEmailFrom(emailFrom);
        envioCorreos.setPasswordFrom(passwordFrom);
        envioCorreos.setTo(emailTo);
        envioCorreos.setSubject(subject);
        envioCorreos.setContent(content);

        try {
            envioCorreos.sendEmail();
            response.sendRedirect("mostrarPQRS.jsp?success=true");
        } catch (MessagingException ex) {
            response.sendRedirect("mostrarPQRS.jsp?error=true");
        }
    }
}
