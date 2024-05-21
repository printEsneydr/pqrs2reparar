/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.umariana.pqrs2;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author esney
 */
public class User {
    
    private String nombre;
    private String apellido;
    private String telefono;
    private String cedula;
    private String correo;
    private String contrasena;
    private String rol;
    private LocalDateTime fecha;
        private int idUsuario; // Añadir este campo


    public User(String nombre, String apellido, String telefono, String cedula, String correo, String contrasena, String rol, LocalDateTime fecha, int idUsuario) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.telefono = telefono;
        this.cedula = cedula;
        this.correo = correo;
        this.contrasena = contrasena;
        this.rol = rol;
        this.fecha = fecha;
                this.idUsuario = idUsuario; // Asignar este campo

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

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }
    
       public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
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
