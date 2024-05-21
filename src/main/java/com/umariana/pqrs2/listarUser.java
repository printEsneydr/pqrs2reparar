/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.umariana.pqrs2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author esney
 */
public class listarUser {

    //metodo para listar los usuarios
    public static List<User> listarUser() throws SQLException, ParseException {
        List<User> UserList = new ArrayList<>();
        gestionarPQRS conexion = new gestionarPQRS();

        try (Connection conn = conexion.establecerConexion(); PreparedStatement statement = conn.prepareStatement("SELECT * FROM usuarios;"); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String nombre = resultSet.getString("nombre");
                String apellido = resultSet.getString("apellido");
                String telefono = resultSet.getString("telefono");
                String cedula = resultSet.getString("cedula");
                String correo = resultSet.getString("correo");
                String contrasena = resultSet.getString("contrasena");
                String rol = resultSet.getString("rol");                
                Timestamp timestamp = resultSet.getTimestamp("fecha");
                LocalDateTime fecha = timestamp.toLocalDateTime();
                int idUsuario = resultSet.getInt("idUsuario");
                
                User user = new User(nombre, apellido, telefono, cedula, correo, contrasena, rol, fecha, idUsuario);
                UserList.add(user);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener las pqrs: " + e.getMessage());
            throw e;
        }

        return UserList;
    }
}
