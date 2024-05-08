package servlets;


import com.umariana.pqrs2.gestionarPQRS;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "svRegistrar", urlPatterns = {"/svRegistrar"})
public class svRegistrar extends HttpServlet {

    gestionarPQRS gestionar = new gestionarPQRS();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
               
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String cedula = request.getParameter("cedula");       
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");
        String rol = "Usuario";

       
        boolean error = false;

        // Verificar si la cédula ya está registrada
        if (gestionar.existeUser(cedula)) 
        {
            error = true;
        } 
        else
        {
            gestionar.usuario(nombre, apellido, telefono, cedula, correo, contrasena, rol);
        }

        if (error)
        {
            response.sendRedirect("index.jsp?error=true");
        } else 
        {
            response.sendRedirect("index.jsp?success=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "servidor";
    }
}
