
<%@page import="com.umariana.pqrs2.listarPqrs"%>
<%@page import="com.umariana.pqrs2.PQRS"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<!-- include para incluir un archivo dentro de otro, en este caso el header.  -->
<%@include file="templates/header.jsp"%>
<%
    String rol = (String) session.getAttribute("rol");

    // Verificar si el usuario es un administrador
    if (rol != null && rol.equals("Admin")) {
%>
<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color: #f5f5f5;">
    <div style="font-family: 'Archivo Black';" class="container-fluid">
        <label class="navbar-brand" style="color: #black; background-color: E2E2E2; font-family: times new roman; font-size: 24px">Preguntas, Quejas, Reclamos y Sugerencias</label>
        <div class="navbar bg-body-tertiary" id="navbarSupportedContent">           
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- opcion de salir o cerrar sesion -->
            <div style="background-color: #f5f5f5; border-color: #f5f5f5 " class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; margin-right: 35px; color: black" aria-current="page" href="inicio.jsp">Inicio </a>
                <a class="nav-link active " style="font-family: times new roman; font-size: 20px; margin-right: 35px; color: black" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; margin-right: 35px; color: black" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>
                 <%            
                     HttpSession sessi = request.getSession();
          
                     String tipo = (String) sessi.getAttribute("tipoPersona");
                     System.out.println(tipo);
                     if (!tipo.equals("usuario"))
                     {
                     
                
            %>
                <a class="nav-link active " style="font-family: times new roman; font-size: 20px; color: black; margin-right: 35px;" aria-current="page" href="admin.jsp">Agregar un Administrador</a>
 <%
                    }
                    %>
               <div class="nav-item dropdown text-center">
    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
        <%
            String usuario = (String) session.getAttribute("nombre");
            out.print(usuario);
        %>
    </a> 
    <ul class="dropdown-menu" style="list-style: none;">
        <li><a class="dropdown-item" href="index.jsp">Salir</a></li>
    </ul>
</div>
                
            </div>
        </div>
    </div>
</nav>

<!-- Agregar banner para interfaz principal -->
<nav class="navbar navbar-light bg-light">
    <a class="img-fluid mx-auto navbar-brand">
        <img src="img/pqrs.png" style="width: 70%; height: auto;" class="d-inline-block align-top" alt="banner">    
    </a>
</nav>
<style>
    /* Style the table container */
    .table-container {
        margin: 50px auto;
        max-width: 900px;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    /* Style the table header */
    .table thead th {
        background-color: #f5f5f5;
        color: #333;
        font-weight: bold;
        text-align: center;
        padding: 10px;
        border: 1px solid #ddd;
    }

    /* Style the table body */
    .table tbody td {
        text-align: center;
        padding: 8px;
        border: 1px solid #ddd;
    }

    /* Style the table actions buttons */
    .table button {
        margin: 5px;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
    }

    /* Style the 'Ver' button */
    .table .btn-primary {
        background-color: #007bff;
        color: #fff;
        border: none;
    }

    /* Style the 'Editar' button */
    .table .btn-warning {
        background-color: #ffc107;
        color: #fff;
        border: none;
    }

    /* Style the 'Eliminar' button */
    .table .btn-danger {
        background-color: #dc3545;
        color: #fff;
        border: none;
    }
</style>
<div class="container-fluid table-container">
    <table class="table table-striped table-hover">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Teléfono</th>
                <th>Cédula</th>
                <th>Tipo</th>
                <th>Descripción</th>
                <th>Archivo PDF</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
        </thead>

        <tbody>
           <% for (PQRS pqrs : (List<PQRS>) request.getAttribute("pqrsList")) { %>                      
                <tr>
                    <td><%= pqrs.getNombre() %></td>
                    <td><%= pqrs.getApellido() %></td>
                    <td><%= pqrs.getTelefono() %></td>
                    <td><%= pqrs.getCedula() %></td>
                    <td><%= pqrs.getTipo() %></td>
                    <td><%= pqrs.getDescripcion() %></td>
                    <td><%= pqrs.getNombreArchivoPDF() %></td>
                    <td><%= pqrs.getFecha() %></td>                

                <td>                   
                    <button class="btn btn-warning btn-sm" onclick="editarTutorial(<%= pqrs.getNombre()%>)">
                        <i class="fa fa-pencil-alt text-white"></i>
                    </button>
                    <form action="svEliminarTutorial" method="post" style="display: inline;">
                        <input type="hidden" name="idTutorial" value="<%= pqrs.getNombre()%>">
                        <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('¿Está seguro de que desea eliminar esta pqrs?');">
                            <i class="fa fa-trash text-white"></i>
                        </button>
                    </form>
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="8" class="text-center">No se encontraron PQRS.</td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>


<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
