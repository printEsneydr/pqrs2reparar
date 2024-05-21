/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.umariana.pqrs2;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author esney
 */
public class PQRS {
    
    
   // private String idUsuario;
    private String idPqrs;
    private String tipo;
    private String descripcion;    
    private String archivo;
    private LocalDateTime fecha;
    private String correo;
        private int idUsuario; 


         public PQRS(String idPqrs, String tipo, String descripcion, String archivo, LocalDateTime fecha, String correo, int idUsuario) {
        this.idPqrs = idPqrs;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.archivo = archivo;
        this.fecha = fecha;
        this.correo = correo;
                this.idUsuario = idUsuario; 

    }

    public String getIdPqrs() {
        return idPqrs;
    }

    public void setIdPqrs(String idPqrs) {
        this.idPqrs = idPqrs;
    }
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getIdUsuario() {
        return idUsuario; // Getter para idUsuario
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario; // Setter para idUsuario
    }
    
    // Método para obtener la fecha formateada como texto
public String getFormattedFecha() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("DD-MM-YYYY HH:MM:SS a");
    return fecha.format(formatter);
}
}