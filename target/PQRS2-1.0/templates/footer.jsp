<!-- Template Footer -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>       
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<footer>
    <!-- scripts usados para pagina index.jsp o login-->
    <!-- alerta o notificacion para indicar que el usuario ha sido guardado exitosamente-->
    <!-- inicio de scripts o alertas para la clase index.jsp o login-->       
    <script>
        // Ocultar la alerta después de 4 segundos 
        setTimeout(function () {
            $('#inicioSesionFallidoAlert').alert('close');
        }, 4000);
    </script>
    <script>
        // Ocultar la alerta después de 4 segundos 
        setTimeout(function () {
            $('#registroExitosoAlert').alert('close');
        }, 4000);
    </script>
    <script>
        // Ocultar la alerta después de 3 segundos 
        setTimeout(function () {
            $('#registroExitosoAlert').alert('close');
        }, 3000);
    </script>
    <script>
        // Ocultar la alerta después de 4 segundos 
        setTimeout(function () {
            $('#alertaIDnegativo').alert('close');
        }, 4000);
    </script>
    <script>
        // Ocultar la alerta después de 5 segundos (5000 milisegundos)
        setTimeout(function () {
            $('#registroExitosoAlert').alert('close');
        }, 3000);
    </script>
    <script>
        // Ocultar la alerta después de 5 segundos (5000 milisegundos)
        setTimeout(function () {
            $('#registroExitosoAlert').alert('close');
        }, 3000);
    </script>
    <!-- este script se encarga de la alerta en el login para indicar que la cuenta no existe en el sistema -->
    <script>
        // Mostrar la alerta en primer lugar
        var errorAlert = document.getElementById("error-alert");
        if (errorAlert) {
            errorAlert.style.display = "block";
        }

        // Ocultar la alerta después de 4 segundos (4000 milisegundos)
        setTimeout(function () {
            var errorAlert = document.getElementById("error-alert");
            if (errorAlert) {
                errorAlert.style.display = "none";
            }
        }, 4100);
    </script>
    <!-- este script permite la animacion del panel del login de iniciar sesion a registrar usuario-->
    <script>
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');

        signUpButton.addEventListener('click', () => {
            container.classList.add("right-panel-active");
        });

        signInButton.addEventListener('click', () => {
            container.classList.remove("right-panel-active");
        });
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
    <!-- este script es para que se permita visualizar la contraseña agregada en el input type="password" cuando el usuario le de click en la ventana de iniciar sesion-->
    <script>
        const contrasenaInput = document.getElementById("contrasenaInput");
        const togglePasswordButton = document.getElementById("togglePassword");
        const eyeIcon = document.getElementById("eyeIcon");

        togglePasswordButton.addEventListener("click", function () {
            if (contrasenaInput.type === "password") {
                contrasenaInput.type = "text";
                eyeIcon.classList.remove("far", "fa-eye-slash");
                eyeIcon.classList.add("far", "fa-eye");
            } else {
                contrasenaInput.type = "password";
                eyeIcon.classList.remove("far", "fa-eye");
                eyeIcon.classList.add("far", "fa-eye-slash");
            }
        });
    </script>
    <!-- este script hace lo mismo pero para la ventana de registrar usuario-->
    <script>
        const contrasenaInput2 = document.getElementById("contrasenaInput2");
        const togglePasswordButton2 = document.getElementById("togglePassword2");
        const eyeIcon2 = document.getElementById("eyeIcon2");

        togglePasswordButton2.addEventListener("click", function () {
            if (contrasenaInput2.type === "password") {
                contrasenaInput2.type = "text";
                eyeIcon2.classList.remove("far", "fa-eye-slash");
                eyeIcon2.classList.add("far", "fa-eye");
            } else {
                contrasenaInput2.type = "password";
                eyeIcon2.classList.remove("far", "fa-eye");
                eyeIcon2.classList.add("far", "fa-eye-slash");
            }
        });
    </script>
    <!-- este script es para indicar al usuario que su registro fue extitoso-->
    <script>
        // Esta función se ejecutará cuando se cargue la página
        window.onload = function () {
            // Obtén una referencia a los campos de entrada que deseas limpiar
            const cedulaInput = document.getElementById("cedula");
            const correoInput = document.querySelector('input[name="correo"]');
            const contrasenaInput1 = document.getElementById("contrasenaInput");
            const contrasenaInput2 = document.getElementById("contrasenaInput2");

            // Restablece los valores de los campos de entrada
            cedulaInput.value = "";
            correoInput.value = "";

            // Comprueba si la página se cargó después de un registro exitoso
            const registroExitosoAlert = document.getElementById("registroExitosoAlert");
            if (!registroExitosoAlert) {
                correoInput.value = "";
                contrasenaInput1.value = "";
                contrasenaInput2.value = "";
            }
        };
    </script>

    <!-- scripts de la clase pincipal.jsp-->
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

        // Obtén una referencia al campo de descripción y al elemento para mostrar el contador.
        var descripcionField = document.getElementById("descripcion");
        var wordCount = document.getElementById("wordCount");

        // Establece el límite de palabras.
        var maxWords = 20;

        descripcionField.addEventListener("input", function (e) {
            // Divide el contenido del campo de descripción en palabras y cuenta la longitud del array resultante.
            var words = descripcionField.value.trim().split(/\s+/);
            var wordCountValue = words.length;

            // Actualiza el contador de palabras.
            wordCount.textContent = wordCountValue + " palabras de " + maxWords + " (máximo)";

            // Si se excede el límite, recorta el contenido y cambia el color del mensaje.
            if (wordCountValue > maxWords) {
                // Recorta el contenido para que tenga el número máximo de palabras.
                descripcionField.value = words.slice(0, maxWords).join(" ");
                wordCount.textContent = maxWords + " palabras de " + maxWords + " (máximo)";
                wordCount.style.color = "#888"; // Cambia el color al gris claro que desees.
                wordCount.classList.add("wordCountMessage"); // Agrega la clase para cambiar el color.
            } else {
                wordCount.style.color = "#888"; // Restaura el color original si no se excede el límite.
                wordCount.classList.remove("wordCountMessage"); // Elimina la clase si no se excede el límite.
            }
        });
    </script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        // Función para mostrar una alerta en la modal de alerta
        function showAlert(message) {
            // Actualizar el contenido de la modal de alerta con el mensaje
            $("#alertMessage").text(message);

            // Mostrar la modal de alerta
            $("#alertModal").modal("show");
        }

        // Función para realizar la búsqueda y mostrar la información en la modal de detalles
        $("#searchButton").click(function () {
            var searchTerm = $("#searchInput").val().trim();
            if (searchTerm !== "") {
                // Realizar la búsqueda de la tarea por ID
                var taskIdToSearch = parseInt(searchTerm); // Convierte el valor a número si es un entero
                if (!isNaN(taskIdToSearch) && taskIdToSearch > 0) {
                    var taskFound = false;
                    $(".custom-name-cell").each(function () {
                        var taskId = parseInt($(this).closest("tr").find("td:first-child").text());
                        if (taskId === taskIdToSearch) {
                            taskFound = true;
                            var taskTitle = $(this).text();
                            var taskDescription = $(this).closest("tr").find(".custom-description-cell").text();
                            var taskDueDate = $(this).closest("tr").find("td:nth-child(4)").text();

                            // Actualizar el contenido de la modal de detalles con los detalles de la tarea
                            $("#modalTaskId").text(taskId);
                            $("#modalTaskTitle").text(taskTitle);
                            $("#modalTaskDescription").text(taskDescription);
                            $("#modalTaskDueDate").text(taskDueDate);

                            // Mostrar la modal de detalles
                            $("#taskModal").modal("show");
                            return false;
                        }
                    });

                    if (!taskFound) {
                        showAlert("No se encontró una tarea con el ID proporcionado.");
                    }
                } else {
                    showAlert("El ID ingresado no es válido. Por favor, ingrese un número entero válido mayor que cero.");
                }
            } else {
                showAlert("Ingrese un ID para buscar la tarea.");
            }
        });
    });
</script>


    <!-- este script hace que el se muestre un texto en el input del id de manera que no se exceda un id de 3 digitos y-->   
<script>
document.addEventListener("DOMContentLoaded", function() {
  var idInput = document.getElementById("id");
  var idError = document.getElementById("idError");

  idInput.addEventListener("input", function() {
    if (idInput.value.length > 3) {
      idError.textContent = "El ID no puede exceder los 3 dígitos";
      idError.style.color = "red";
      idInput.setCustomValidity("El ID no puede exceder los 3 dígitos");
    } else {
      idError.textContent = "";
      idError.style.color = "red";
      idInput.setCustomValidity("");
    }
  });
});
</script>

<!-- este script permite realizar el desmarque de los botones de agregar primero y ultimo -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    const btnRadio1 = document.getElementById("btnradio1");
    const btnRadio2 = document.getElementById("btnradio2");
    const limpiarSeleccion = document.getElementById("limpiarSeleccion");

        limpiarSeleccion.addEventListener("click", function () {
        btnRadio1.checked = false;
        btnRadio2.checked = false;
    });
});

</script>

<!-- este escript es para ordenar la lista de manera ascendente en los ID's -->
<script>
    $(document).ready(function () {
        // Función para ordenar la tabla por ID de manera ascendente
        $("#ordenarPorIdAscendente").click(function () {
            var table = $("#tablaTareas");
            var rows = table.find("tr").get();
            rows.sort(function (a, b) {
                var keyA = $(a).children("td:eq(0)").text();
                var keyB = $(b).children("td:eq(0)").text();
                return keyA - keyB;
            });
            $.each(rows, function (index, row) {
                table.children("tbody").append(row);
            });
        });
    });
</script>

<!-- este escript es para ordenar la lista de manera descendente en los ID's -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Función para ordenar la tabla por ID de manera descendente
        function ordenarPorIdDescendente() {
            var table = document.getElementById("tablaTareas").getElementsByTagName('tbody')[0];
            var rows = Array.from(table.getElementsByTagName('tr'));

            rows.sort(function(a, b) {
                var idA = parseInt(a.cells[0].textContent.trim());
                var idB = parseInt(b.cells[0].textContent.trim());
                return idB - idA;
            });

            // Elimina las filas existentes
            for (var i = 0; i < rows.length; i++) {
                table.removeChild(rows[i]);
            }

            // Agrega las filas ordenadas
            for (var i = 0; i < rows.length; i++) {
                table.appendChild(rows[i]);
            }
        }

        // Agrega un evento al botón "ordenarPorIdDescendente" para activar la función de ordenamiento
        var ordenarPorIdDescendenteBtn = document.getElementById("ordenarPorIdDescendente");
        ordenarPorIdDescendenteBtn.addEventListener("click", ordenarPorIdDescendente);
    });
    
    
</script>

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














</body>
</html>
<!--cerramos el html, o sea el codigo-->