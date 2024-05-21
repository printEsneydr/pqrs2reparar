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
public class PQRS2 {
    
    
   // private String idUsuario;
    private String idPqrs;
    private String tipo;
    private String descripcion;    
    private String archivo;
    private LocalDateTime fecha;
private String estado;

    public PQRS2(String idPqrs, String tipo, String descripcion, String archivo, LocalDateTime fecha, String estado) {
        this.idPqrs = idPqrs;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.archivo = archivo;
        this.fecha = fecha;
        this.estado = estado;
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
public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    // Método para obtener la fecha formateada como texto
public String getFormattedFecha() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("DD-MM-YYYY HH:MM:SS a");
    return fecha.format(formatter);
}
}