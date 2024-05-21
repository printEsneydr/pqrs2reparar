<%@page import="java.util.stream.Collectors"%>
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
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="mostrarUser.jsp">Mostrar Users</a>
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
                <th>ID</th>
                <th>Tipo</th>
                <th>Descripción</th>
                <th>Archivo PDF</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
             <%
                // Obtener la lista de usuarios llamando al método estático listarUser()
                List<User> listaUser = listarUser.listarUser();
                // Obtener la lista de PQRS llamando al método estático listarPqrs()
                List<PQRS> listaPqrs = listarPqrs.listarPqrs();
                
                // Verificar si las listas no están vacías
                if (listaUser != null && !listaUser.isEmpty() && listaPqrs != null && !listaPqrs.isEmpty()) {
                    // Iterar sobre la lista de usuarios
                    for (User miUser : listaUser) {
                        // Filtrar las PQRS que pertenecen al usuario actual
                        List<PQRS> pqrsDelUsuario = listaPqrs.stream()
                                                             .filter(pqrs -> pqrs.getIdUsuario() == miUser.getIdUsuario())
                                                             .collect(Collectors.toList());

                        // Iterar sobre la lista de PQRS filtradas para mostrar cada una en la tabla
                        for (PQRS miPqrs : pqrsDelUsuario) {
            %>
            <tr> 
                <td><%= miUser.getNombre() %></td>
                <td><%= miPqrs.getIdPqrs()%></td>                
                <td><%= miPqrs.getTipo()%></td>
                <td><%= miPqrs.getDescripcion()%></td>                    
                <td><%= miPqrs.getArchivo()%></td>
                <td><%= miPqrs.getFecha()%></td>
                <td>                   
                    <!--<button class="btn btn-warning btn-sm" onclick="editarPQRS(
                                    '<%= miPqrs.getIdPqrs()%>',
                                    '<%= miPqrs.getTipo()%>',
                                    '<%= miPqrs.getDescripcion()%>',
                                    '<%= miPqrs.getArchivo()%>'
                                    )">
                        <i class="fa fa-pencil-alt text-white"></i>
                    </button>                      
                    <form style="display: inline;">
                        <input type="hidden" name="idPqrs" value="<%= miPqrs.getIdPqrs()%>">
                        <button type="button" class="btn btn-danger btn-sm" onclick="openModal('<%= miPqrs.getIdPqrs()%>')">
                            <i class="fa fa-trash text-white"></i>
                        </button>
                    </form>-->

                    <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#sendEmailModal" data-email="<%= miPqrs.getCorreo()%>">
                        Enviar Correo
                    </button>

                    <form method="post" action="svActualizarEstadoPqrs" style="display: inline;">
                        <input type="hidden" name="idPqrs" value="<%= miPqrs.getIdPqrs()%>">
                        <input type="hidden" name="nuevoEstado" value="Revisada">
                        <button type="submit" class="btn btn-success btn-sm">
                            Marcar Revisada
                        </button>
                    </form>

                </td>
 </tr>
            <%     } // Fin del bucle sobre las PQRS del usuario %>
            <%   } // Fin del bucle sobre los usuarios %>
            <% } else { %>
            <tr>
                <td colspan="7" class="text-center">No se encontraron PQRS.</td>
            </tr>
            <% } %>        </tbody>
    </table>
</div>
<script>
    function actualizarEstadoPqrs(idPqrs, nuevoEstado) {
        $.post("svActualizarEstadoPqrs", {idPqrs: idPqrs, nuevoEstado: nuevoEstado}, function (response) {
            location.reload();
        });
    }

</script>
<!-- Modal para enviar correo -->
<div class="modal fade" id="sendEmailModal" tabindex="-1" role="dialog" aria-labelledby="sendEmailModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="svSendEmail" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="sendEmailModalLabel">Enviar Correo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="emailTo">Correo del Usuario</label>
                        <input type="email" class="form-control" id="emailTo" name="emailTo" readonly>
                    </div>
                    <div class="form-group">
                        <label for="subject">Asunto</label>
                        <input type="text" class="form-control" id="subject" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="content">Mensaje</label>
                        <textarea class="form-control" id="content" name="content" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary">Enviar Correo</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
            $('#sendEmailModal').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget);
                var email = button.data('email');
                var modal = $(this);
                modal.find('.modal-body #emailTo').val(email);
            });
</script>

<div class="modal fade" id="confirmacionEliminarModal" tabindex="-1" aria-labelledby="confirmacionEliminarModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmacionEliminarModalLabel">Confirmar eliminación</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                ¿Deseas eliminar esta pqrs?
            </div>
            <div class="modal-footer">
                <form id="eliminarSolicitudForm" action="svEliminar" method="post">
                    <input type="hidden" id="idPqrsEliminar" name="idPqrs">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                </form>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>

<script>
    function openModal(idPqrs) {
        document.getElementById("idPqrsEliminar").value = idPqrs;
        var modal = new bootstrap.Modal(document.getElementById('confirmacionEliminarModal'));
        modal.show();
    }
</script>

<!-- Modal de edición de PQRS -->
<div class="modal fade" id="editarPQRSModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar PQRS</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="svEditar" method="POST" id="formEditarPQRS" enctype="multipart/form-data">
                    <!-- Campo oculto para almacenar el ID de la PQRS -->
                    <input type="hidden" name="idPqrsEdit" id="idPqrsEdit">

                   <!-- <div class="row mb-3">
                        <label for="idPqrsEdit" class="col-sm-3 col-form-label">ID</label>
                        <div class="col-sm-9">
                            <span id="cedulaEditSpan"></span> 
                            <small class="text-muted" style="color: red;">EL identificador no puede ser cambiado</small> 
                        </div>
                    </div>-->

                    <div class="row mb-3">
                        <label for="tipoEdit" class="col-sm-3 col-form-label">Tipo de PQRS</label>
                        <div class="col-sm-9">
                            <select class="form-select" id="tipoEdit" name="tipo" aria-label="Default select example" required>
                                <option value="Pregunta">Pregunta</option>
                                <option value="Queja">Queja</option>
                                <option value="Reclamo">Reclamo</option>
                                <option value="Sugerencia">Sugerencia</option>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="descripcionEdit" class="col-sm-3 col-form-label">Descripción</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" id="descripcionEdit" name="descripcion" rows="5" placeholder="Actualiza la situación" required></textarea>
                            <div class="wordCountMessage" id="wordCount">Tiene un máximo de 50 palabras</div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <label for="archivoEdit" class="col-sm-3 col-form-label">Archivo PDF</label>
                        <div class="col-sm-9">
                            <input  class="form-control" type="file" name="archivo" id="archivoEdit" accept=".pdf" required>
                            <div style="color: red" id="archivoSeleccionado"></div><br>
                        </div>                                                    

                    </div>
                    
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
    function editarPQRS(idPqrs, tipo, descripcion, archivo) {
        // Set values for other fields
        document.getElementById('idPqrsEdit').value = idPqrs;
        document.getElementById('descripcionEdit').value = descripcion;

        document.getElementById('archivoSeleccionado').textContent = archivo;

// Set the selected option for 'tipo'
        const tipoSelect = document.getElementById('tipoEdit');
        for (let i = 0; i < tipoSelect.options.length; i++) {
            if (tipoSelect.options[i].value === tipo) {
                tipoSelect.selectedIndex = i;
                break;
            }
        }

        // Show the modal
        var editarPQRSModal = new bootstrap.Modal(document.getElementById('editarPQRSModal'));
        editarPQRSModal.show();
    }
</script>
<!-- Script para manejar la apertura del modal y enviar el ID del tutorial -->
<script>
    function editar(idPqrs) {
        // Establecer el valor del ID del pqrs en el campo oculto del formulario de edición
        document.getElementById("idPqrsEdit").value = idPqrs;
        // Mostrar el modal de edición
        var editarPQRSModal = new bootstrap.Modal(document.getElementById('editarPQRSModal'), {
            keyboard: false
        });
        editarPQRSModal.show();
    }
</script>
<!-- este script no permite que la tecla enter funcione dentro del textarea para evitar error en agregar tarea-->
<script>
    document.getElementById('descripcionEdit').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            // Evitar el salto de línea
            e.preventDefault();
        }
    });
</script>
<!-- este script maneja el exceso de palabras para el textarea de la descripcion-->
<script>

    var descripcionEditField = document.getElementById("descripcionEdit");
    var wordCount = document.getElementById("wordCount");

    var maxWords = 50;

    descripcionEditField.addEventListener("input", function (e) {
        var words = descripcionEditField.value.trim().split(/\s+/);
        var wordCountValue = words.length;

        wordCount.textContent = wordCountValue + " palabras de " + maxWords + " (máximo)";

        if (wordCountValue > maxWords) {
            descripcionEditField.value = words.slice(0, maxWords).join(" ");
            wordCount.textContent = maxWords + " palabras de " + maxWords + " (máximo)";
            wordCount.style.color = "#888";
            wordCount.classList.add("wordCountMessage");
        } else {
            wordCount.style.color = "#888";
            wordCount.classList.remove("wordCountMessage");
        }
    });
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
