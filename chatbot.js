document.addEventListener('DOMContentLoaded', () => {
    const chatbotContainer = document.getElementById('chatbot-container');
    const openChatbotButton = document.getElementById('open-chatbot-button');
    const closeChatbotButton = document.getElementById('close-chatbot');
    const chatbotMessages = document.getElementById('chatbot-messages');
    const chatbotInput = document.getElementById('chatbot-input');
    const chatbotSendButton = document.getElementById('chatbot-send');
    const logueado = openChatbotButton.getAttribute('data-logueado') === "1";

    const faq = {
        "horario": "Nuestra tienda está abierta de Lunes a Sábado de 9:00 AM a 8:00 PM, y Domingos de 10:00 AM a 6:00 PM.",
        "ubicacion": "Nos encontramos en Av. Siempre Viva 123, Ciudad Ejemplo. También puedes encontrar un mapa en nuestra sección 'Contáctanos'.",
        "contacto": "Puedes contactarnos por teléfono al (555) 123-4567 o por correo electrónico a soporte@titishop.com.",
        "productos": "Ofrecemos una amplia gama de productos tecnológicos, incluyendo audífonos, drones, proyectores, smartwatches y parlantes. Puedes ver nuestro catálogo completo en la sección 'Productos'.",
        "envio": "Realizamos envíos a todo el país. El costo y tiempo de envío dependen de tu ubicación y se calculan al finalizar la compra.",
        "devoluciones": "Aceptamos devoluciones dentro de los 15 días posteriores a la compra, siempre que el producto esté en su estado original. Por favor, consulta nuestra política de devoluciones completa para más detalles.",
        "pago": "Aceptamos pagos con tarjeta de crédito/débito (Visa, Mastercard, Amex), PayPal y transferencias bancarias.",
        "garantia": "Todos nuestros productos nuevos cuentan con una garantía de 1 año contra defectos de fabricación. Los productos reacondicionados tienen una garantía de 6 meses.",
        "ofertas": "Puedes encontrar nuestras ofertas actuales en la página principal y en la sección de 'Productos Destacados'. También te recomendamos suscribirte a nuestro boletín para recibir notificaciones.",
        "problema": "Lamentamos que tengas un problema. Por favor, describe tu inconveniente y trataré de ayudarte o dirigirte al departamento correcto.",
        "gracias": "¡De nada! Estoy aquí para ayudarte.",
        "hola": "¡Hola! ¿Cómo puedo asistirte hoy?",
        "adios": "¡Hasta luego! Que tengas un buen día."
    };

    function toggleChatbot() {
        chatbotContainer.classList.toggle('open');
        if (chatbotContainer.classList.contains('open')) {
            chatbotInput.focus();
        }
    }

    openChatbotButton.addEventListener('click', toggleChatbot);
    closeChatbotButton.addEventListener('click', toggleChatbot);

    function addMessage(text, sender, options = null) {
        const messageDiv = document.createElement('div');
        messageDiv.classList.add('message', sender + '-message');
        const p = document.createElement('p');
        p.textContent = text;
        messageDiv.appendChild(p);
        chatbotMessages.appendChild(messageDiv);

        if (options) {
            const optionsDiv = document.createElement('div');
            options.forEach(option => {
                const button = document.createElement('button');
                button.textContent = option.text;
                button.classList.add('chatbot-option');
                button.onclick = () => {
                    addMessage(option.text, 'user');
                    handleUserOption(option.value);
                };
                optionsDiv.appendChild(button);
            });
            messageDiv.appendChild(optionsDiv);
        }

        chatbotMessages.scrollTop = chatbotMessages.scrollHeight;
    }

    function getBotResponse(userInput) {
        userInput = userInput.toLowerCase().trim();
        let bestMatch = null;
        let highestScore = 0;

        if (!userInput) return null;

        for (const keyword in faq) {
            const keywords = keyword.split(" ");
            let currentScore = 0;
            keywords.forEach(kw => {
                if (userInput.includes(kw)) currentScore++;
            });

            if (currentScore > highestScore) {
                highestScore = currentScore;
                bestMatch = faq[keyword];
            }
        }

        const baseOptions = [
            { text: "Ver horarios", value: "horario" },
            { text: "Ver productos", value: "productos" },
            { text: "¿Dónde estamos?", value: "ubicacion" },
            { text: "Contacto", value: "contacto" },
            { text: "Envios", value: "envio" },
            { text: "Metodos de Pago", value: "pago" },
            { text: "Garantias", value: "garantia" },
            { text: "Novedades", value: "ofertas" },
        ];

        if (userInput.includes("hola") || userInput.includes("buenos días") || userInput.includes("buenas tardes")) {
            if (logueado) {
                baseOptions.push({ text: "✉️ Enviar mensaje", value: "mensaje" });
            }
            return { text: faq["hola"], options: baseOptions };
        }

        if (userInput.includes("gracias")) return { text: faq["gracias"], options: [] };
        if (userInput.includes("adios")) return { text: faq["adios"], options: [] };

        return { text: bestMatch || "No estoy seguro de cómo responder a eso. ¿Podrías reformular tu pregunta?", options: [] };
    }

    function handleUserOption(optionValue) {
        if (optionValue === "mensaje") {
            window.location.href = "enviar_mensaje.php";
            return;
        }
        const response = faq[optionValue] || "Lo siento, no entendí esa opción.";
        addMessage(response, 'bot');
    }

    function handleSendMessage() {
        const userInput = chatbotInput.value;
        if (userInput.trim() === "") return;

        addMessage(userInput, 'user');
        chatbotInput.value = "";

        setTimeout(() => {
            const botResponse = getBotResponse(userInput);
            if (botResponse) {
                addMessage(botResponse.text, 'bot', botResponse.options);
            }
        }, 500);
    }

    chatbotSendButton.addEventListener('click', handleSendMessage);
    chatbotInput.addEventListener('keypress', (event) => {
        if (event.key === 'Enter') handleSendMessage();
    });

    const openChatbotButtonImg = openChatbotButton.querySelector('img');
    if (!openChatbotButtonImg || openChatbotButtonImg.naturalWidth === 0) {
        const svg = document.createElement('div');
        svg.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
            </svg>`;
        openChatbotButton.appendChild(svg);
    }
});
