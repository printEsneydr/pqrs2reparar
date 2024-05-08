
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
            <%
                // Obtener la lista de PQRS llamando al método estático listarPqrs()
                List<PQRS> listaPqrs = listarPqrs.listarPqrs();

                // Verificar si la lista no está vacía
                if (listaPqrs != null && !listaPqrs.isEmpty()) {
                    // Iterar sobre la lista de PQRS para mostrar cada una en la tabla
                    for (PQRS miPqrs : listaPqrs) {
            %>
            <tr>
                <td><%= miPqrs.getNombre()%></td>
                <td><%= miPqrs.getApellido()%></td>
                <td><%= miPqrs.getTelefono()%></td>
                <td><%= miPqrs.getCedula()%></td>
                <td><%= miPqrs.getTipo()%></td>
                <td><%= miPqrs.getDescripcion()%></td>                    
                <td>hola.PDF</td>
                <td><%= miPqrs.getFecha()%></td>

                <td>                   
   

<button class="btn btn-warning btn-sm" onclick="editarPQRS(
    '<%= miPqrs.getNombre()%>',
    '<%= miPqrs.getApellido()%>',
    '<%= miPqrs.getTelefono()%>',
    '<%= miPqrs.getCedula()%>',
    '<%= miPqrs.getTipo()%>',
    '<%= miPqrs.getDescripcion()%>'
)">
    <i class="fa fa-pencil-alt text-white"></i>
</button>

                    <form action="svEliminar" method="post" style="display: inline;">
                        <input type="hidden" name="cedula" value="<%= miPqrs.getCedula()%>">
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

<%
    } else {
        response.sendRedirect("index.jsp"); // Redirigir a la página de inicio si el usuario no es un administrador
    }
%>
<!-- Modal de edición de PQRS -->
<div class="modal fade" id="editarPQRSModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar PQRS</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="svEditar" method="POST" id="formEditarPQRS">
                    <!-- Campo oculto para almacenar el ID de la PQRS -->
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
                    
                    <!-- Campo de edición para la cédula -->
                    <div class="row mb-3">
                        <label for="cedulaEdit" class="col-sm-3 col-form-label">Cédula</label>
                        <div class="col-sm-9">
                        <input type="text" class="form-control" id="cedulaEdit" name="cedula" placeholder="Cédula" required>
                    </div>
                    </div>
                    
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
                
                    
                    
                    <!-- Campo de edición para la descripción -->
                    <div class="row mb-3">
                        <label for="descripcionEdit" class="col-sm-3 col-form-label">Descripción</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" id="descripcionEdit" name="descripcion" rows="5" placeholder="Actualiza la situación" required></textarea>
                            <div class="wordCountMessage" id="wordCount">Tiene un máximo de 50 palabras</div>

              </div>
                    </div>
                                                           

                    <!-- Botón para enviar el formulario de edición -->
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
  function editarPQRS(nombre, apellido, telefono, cedula, tipo, descripcion) {
  // Set values for other fields
  document.getElementById('nombreEdit').value = nombre;
  document.getElementById('apellidoEdit').value = apellido;
  document.getElementById('telefonoEdit').value = telefono;
  document.getElementById('cedulaEdit').value = cedula;
  document.getElementById('descripcionEdit').value = descripcion;

  // Set the selected option for 'tipo'
  const tipoSelect = document.getElementById('tipoEdit');
  for (let i = 0; i < tipoSelect.options.length; i++) {
    if (tipoSelect.options[i].value === tipo) {
      tipoSelect.selectedIndex = i;
      break;
    }
  }

  // Show the modal
  const modal = new bootstrap.Modal(document.getElementById('editarPQRSModal'));
  modal.show();
}

</script>


<!-- Script para manejar la apertura del modal y enviar el ID del tutorial -->
<script>
    function editar(cedula) {
        // Establecer el valor del ID del tutorial en el campo oculto del formulario de edición
        document.getElementById("idPQRSEdit").value = cedula;
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

<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
