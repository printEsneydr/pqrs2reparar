package com.umariana.pqrs2;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author esney
 */
public class gestionarPQRS 
{             
    public Connection establecerConexion ()
    {               
        String url = "jdbc:mysql://localhost:3306/pqrsDb?serverTimeZone=utc";
        String user = "root";
        String password = "123456";      
        Connection conn = null;
        
        try {            
            // Carga del driver JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Establecimiento de la conexión
            conn = DriverManager.getConnection(url, user, password);
            if (conn != null){
                System.out.println("Conexion exitosa");              
            }
        } catch (Exception e){
            System.out.println("error de conexion"+e.getMessage());
        }
        return conn;
    }            
  
  public void usuario(String nombre, String apellido, String telefono, String cedula, String correo, String contrasena, String rol) {
        Connection conn = establecerConexion();
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall("{ call agregarUsuarios(?, ?, ?, ?, ?, ?, ?) }");
            cs.setString(1, nombre);
            cs.setString(2, apellido);
            cs.setString(3, telefono);
            cs.setString(4, cedula);
            cs.setString(5, correo);
            cs.setString(6, contrasena);
            cs.setString(7, rol);
            
            cs.execute();
            
        } catch (SQLException e) 
        {
            System.out.println("error al crear el nuevo user" + e.getMessage());
        } finally 
        {
            try 
            {
                if (cs != null) 
                {
                    cs.close();
                }
                if (conn != null)
                {
                    conn.close();
                }
            } catch (SQLException ex) 
            {
                System.out.println("Error" + ex.getMessage());
            }
        }
    }
  
  
  public boolean existeUser(String correo)
  {

      String sql = "SELECT COUNT(*) AS count FROM usuarios WHERE correo = ?";

        try (Connection conn = establecerConexion(); PreparedStatement pstmt = conn.prepareStatement(sql)) 
        {
            pstmt.setString(1, correo);
            
            ResultSet rs = pstmt.executeQuery();
            
            
            if (rs.next()) 
            {
                int count = rs.getInt("count");
                
                return count > 0;
            }
        } 
        catch (SQLException e) 
        
        {
            System.out.println("Error" + e.getMessage());
        }

        return false;
    }
  
  
     public String[] login(String correo, String contrasena) 
     {
        Connection conn = establecerConexion();
        
        String[] credenciales = null;

        try 
        {
            String sql = "SELECT idUsuario, rol, nombre FROM usuarios WHERE correo= ? AND contrasena = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, correo);            
            
            pstmt.setString(2, contrasena);
            
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) 
            {
                int idUsuario = rs.getInt("idUsuario");
                System.out.println("correo" + correo + "contraseña"+ contrasena );

                String rol = rs.getString("rol");
                
                String nombre = rs.getString("nombre");
                
                credenciales = new String[]{String.valueOf(idUsuario), rol, nombre};
            }
//cerramos
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            System.out.println("No se puede iniciar sesion" + e.getMessage());
        }

        return credenciales;
    }
     
     public List<PQRS> consultarPqrsUsuario(int idUsuario) {
    List<PQRS> pqrsList = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = establecerConexion();
        String sql = "SELECT * FROM pqrs WHERE idUsuario = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idUsuario);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            // Obtener los datos de la PQRS y crear un objeto PQRS
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            String telefono = rs.getString("telefono");
            String cedula = rs.getString("cedula");
            String tipo = rs.getString("tipo");
            String descripcion = rs.getString("descripcion");
   Timestamp timestamp = rs.getTimestamp("fecha");
LocalDateTime fecha = timestamp.toLocalDateTime();

// Crea un objeto PQRS con la fecha convertida a Date
PQRS pqrs = new PQRS(nombre, apellido, telefono, cedula, tipo, descripcion, fecha); 
            // Agregar la PQRS a la lista de PQRS del usuario
            pqrsList.add(pqrs);
        }
    } catch (SQLException e) {
        System.out.println("Error al consultar las PQRS del usuario: " + e.getMessage());
    } finally {
        // Cerrar recursos
        try {
            if (rs != null) {
                rs.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ex) {
            System.out.println("Error al cerrar los recursos: " + ex.getMessage());
        }
    }

    return pqrsList;
}


    public Connection getConnection() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
