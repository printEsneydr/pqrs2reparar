<%@page import="com.umariana.pqrs2.PQRS2"%>
<%@ page import="java.util.List" %>
<%@ page import="com.umariana.pqrs2.gestionarPQRS" %>

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
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="misPqrs.jsp">Mis PQRS's</a>
                <% 
                    HttpSession sessi = request.getSession();
                   String tipo = (String) sessi.getAttribute("tipoPersona");
                   if (!tipo.equals("usuario")) {
                   %>
                    <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>
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
        padding: 20px; /* Ajusta el espacio en los t�tulos */
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
                <th>ID</th>
                <th>Tipo</th>
                <th>Descripci�n</th>
                <th>Archivo PDF</th>
                <th>Fecha</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <%
// Crear una instancia de la clase gestionarPQRS
                gestionarPQRS gestionar = new gestionarPQRS();
// Obtener el ID del usuario de la sesi�n
                String idUsuarioString = (String) session.getAttribute("idUsuario");
                int idUsuario = Integer.parseInt(idUsuarioString);
// Consultar las PQRS del usuario desde la base de datos
                List<PQRS2> pqrsList = gestionar.consultarPqrsUsuario(idUsuario);
            %>
            <% for (PQRS2 pqrs : pqrsList) {%>
            <tr>
                <td><%= pqrs.getIdPqrs()%></td>
                <td><%= pqrs.getTipo()%></td>
                <td><%= pqrs.getDescripcion()%></td>
                <td><%= pqrs.getArchivo()%></td>
                <td><%= pqrs.getFecha()%></td> 
                <td><%= pqrs.getEstado()%></td>
                <td>           
                    <% if (!"Revisada".equals(pqrs.getEstado())) { %>
                    <button class="btn btn-warning btn-sm" onclick="editarPQRS(
                                    '<%= pqrs.getIdPqrs()%>',
                                    '<%= pqrs.getTipo()%>',
                                    '<%= pqrs.getDescripcion()%>',
                                    '<%= pqrs.getArchivo()%>'
                                    )">
                        <i class="fa fa-pencil-alt text-white"></i>
                    </button>
                    <form style="display: inline;">
    <input type="hidden" name="idPqrs" value="<%= pqrs.getIdPqrs() %>">
    <button type="button" class="btn btn-danger btn-sm" onclick="openPqrsModal('<%= pqrs.getIdPqrs() %>')">
        <i class="fa fa-trash text-white"></i>
    </button>
</form>       
         <% } else { %>
                        <button class="btn btn-secondary btn-sm" disabled>
                            <i class="fa fa-pencil-alt text-white"></i>
                        </button>
                        <button class="btn btn-secondary btn-sm" disabled>
                            <i class="fa fa-trash text-white"></i>
                        </button>
                    <% } %>                
                </td>
            </tr>
            <% }%>           
        </tbody>
    </table>
</div>
<div class="modal fade" id="confirmacionEliminarPqrsModal" tabindex="-1" aria-labelledby="confirmacionEliminarPqrsModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmacionEliminarPqrsModalLabel">Confirmar eliminaci�n</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                �Deseas eliminar esta pqrs?
            </div>
            <div class="modal-footer">
                <form id="eliminarPqrsForm" action="svEliminar" method="post">
                    <input type="hidden" id="idPqrsEliminar" name="idPqrs">
                    <button type="submit" class="btn btn-danger">Eliminar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    function openPqrsModal(idPqrs) {
        document.getElementById("idPqrsEliminar").value = idPqrs;
        var modal = new bootstrap.Modal(document.getElementById('confirmacionEliminarPqrsModal'));
        modal.show();
    }
</script>
<!-- Modal de edici�n de PQRS -->
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

                    <!-- Campo de edici�n para la descripci�n -->
                    <div class="row mb-3">
                        <label for="descripcionEdit" class="col-sm-3 col-form-label">Descripci�n</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" id="descripcionEdit" name="descripcion" rows="5" placeholder="Actualiza la situaci�n" required></textarea>
                            <div class="wordCountMessage" id="wordCount">Tiene un m�ximo de 50 palabras</div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <label for="archivoEdit" class="col-sm-3 col-form-label">Archivo PDF</label>
                        <div class="col-sm-9">
                            <input  class="form-control" type="file" name="archivo" id="archivoEdit" accept=".pdf" required>
                            <div style="color: red" id="archivoSeleccionado"></div><br>
                        </div>                                                    

                    </div>

                    <!-- Bot�n para enviar el formulario de edici�n -->
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
        // Establecer el valor del ID del pqrs en el campo oculto del formulario de edici�n
        document.getElementById("idPqrsEdit").value = idPqrs;
        // Mostrar el modal de edici�n
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
            // Evitar el salto de l�nea
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

        wordCount.textContent = wordCountValue + " palabras de " + maxWords + " (m�ximo)";

        if (wordCountValue > maxWords) {
            descripcionEditField.value = words.slice(0, maxWords).join(" ");
            wordCount.textContent = maxWords + " palabras de " + maxWords + " (m�ximo)";
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
                <p>Tel�fono: 323215796</p>
            </div>
            <div class="col-md-6">
                <h5>Informaci�n</h5>
                <p>Somos una instituci�n educativa comprometida con la excelencia acad�mica y la formaci�n integral de nuestros estudiantes.</p>
                <p>Ubicados en la ciudad de Pasto, capital del departamento de Nari�o en Colombia, en el barrio Maridiaz.</p>     
            </div>
        </div>
        <p>&copy; 2024 Universidad Mariana</p>

    </div>
</footer>
<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
