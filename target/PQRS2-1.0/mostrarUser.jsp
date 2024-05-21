<%@page import="com.umariana.pqrs2.listarUser"%>
<%@page import="com.umariana.pqrs2.User"%>
<%@page import="com.umariana.pqrs2.listarPqrs"%>
<%@page import="com.umariana.pqrs2.PQRS"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<!-- include para incluir un archivo dentro de otro, en este caso el header.  -->
<%@include file="templates/header.jsp"%>

<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color: #f5f5f5;">
    <div class="container-fluid" style="font-family: 'Archivo Black';">
        <a class="navbar-brand" href="#" style="color: black; font-family: times new roman; font-size: 24px;">
            <strong>Preguntas, Quejas, Reclamos y Sugerencias</strong> 
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="inicio.jsp">Inicio</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="misPqrs.jsp">Mis PQRS's</a>
                <% 
                    HttpSession sessi = request.getSession();
                   String tipo = (String) sessi.getAttribute("tipoPersona");
                   if (!tipo.equals("usuario")) {
                   %>
                    <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>
                    <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="mostrarUser.jsp">Mostrar Users</a>
                <% } %>
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <% String usuario = (String) session.getAttribute("nombre");
                           out.print(usuario); %>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
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
        max-width: 1200px;
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
        padding: 20px; /* Ajusta el espacio en los títulos */
        border: 1px solid #ddd;
        vertical-align: middle;
    }

    /* Style the table body */
    .table tbody td {
        text-align: center;
        padding: 10px; /* Ajusta el espacio en el contenido */
        border: 1px solid #ddd;
        vertical-align: middle;
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
                <th>Correo</th>
                <th>Contraseña</th>
                <th>Rol</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
        </thead>

        <tbody>
            <%
                List<User> listaUser = listarUser.listarUser();

                // Verificar si la lista no está vacía
                if (listaUser != null && !listaUser.isEmpty()) {
                    for (User miUser : listaUser) {
            %>
            <tr>
                <td><%= miUser.getNombre()%></td>
                <td><%= miUser.getApellido()%></td>
                <td><%= miUser.getTelefono()%></td>
                <td><%= miUser.getCedula()%></td>
                <td><%= miUser.getCorreo()%></td>
                <td><%= miUser.getContrasena()%></td>  
                <td><%= miUser.getRol()%></td>                    
                <td><%= miUser.getFecha()%></td>                    
                <td>                   

                    <button class="btn btn-warning btn-sm" onclick="editarUser(
                '<%= miUser.getNombre()%>',
                '<%= miUser.getApellido()%>',
                '<%= miUser.getTelefono()%>',
                '<%= miUser.getCedula()%>',
                '<%= miUser.getCorreo()%>',
                '<%= miUser.getContrasena()%>',
                '<%= miUser.getRol()%>'
                )">
                        <i class="fa fa-pencil-alt text-white"></i>
                    </button>


                    <form style="display: inline;">
    <input type="hidden" name="cedula" value="<%= miUser.getCedula() %>">
    <button type="button" class="btn btn-danger btn-sm" onclick="openModal('<%= miUser.getCedula() %>')">
        <i class="fa fa-trash text-white"></i>
    </button>
</form>
                                      
                </td>
            </tr>
            <% } %>
            <% } else { %>
            <tr>
                <td colspan="8" class="text-center">No se encontraron usuarios registrados.</td>
            </tr>
            <% }%>
        </tbody>
    </table>
</div>

  <div class="modal fade" id="confirmacionEliminarModal" tabindex="-1" aria-labelledby="confirmacionEliminarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmacionEliminarModalLabel">Confirmar eliminación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Deseas eliminar este usuario?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <form id="eliminarUserForm" action="svEliminarUser" method="post">
                    <input type="hidden" id="idUserEliminar" name="cedula">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function openModal(idUser) {
        document.getElementById("idUserEliminar").value = idUser;
        var modal = new bootstrap.Modal(document.getElementById('confirmacionEliminarModal'));
        modal.show();
    }
</script>


<!-- Modal de edición  -->
<div class="modal fade" id="editarUserModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="svEditarUser" method="POST" id="formEditarUser">
                    <!-- Campo oculto para almacenar el id -->
                    <input type="hidden" name="cedulaEdit" id="cedulaEdit">

                    <!-- Campo de edición para el nombre -->
                    <div class="row mb-3">                
                        <label for="nombreEdit"  class="col-sm-3 col-form-label">Nombre</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="nombreEdit" name="nombre" placeholder="Nombre" required>
                        </div>
                    </div>             

                    <!-- Campo de edición para el apellido -->
                    <div class="row mb-3">
                        <label for="apellidoEdit" class="col-sm-3 col-form-label"">Apellido</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="apellidoEdit" name="apellido" placeholder="Apellido" required>
                        </div>
                    </div>

                    <!-- Campo de edición para el teléfono -->
                    <div class="row mb-3">
                        <label for="telefonoEdit" class="col-sm-3 col-form-label">Teléfono</label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="telefonoEdit" name="telefono" placeholder="Teléfono" required>
                        </div>
                    </div>

                    <!-- Campo de edición para la cédula 
                    <div class="row mb-3">
                        <label for="cedulaEdit" class="col-sm-3 col-form-label">Cédula</label>
                        <div class="col-sm-9">
                            <span id="cedulaEditSpan"></span> 
                            <small class="text-muted" style="color: red;">La cédula no puede ser cambiada</small>
                        </div>
                    </div>-->

                    <div class="row mb-3">
                        <label for="correoEdit" class="col-sm-3 col-form-label">Correo</label>
                        <div class="col-sm-9">
                            <input class="form-control" type="email" placeholder="Correo electronico" name="correo" id="correoEdit" required/>     
                        </div>
                    </div>

                    <div class="row mb-3">
                    <div class="input-group">
                        <label for="contrasenaEdit" class="col-sm-3 col-form-label"">Contraseña</label>
                        <div class="col-sm-9">
                        <input class="form-control" type="password" placeholder="Contraseña" name="contrasena" id="contrasenaInput" required/>                        
                       
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary p-0" type="button" id="togglePassword">
                                <i class="far fa-eye-slash" id="eyeIcon"></i>
                            </button>
                        </div>
                        </div>
                        
                    </div>                        
                    </div>                                         

                    <div class="row mb-3">
                        <label for="rolEdit" class="col-sm-3 col-form-label">Rol</label>
                        <div class="col-sm-9">
                            <select class="form-select" id="rolEdit" name="rol" aria-label="Default select example" required>
                                <option value="Admin">Admin</option>
                                <option value="Usuario">Usuario</option>
                            </select>
                        </div>
                    </div>                                                                                                                                     

                    <!-- Botón para enviar el formulario de edición -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        <button type="button" class="btn btn-danger btn-success mx-2" data-bs-dismiss="modal">Cancelar</button>

                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function editarUser(nombre, apellido, telefono, cedula, correo, contrasena, rol) {
        // Set values for other fields
        document.getElementById('nombreEdit').value = nombre;
        document.getElementById('apellidoEdit').value = apellido;
        document.getElementById('telefonoEdit').value = telefono;
        document.getElementById('cedulaEdit').value = cedula;
        document.getElementById('correoEdit').value = correo;
        document.getElementById('contrasenaInput').value = contrasena;

        // Set the selected option for 'rol'
        const rolSelect = document.getElementById('rolEdit');
        for (let i = 0; i < rolSelect.options.length; i++) {
            if (rolSelect.options[i].value === rol) {
                rolSelect.selectedIndex = i;
                break;
            }
        }

        // Show the modal
        const modal = new bootstrap.Modal(document.getElementById('editarUserModal'));
        modal.show();
    }
</script>




<!-- Script para manejar la apertura del modal y enviar el ID del tutorial -->
<script>
    function editar(cedula) {
        // Establecer el valor del ID del user en el campo oculto del formulario de edición
        document.getElementById("idUserEdit").value = cedula;
        // Mostrar el modal de edición
        var editarUserModal = new bootstrap.Modal(document.getElementById('editarUserModal'), {
            keyboard: false
        });
        editarUserModal.show();
    }
</script>

<footer class="text-black py-4" style="background-color: #f5f5f5;">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Contacto</h5>
                <p>Universidad Mariana</p>
                <p>Barrio Maridiaz, Pasto</p>
                <p>Teléfono: 323215796</p>
            </div>
            <div class="col-md-6">
                <h5>Información</h5>
                <p>Somos una institución educativa comprometida con la excelencia académica y la formación integral de nuestros estudiantes.</p>
                <p>Ubicados en la ciudad de Pasto, capital del departamento de Nariño en Colombia, en el barrio Maridiaz.</p>     
            </div>
        </div>
        <p>&copy; 2024 Universidad Mariana</p>

    </div>
</footer>
<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
