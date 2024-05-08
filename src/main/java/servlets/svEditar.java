package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "svEditar", urlPatterns = {"/svEditar"})
public class svEditar extends HttpServlet {

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
            // Obtener los parámetros del formulario de edición
            String cedula = request.getParameter("cedulaEdit");
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String telefono = request.getParameter("telefono");
            String tipo = request.getParameter("tipo");
            String descripcion = request.getParameter("descripcion");

            // Preparar la sentencia SQL para actualizar la PQRS
            String sql = "UPDATE pqrs SET nombre=?, apellido=?, telefono=?, tipo=?, descripcion=? WHERE cedula=?";

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, apellido);
            pstmt.setString(3, telefono);
            pstmt.setString(4, tipo);
            pstmt.setString(5, descripcion);
            pstmt.setString(6, cedula);

            // Ejecutar la consulta de actualización
            pstmt.executeUpdate();

            // Cerrar la conexión
            conn.close();

            // Redireccionar al usuario de vuelta a la página .jsp
            response.sendRedirect("mostrarPQRS.jsp");

            System.out.println("PQRS editada exitosamente");
            } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.getWriter().println("Error al editar la PQRS: " + e.getMessage());
        }
    } else {
        response.getWriter().println("No se pudo establecer una conexión a la base de datos.");
    }
}
@Override
    public String getServletInfo() {
        return "Short description";
    }
}