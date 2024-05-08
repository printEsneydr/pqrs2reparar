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
        
        try (Connection conn = conexion.establecerConexion();
             PreparedStatement statement = conn.prepareStatement("SELECT * FROM pqrs;");
             ResultSet resultSet = statement.executeQuery()) {
            
            while (resultSet.next()) {
                String nombre = resultSet.getString("nombre");
                String apellido = resultSet.getString("apellido");
                String telefono = resultSet.getString("telefono");
                String cedula = resultSet.getString("cedula");
                String tipo = resultSet.getString("tipo");
                String descripcion = resultSet.getString("descripcion");
                              //String pdf = resultSet.getString("pdf_data");
   Timestamp timestamp = resultSet.getTimestamp("fecha");
LocalDateTime fecha = timestamp.toLocalDateTime();

// Crea un objeto PQRS con la fecha convertida a Date
PQRS pqrs = new PQRS(nombre, apellido, telefono, cedula, tipo, descripcion, fecha); 
pqrsList.add(pqrs);




            }
        } catch (SQLException e) {
            System.err.println("Error al obtener las pqrs: " + e.getMessage());
            throw e;
        }
        
        return pqrsList;
    }
    }



