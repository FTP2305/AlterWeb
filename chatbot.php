<?php session_start(); ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chatbot</title>
    <link rel="stylesheet" href="chatbot.css">
</head>
<body>
    <div id="chatbot-container">
        <div id="chatbot-header">
            <h2>Chat de Ayuda</h2>
            <button id="close-chatbot" aria-label="Cerrar chat">X</button>
        </div>
        <div id="chatbot-messages">
            <!-- Mensajes del chat se agregarán aquí -->
            <div class="message bot-message">
                <p>¡Hola! Soy Titobot, ¿en qué puedo ayudarte hoy?</p>
            </div>
        </div>
        <div id="chatbot-input-container">
            <input type="text" id="chatbot-input" placeholder="Escribe tu pregunta...">
            <button id="chatbot-send">Enviar</button>
        </div>
    </div>

    <!-- Botón para abrir el chatbot con atributo data-logueado -->
    <button 
        id="open-chatbot-button" 
        data-logueado="<?php echo isset($_SESSION['id_usuario']) ? '1' : '0'; ?>">
        <img src="img/chat_icon.svg" alt="Abrir chat">
    </button>

    <!-- PASAR la variable logueado al JS desde PHP -->
    <script>
        const estaLogueado = <?php echo isset($_SESSION['id_usuario']) ? 'true' : 'false'; ?>;
    </script>

    <script src="chatbot.js"></script>
</body>
</html>
