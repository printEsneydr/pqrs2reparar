package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "svLogin", urlPatterns = {"/svLogin"})
public class svLogin extends HttpServlet {

    gestionarPQRS gestionar = new gestionarPQRS();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        HttpSession session = request.getSession(false);

        if (session != null)
            
        {
            session.invalidate();
        }

        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        String [] credenciales = gestionar.login(correo, contrasena);
         HttpSession session = request.getSession();

        if (credenciales != null) 
        {            
            session.setAttribute("idUsuario", credenciales [0] );
            session.setAttribute("rol", credenciales [1] );
            session.setAttribute("nombre", credenciales [2] );

        // Redirigir al usuario según su rol
    if (credenciales[1].equals("Admin")) {
        String tipo = "admin";
        session.setAttribute("tipoPersona", tipo);
        response.sendRedirect("inicio.jsp");
    } else {
        String tipo = "usuario";
        session.setAttribute("tipoPersona", tipo);
        
        response.sendRedirect("inicio.jsp");
    }
} else {
    response.sendRedirect("index.jsp?errorP=true");
}
    }
    @Override
    public String getServletInfo() {
        return "servidor";
    }
}
