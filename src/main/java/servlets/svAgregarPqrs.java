package servlets;

import com.umariana.pqrs2.gestionarPQRS;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
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
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, 
        maxFileSize = 1024 * 1024 * 10, 
        maxRequestSize = 1024 * 1024 * 50) 
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
                //String nombre = request.getParameter("nombre");
                //String apellido = request.getParameter("apellido");
                //String telefono = request.getParameter("telefono");
                String idPqrs = request.getParameter("idPqrs");   
                 if (gestionar.existePqrs(idPqrs)) {
                    request.setAttribute("error", true);
                    // Redireccionar al formulario de agregar 
                    request.getSession().setAttribute("userActionError", true);
                    request.getRequestDispatcher("formulario.jsp").forward(request, response);
                    return;
                }
                String tipo = request.getParameter("tipo");
                String idUsuario = request.getParameter("idUsuario");
                String descripcion = request.getParameter("descripcion");
                //String fecha = request.getParameter("fecha");

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
            
       
                
                // Obtener todo seleccionada del formulario
                CallableStatement stmt = conn.prepareCall("{call agregar(?, ?, ?, ?, ?)}");
                //stmt.setString(1, nombre);
                //stmt.setString(2, apellido);
                stmt.setString(1, idUsuario);
                stmt.setString(2, idPqrs);               
                stmt.setString(3, tipo);
                stmt.setString(4, descripcion);
                stmt.setString(5, archivo);

                //stmt.setString(6, fecha);


                // Ejecutar la consulta para agregar la pqrs
                stmt.execute();
                conn.close();

                response.sendRedirect("misPqrs.jsp");
                System.out.println("Conexion exitosa, se envio tu pqrs");
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Error al agregar la pqrs: " + e.getMessage());
            }
        } else {
            response.getWriter().println("No se pudo establecer una conexión a la base de datos.");
        }
    }

}



    


