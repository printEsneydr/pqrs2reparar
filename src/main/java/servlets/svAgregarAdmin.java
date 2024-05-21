/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import com.umariana.pqrs2.correo;
import com.umariana.pqrs2.gestionarPQRS;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "svAgregarAdmin", urlPatterns = {"/svAgregarAdmin"})
public class svAgregarAdmin extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");       
    }
    gestionarPQRS gestionar = new gestionarPQRS();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String cedula = request.getParameter("cedula");       
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = "Admin";

                
            System.out.println(nombre);
            System.out.println(apellido);
            System.out.println(telefono);
            System.out.println(cedula);       
            System.out.println(correo);       
            System.out.println(contrasena);  
            System.out.println(rol);  

        
  boolean error = false;

        // Verificar si la cédula ya está registrada
        if (gestionar.existeUser(cedula)) 
        {
            error = true;
        } 
        else
        {
            gestionar.usuario(nombre, apellido, telefono, cedula, correo, contrasena, rol);
            System.out.println("agregado");
        }

        if (error)
        {
            response.sendRedirect("admin.jsp?error=true");
        } else 
        {
            response.sendRedirect("admin.jsp?success=true");
        }
        
        //para enviar el correo
        
        System.out.println("enviando correo");
        String emailFrom = "pqrsibarra@gmail.com"; // Cambia esto por tu dirección de correo electrónico
        String passwordFrom = "gxpg qgfu oftz vprb"; // Cambia esto por tu contraseña
        String emailTo = "esneyderibarra1970@gmail.com"; // Cambia esto por la dirección de correo electrónico del destinatario
        String subject = "hola";
        String content = "que hace.";

        // Crear instancia de EnvioCorreos y configurar detalles del correo
        correo envioCorreos = new correo();
        envioCorreos.setEmailFrom(emailFrom);
        envioCorreos.setPasswordFrom(passwordFrom);
        envioCorreos.setTo(emailTo);
        envioCorreos.setSubject(subject);
        envioCorreos.setContent(content);

        // Intentar enviar el correo electrónico
        try {
            envioCorreos.sendEmail();
            response.getWriter().println("Correo enviado exitosamente");
        } catch (MessagingException ex) {
            response.getWriter().println("Error al enviar el correo: " + ex.getMessage());
        }
        
    }   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    }

