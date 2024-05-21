
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
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="misPqrs.jsp">Mis PQRS's</a>
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
          <div class="alert alert-danger alert-dismissible fade show" role="alert" id="errorAlert" style="display: none;">
  <strong>El ID de la PQRS ya existe, ingrese un ID diferente.</strong>
  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<%
    Boolean userActionError = (Boolean) session.getAttribute("userActionError");
    // Verificar si el error proviene de una  del usuario
    if (userActionError != null && userActionError) {
%>
<script>
    // Mostrar la alerta de error en la ventana modal
    var errorAlert = document.getElementById('errorAlert');
    errorAlert.style.display = 'block';
</script>
<%
    // Limpiar la bandera despu de mostrar la alerta
    session.removeAttribute("userActionError");
}
%>
<script>
        // Ocultar la alerta despu de 4 segundos 
        setTimeout(function () {
            $('#errorAlert').alert('close');
        }, 4000);
</script>
  
        </div>
        <div class="card-body">
          <form action="svAgregarPqrs" method="POST" enctype="multipart/form-data">       

              <input type="hidden" name="idUsuario" value="<%= session.getAttribute("idUsuario") %>">
                                            
            <div class="row mb-3">
              <label for="idPqrs" class="col-sm-3 col-form-label">ID</label>
              <div class="col-sm-9">
                <input type="number" class="form-control" id="idPqrs" name="idPqrs" placeholder="Ingresa un identificador" required>
                              <span id="idPqrsError" style="color: red;"></span>
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
              
               <div class="row mb-3">
    <label for="archivo" class="col-sm-3 col-form-label">Archivo PDF</label>
    <div class="col-sm-9">
<input  class="form-control" type="file" name="archivo" id="archivo" accept=".pdf" required>
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
  const idPqrsInput = document.getElementById("idPqrs");
  const idPqrsError = document.getElementById("idPqrsError");

  idPqrsInput.addEventListener("input", function () {
    const idPqrsValue = idPqrsInput.value;
    if (idPqrsValue.length > 10) {
      idPqrsError.textContent = "El identificador no puede exceder los 10 dígitos.";
      idPqrsInput.setCustomValidity("El identificador no puede exceder los 10 dígitos.");
    } else {
      idPqrsError.textContent = "";
      idPqrsInput.setCustomValidity("");
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
        <p>&copy; 2024 Universidad Mariana</p>

    </div>
</footer>

<!-- include para incluir un archivo dentro de otro, en este caso el footer qque tomara los scripts realizados en esa clase.  -->
<%@include file= "templates/footer.jsp"%>
