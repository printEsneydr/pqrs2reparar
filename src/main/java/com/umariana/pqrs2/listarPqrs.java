/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.umariana.pqrs2;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author esney
 */
public class listarPqrs {
    public static List<PQRS> listarPqrs() throws SQLException, ParseException {
        List<PQRS> pqrsList = new ArrayList<>();
        gestionarPQRS conexion = new gestionarPQRS();

        String query = "SELECT pqrs.*, usuarios.correo, pqrs.idUsuario " +
                       "FROM pqrs " +
                       "JOIN usuarios ON pqrs.idUsuario = usuarios.idUsuario";

        try (Connection conn = conexion.establecerConexion();
             PreparedStatement statement = conn.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                String idPqrs = resultSet.getString("idPqrs");
                String tipo = resultSet.getString("tipo");
                String descripcion = resultSet.getString("descripcion");
                String archivo = resultSet.getString("archivo");
                Timestamp timestamp = resultSet.getTimestamp("fecha");
                LocalDateTime fecha = timestamp.toLocalDateTime();
                String correo = resultSet.getString("correo");
                int idUsuario = resultSet.getInt("idUsuario"); // Obtener idUsuario

                PQRS pqrs = new PQRS(idPqrs, tipo, descripcion, archivo, fecha, correo, idUsuario); 
                pqrsList.add(pqrs);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener las pqrs: " + e.getMessage());
            throw e;
        }

        return pqrsList;
    }
}




