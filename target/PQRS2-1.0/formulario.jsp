
<%@page import="java.util.List"%>
<!-- include para incluir un archivo dentro de otro, en este caso el header.  -->
<%@include file="templates/header.jsp"%>


<nav class="navbar navbar-expand-lg navbar-light sticky-top" style="background-color: #f5f5f5;">
    <div style="font-family: 'Archivo Black';" class="container-fluid">
        <label class="navbar-brand" style="color: #black; background-color: E2E2E2; font-family: times new roman; font-size: 24px">Preguntas, Quejas, Reclamos y Sugerencias</label>
        <div class="navbar bg-body-tertiary" id="navbarSupportedContent">           
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <!-- opcion de salir o cerrar sesion -->
            <div style="background-color: #f5f5f5; border-color: #f5f5f5 " class="collapse navbar-collapse" id="navbarNavAltMarkup">
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black" aria-current="page" href="inicio.jsp">Inicio </a>
        <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
        
        <%            
                     HttpSession sessi = request.getSession();
          
                     String tipo = (String) sessi.getAttribute("tipoPersona");
                     System.out.println(tipo);
                     if (!tipo.equals("usuario"))
                     {
                     
                
            %>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>
                        <a class="nav-link active " style="font-family: times new roman; font-size: 20px; color: black; margin-right: 10px;" aria-current="page" href="admin.jsp">Agregar un Administrador</a>

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
<!-- Enlace a Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<div style="font-family: times new roman" class="container mt-5">
    <h3 class="mb-4">Administrador de PQRS</h3>
    

    <p style="font-size: 20px ">Haznos saber tu inquietud mediante nuestro sistema.</p>

</div>       

<div class="container">
  <div class="row justify-content-center mt-5">
    <div class="col-md-8">
      <div class="card shadow border-primary">
        <div class="card-header bg-primary text-white">
          <h5 class="card-title">Agregar PQRS</h5>
        </div>
        <div class="card-body">
          <form action="svAgregarPqrs" method="POST" onsubmit="return enviarFormulario()">
            <div class="row mb-3">
              <label for="nombre" class="col-sm-3 col-form-label">Nombre</label>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingresa tu nombre" required>
              </div>
            </div>
            <div class="row mb-3">
              <label for="apellido" class="col-sm-3 col-form-label">Apellido</label>
              <div class="col-sm-9">
                <input type="text" class="form-control" id="apellido" name="apellido" placeholder="Ingresa tu apellido" required>
              </div>
            </div>
            <div class="row mb-3">
              <label for="telefono" class="col-sm-3 col-form-label">Teléfono</label>
              <div class="col-sm-9">
                <input type="number" class="form-control" id="telefono" name="telefono" placeholder="Ingresa tu número telefonico" required>
                              <span id="telefonoError" style="color: red;"></span>

              </div>
            </div>
            <div class="row mb-3">
              <label for="cedula" class="col-sm-3 col-form-label">Cédula</label>
              <div class="col-sm-9">
                <input type="number" class="form-control" id="cedula" name="cedula" placeholder="Ingresa tu cedula" required pattern="[0-9]+">
                          <span id="cedulaError" style="color: red;"></span>

              </div>
            </div>
            <div class="row mb-3">
              <label for="tipo" class="col-sm-3 col-form-label">Tipo de PQRS</label>
              <div class="col-sm-9">
                <select class="form-select" name="tipo" id="tipo" aria-label="Default select example" required>
                  <option value="" disabled selected>Seleccione...</option>
                  <option value="Pregunta">Pregunta</option>
                  <option value="Queja">Queja</option>
                  <option value="Reclamo">Reclamo</option>
                  <option value="Sugerencia">Sugerencia</option>
                </select>
              </div>
            </div>
            <div class="row mb-3">
              <label for="descripcion" class="col-sm-3 col-form-label">Descripción</label>
              <div class="col-sm-9">
                <textarea class="form-control" id="descripcion" name="descripcion" rows="5" placeholder="Describe la situación" required></textarea>
                            <div class="wordCountMessage" id="wordCount">Tiene un máximo de 50 palabras</div>

              </div>
            </div>
              
              <div class="form-check mb-3">
                            <input class="form-check-input" type="checkbox" id="terminos" required="Acepta los términos y condiciones para continuar.">
                            <label class="form-check-label" for="terminos">
                                Acepto los términos y condiciones
                            </label>
                        </div>
            <div class="row" >
              <div class="col-sm-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-primary" >Guardar</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>


<!--<br><br><div class="alert alert-success alert-dismissible fade show" role="alert" id="envioExitoso" style="display: none;">
    Tu inquietud será enviada.
    <button type="button" class="btn-close" data-dismiss="alert" aria-label="Close"></button>
</div>-->


<script>
  // Función para enviar el formulario y mostrar la notificación
  function enviarFormulario() {
    document.getElementById("envioExitoso").style.display = "block";
    setTimeout(function () {
      document.getElementById("envioExitoso").style.display = "none";
    }, 5000);
    setTimeout(function () {
      document.querySelector('form').submit();
    }, 2000);
    return false;
  }

  // Verificar la longitud del número de teléfono
  const telefonoInput = document.getElementById("telefono");
  const telefonoError = document.getElementById("telefonoError");

  telefonoInput.addEventListener("input", function () {
    const telefonoValue = telefonoInput.value;
    if (telefonoValue.length > 10) {
      telefonoError.textContent = "El teléfono no puede exceder los 10 dígitos.";
      telefonoInput.setCustomValidity("El teléfono no puede exceder los 10 dígitos.");
    } else {
      telefonoError.textContent = "";
      telefonoInput.setCustomValidity("");
    }
  });
</script>
<script>
    function enviarFormulario() {
        document.getElementById("envioExitoso").style.display = "block";
        setTimeout(function () {
            document.getElementById("envioExitoso").style.display = "none";
        }, 5000); 
        setTimeout(function () {
            document.querySelector('form').submit();
        }, 2000);
        return false;
    }
</script>
  <!-- este script es para que la cedula al registrar un usuario no exceda 10 digitos-->
    <script>
        // Selecciona el campo de cédula y el elemento del mensaje de error
        const cedulaInput = document.getElementById("cedula");
        const cedulaError = document.getElementById("cedulaError");

        // Agrega un event listener para el evento "input" que se dispara cuando se ingresa texto
        cedulaInput.addEventListener("input", function () {
            const cedulaValue = cedulaInput.value;

            // Verifica si la longitud es mayor que 10 caracteres
            if (cedulaValue.length > 10) {
                cedulaError.textContent = "La cédula no puede exceder los 10 dígitos.";
                cedulaInput.setCustomValidity("La cédula no puede exceder los 10 dígitos.");
            } else {
                // Si la longitud es válida, borra el mensaje de error
                cedulaError.textContent = "";
                cedulaInput.setCustomValidity("");
            }
        });
    </script>



       <script>
    function validarFormulario() {
        var checkbox = document.getElementById("terminos");
        if (!checkbox.checked) {
            alert("Acepta los términos y condiciones para continuar.");
            return false; 
        }
        return true; 
    }
</script> 
<!-- Modal de edición de tutorial -->
<div class="modal fade" id="editarTutorialModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Editar Tutorial</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="svEditarTutorial" method="POST" id="formEditarTutorial">
                    <!-- Campo oculto para almacenar el ID del tutorial -->
                    <input type="hidden" name="idTutorialEdit" id="idTutorialEdit">
                    <!-- Campo de edición para el nombre -->
                    <div class="mb-3">
                        <label for="nombreEdit" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="nombreEdit" name="nombre" placeholder="Nombre del tutorial" required>
                    </div>
                    <!-- Campo de edición para la prioridad -->
                    <div class="mb-3">
                        <label for="prioridadEdit" class="form-label">Prioridad</label>
                        <select class="form-select" id="prioridadEdit" name="prioridad" placeholder="Prioridad del tutorial" required>
                            <option value="" disabled selected>Seleccione...</option>
                            <option value="1">1</option>
                            <option value="2">2</option>                                 
                            <option value="3">3</option>                                  
                            <option value="4">4</option>                                   
                            <option value="5">5</option>                                                                    
                            <option value="6">6</option>                                  
                            <option value="7">7</option>                                  
                            <option value="8">8</option>                                  
                            <option value="9">9</option>                                  
                            <option value="10">10</option>
                        </select>
                    </div>
                    <!-- Campo de edición para la URL -->
                    <div class="mb-3">
                        <label for="urlEdit" class="form-label">URL</label>
                        <input type="text" class="form-control" id="urlEdit" name="url" placeholder="URL del tutorial" required>
                    </div>
                    <!-- Campo de edición para el estado -->
                    <div class="mb-3">
                        <label for="estadoEdit" class="form-label">Estado</label>
                        <select class="form-select" id="estadoEdit" name="estado" required>
                            <option value="Revisado">Revisado</option>
                            <option value="Por revisar">Por revisar</option>
                        </select>
                    </div>
                    <!-- Campo de edición para la categoría -->
                    <!-- Campo de edición para la categoría -->
                    <div class="mb-3">
                        <label for="categoriaEdit" class="form-label">Categoría</label>
                        <select class="form-select" id="categoriaEdit" name="categoria" required>

                        </select>
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


<!-- Script para manejar la apertura del modal y enviar el ID del tutorial -->
<script>
    function editarTutorial(idTutorial) {
        // Establecer el valor del ID del tutorial en el campo oculto del formulario de edición
        document.getElementById("idTutorialEdit").value = idTutorial;
        // Mostrar el modal de edición
        var editarTutorialModal = new bootstrap.Modal(document.getElementById('editarTutorialModal'), {
            keyboard: false
        });
        editarTutorialModal.show();
    }
</script>
<!-- Modal para mostrar la informacion del tutorial-->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detalles del Tutorial</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <h4 style='color: #1c1c1c; text-align: center;'>
                    <p><strong>ID<br></strong> <span style='color: #555555' id="tutorialId"></span></p>
                    <p><strong>Nombre<br></strong> <span style='color: #555555' id="tutorialNombre"></span></p>
                    <p><strong>Prioridad<br></strong> <span style='color: #555555' id="tutorialPrioridad"></span></p>
                    <p><strong>URL<br></strong> <span style='color: #555555' id="tutorialUrl"></span></p>
                    <p><strong>Estado<br></strong> <span style='color: #555555' id="tutorialEstado"></span></p>
                    <p><strong>Categoría<br></strong> <span style='color: #555555' id="tutorialCategoria"></span></p>
                </h4>
                <div class="text-center">
                    <button type="button" class="btn btn-danger btn-success mx-2" data-bs-dismiss="modal">Cancelar</button>
                </div>       </div>   
        </div>
    </div>
</div>
<!-- este script no permite que la tecla enter funcione dentro del textarea para evitar error en agregar tarea-->
<script>
                    document.getElementById('descripcion').addEventListener('keydown', function (e) {
                        if (e.key === 'Enter') {
                            // Evitar el salto de línea
                            e.preventDefault();
                        }
                    });
</script>
<!-- este script maneja el exceso de palabras para el textarea de la descripcion-->
<script>

    var descripcionField = document.getElementById("descripcion");
    var wordCount = document.getElementById("wordCount");

    var maxWords = 50;

    descripcionField.addEventListener("input", function (e) {
        var words = descripcionField.value.trim().split(/\s+/);
        var wordCountValue = words.length;

        wordCount.textContent = wordCountValue + " palabras de " + maxWords + " (máximo)";

        if (wordCountValue > maxWords) {
            descripcionField.value = words.slice(0, maxWords).join(" ");
            wordCount.textContent = maxWords + " palabras de " + maxWords + " (máximo)";
            wordCount.style.color = "#888"; 
            wordCount.classList.add("wordCountMessage"); 
        } else {
            wordCount.style.color = "#888"; 
            wordCount.classList.remove("wordCountMessage");
        }
    });
</script>


<script>
    function mostrarTutorial(id, nombre, prioridad, url, estado, categoria) {
        document.getElementById('tutorialId').innerText = id;
        document.getElementById('tutorialNombre').innerText = nombre;
        document.getElementById('tutorialPrioridad').innerText = prioridad;
        document.getElementById('tutorialUrl').innerText = url;
        document.getElementById('tutorialEstado').innerText = estado;
        document.getElementById('tutorialCategoria').innerText = categoria;

        // Muestra la ventana modal
        var modal = new bootstrap.Modal(document.getElementById('exampleModal'));
        modal.show();
    }
</script>

<br><br><br><br><br>
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
  </div>
</footer>

<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
