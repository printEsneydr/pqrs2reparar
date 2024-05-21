/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.umariana.pqrs2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

/**
 *
 * @author esney
 */
public class agregarPqrs {

  public static void aggPqrs(String tut_idUsuario, String tut_idPqrs, String tut_descripcion, String tut_Archivo, String archivo, LocalDateTime tut_Fecha) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        gestionarPQRS gestionar = new gestionarPQRS(); // Crear una instancia de gestionarPQRS

        try {
            // Obtener conexión a la base de datos

        conn = gestionar.establecerConexion(); // Llamar al método en la instancia

            // Preparar la consulta SQL
            String sql = "INSERT INTO pqrs (idUsuario, idPqrs, descripcion, archivo) "
                    + "VALUES (?, ?, ?, ?, ?(')";
            pstmt = conn.prepareStatement(sql);

            // Establecer los parámetros de la consulta
            pstmt.setString(1, tut_idUsuario);
            pstmt.setString(2, tut_idPqrs);
            pstmt.setString(3, tut_descripcion);
            pstmt.setString(4, tut_Archivo);

            // Ejecutar la consulta
            pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Cerrar la conexión y liberar los recursos
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
  
}
