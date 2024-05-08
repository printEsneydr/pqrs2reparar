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
    
   private String nombre;
    private String apellido;
    private String telefono;
    private String cedula;
    private String tipo;
    private String descripcion;    
    private LocalDateTime fecha;
    private String nombreArchivoPDF;


    public PQRS(String nombre, String apellido, String telefono, String cedula, String tipo, String descripcion, LocalDateTime fecha) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.cedula = cedula;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.fecha = fecha;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getCedula() {
        return cedula;
    }

    public void setCedula(String cedula) {
        this.cedula = cedula;
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

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    } 
    // Método para obtener la fecha formateada como texto
public String getFormattedFecha() {
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("DD-MM-YYYY HH:MM:SS a");
    return fecha.format(formatter);
}
public String getNombreArchivoPDF() {
    return nombreArchivoPDF;
}

public void setNombreArchivoPDF(String nombreArchivoPDF) {
    this.nombreArchivoPDF = nombreArchivoPDF;
}
}
