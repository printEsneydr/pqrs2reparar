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
                <a class="nav-link active " style="font-family: times new roman; font-size: 20px; color: black" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; margin-right: 20px; color: black" aria-current="page" href="mostrarPQRS.jsp">Mostrar PQRS's</a>

                <%            
                     HttpSession sessi = request.getSession();
          
                     String tipo = (String) sessi.getAttribute("tipoPersona");
                     System.out.println(tipo);
                     if (!tipo.equals("usuario"))
                     {
                     
                
            %>
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black; margin-right: 20px;" aria-current="page" href="admin.jsp">Agregar un Administrador</a>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<div class="container">
  <div class="row justify-content-center mt-5">
    <div class="col-md-8">
      <div class="card shadow border-primary">
        <div class="card-header bg-primary text-white">
          <h5 class="card-title">Agregar Nuevo Administrador</h5>
        </div>
        <div class="card-body">   
            <div class="form-container sign-up-container">
        <!-- Formulario para Registrarse si eres nuevo -->
        <form action="svAgregarAdmin" method="POST">
            <h1 style="font-size: 20px">Regístra sus datos</h1>
            <div  class="scrollable-content">
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
              <label for="correo" class="col-sm-3 col-form-label">Correo</label>
              <div class="col-sm-9">           
                <input class="form-control" type="email" placeholder="Correo electronico" name="correo" id="correo" required/>     
 </div>
            </div>  
                    
                <div class="row mb-3">
              <label for="contrasena" class="col-sm-3 col-form-label">Contraseña</label>
              <div class="col-sm-9">                         
                <input class="form-control" type="password" placeholder="Contraseña" name="contrasena" id="contrasenaInput" required/>
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary p-0" type="button" id="togglePassword">
                        <i class="far fa-eye-slash" id="eyeIcon"></i>
                    </button>
                </div>
            </div>                
 <div class="row" >
              <div class="col-sm-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-primary" >Registrar</button>
              </div>
            </div>             </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>  
    



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
<%@include file= "templates/footer.jsp"%>
