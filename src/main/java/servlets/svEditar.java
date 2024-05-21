package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "svEditar", urlPatterns = {"/svEditar"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
        maxFileSize = 1024 * 1024 * 10, 
        maxRequestSize = 1024 * 1024 * 50) 
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
            String idPqrs = request.getParameter("idPqrsEdit");
            //77&String nombre = request.getParameter("nombre");
            //String apellido = request.getParameter("apellido");
            //String telefono = request.getParameter("telefono");
            String tipo = request.getParameter("tipo");
            String descripcion = request.getParameter("descripcion");
            
            
 Part filePart = request.getPart("archivo");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
            String uploadPath = getServletContext().getRealPath("") + File.separator + "archivosPdf";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }
            String archivo = File.separator + fileName;
            // Preparar la sentencia SQL para actualizar la PQRS
            String sql = "UPDATE pqrs SET tipo=?, descripcion=?, archivo=? WHERE idPqrs=?";

            PreparedStatement pstmt = conn.prepareStatement(sql);         
            pstmt.setString(1, tipo);
            pstmt.setString(2, descripcion);
            pstmt.setString(3, archivo);            
            pstmt.setString(4,idPqrs);

            // Ejecutar la consulta de actualización
            pstmt.executeUpdate();

            // Cerrar la conexión
            conn.close();

            // Redireccionar al usuario de vuelta a la página .jsp
            response.sendRedirect("misPqrs.jsp");

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