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

@WebServlet(name = "svEliminar", urlPatterns = {"/svEliminar"})
public class svEliminar extends HttpServlet {

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
                // Obtener el ID del tutorial a eliminar desde los parámetros de la solicitud
                int cedula = Integer.parseInt(request.getParameter("cedula"));

                // Sentencia SQL para eliminar el tutorial
                String sql = "DELETE FROM pqrs WHERE cedula = ?";

                // Preparar la declaración SQL
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, cedula);

                // Ejecutar la consulta
                pstmt.executeUpdate();

                // Cerrar la conexión
                conn.close();

                // Redireccionar al usuario de vuelta a la página index.jsp
                response.sendRedirect("mostrarPQRS.jsp");
                
                System.out.println("pqrs eliminado exitosamente");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error al eliminar : " + e.getMessage());
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
