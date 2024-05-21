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
                <a class="nav-link active btn warning custom-button" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="inicio.jsp">Inicio</a>
                <a class="nav-link active" style="font-family: times new roman; font-size: 20px; color: black;" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>
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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    body{
        font-family: times new roman;
    }

    /* About section */
    .about {
        padding: 50px;
    }

    .about h2 {
        font-size: 30px;
        font-weight: bold;
        margin-bottom: 30px;
    }

    .about p {
        font-size: 18px;
        line-height: 1.5;
    }



    .cta a {
        color: #fff;
        text-decoration: none;
        font-size: 18px;
        font-weight: bold;
        padding: 10px 20px;
        border-radius: 4px;
    }

</style>

<div class="container text-center mt-5">
    <h1>Bienvenido al Sistema de PQRS</h1>
    <p style="font-size: 20px">En este sistema podrás gestionar eficientemente todas las Preguntas, Quejas, Reclamos y Sugerencias de la institución.</p>
    <p style="font-size: 20px">Este sistema te ayudará a mejorar la comunicación con tus usuarios y a resolver sus inquietudes de manera oportuna.</p>
    <br>
    <p style="font-size: 20px">Dejale saber a la institucion tus inquietudes.</p>
    <a class="Active btn info custom-button" style="font-family: times new roman; font-size: 20px; color: blue" aria-current="page" href="formulario.jsp">Agregar una PQRS</a>

</div>

<section class="about">
    <div class="container">
        <h2>¿Qué es el Gestor de PQRS?</h2>
        <p>El Gestor de PQRS es una herramienta que te permite: </p>
        <ul>
            <li>Registrar y gestionar PQRS de manera organizada y eficiente.</li>
            <li>Asignar y realizar seguimiento a las PQRS.</li>
            <li>Generar informes y estadísticas.</li>
            <li>Mejorar la comunicación con tus clientes o usuarios.</li>
        </ul>
    </div>
</section>




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

<%@include file= "templates/footer.jsp"%>
