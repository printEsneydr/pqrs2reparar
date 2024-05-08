package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author esney
 */
@WebServlet(name = "svAgregarPqrs", urlPatterns = {"/svAgregarPqrs"})
public class svAgregarPqrs extends HttpServlet {

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
        Connection conn = gestionar.establecerConexion();

        if (conn != null) {
            try {
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String telefono = request.getParameter("telefono");
                String cedula = request.getParameter("cedula");               
                String tipo = request.getParameter("tipo");
                String descripcion = request.getParameter("descripcion");
                //String fecha = request.getParameter("fecha");

                // Obtener la categoría seleccionada del formulario
                CallableStatement stmt = conn.prepareCall("{call agregar(?, ?, ?, ?, ?, ?)}");
                stmt.setString(1, nombre);
                stmt.setString(2, apellido);
                stmt.setString(3, telefono);
                stmt.setString(4, cedula);
                stmt.setString(5, tipo);
                stmt.setString(6, descripcion);
                //stmt.setString(6, fecha);


                // Ejecutar la consulta para agregar el tutorial
                stmt.execute();
                conn.close();

                response.sendRedirect("formulario.jsp");
                System.out.println("Conexion exitosa");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error al agregar la pqrs: " + e.getMessage());
            }
        } else {
            response.getWriter().println("No se pudo establecer una conexión a la base de datos.");
        }
    }

}

    


