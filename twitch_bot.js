const express = require('express');
const axios = require('axios');
const router = express.Router();

const TWITCH_CLIENT_ID = 'TU_CLIENT_ID';
const TWITCH_CLIENT_SECRET = 'TU_CLIENT_SECRET';
const REDIRECT_URI = 'http://localhost:3000/auth/twitch/callback';

// --- 1. RUTA DE AUTENTICACIÓN DE TWITCH (OAuth 2.0) ---

router.get('/auth/twitch', (req, res) => {
  const scope = 'user:read:email';
  const url = `https://id.twitch.tv/oauth2/authorize?client_id=${TWITCH_CLIENT_ID}&redirect_uri=${encodeURIComponent(REDIRECT_URI)}&response_type=code&scope=${scope}`;
  res.redirect(url);
});

router.get('/auth/twitch/callback', async (req, res) => {
  const { code } = req.query;
  if (!code) return res.status(400).send('No se recibió el código de autorización.');

  try {
    const tokenResponse = await axios.post('https://id.twitch.tv/oauth2/token', null, {
      params: {
        client_id: TWITCH_CLIENT_ID,
        client_secret: TWITCH_CLIENT_SECRET,
        code,
        grant_type: 'authorization_code',
        redirect_uri: REDIRECT_URI
      }
    });

    const { access_token, refresh_token } = tokenResponse.data;

    const userResponse = await axios.get('https://api.twitch.tv/helix/users', {
      headers: {
        'Client-ID': TWITCH_CLIENT_ID,
        'Authorization': `Bearer ${access_token}`
      }
    });

    req.session.user = userResponse.data.data[0];
    req.session.accessToken = access_token;
    req.session.refreshToken = refresh_token;

    res.redirect('/dashboard');
  } catch (error) {
    console.error('Error en la autenticación de Twitch:', error.response?.data || error.message);
    res.status(500).send('Fallo la autenticación con Twitch.');
  }
});

// --- 2. PANEL / SOLAPA DE CONFIGURACIÓN DEL BOT ---

router.get('/dashboard/bot-config', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Clara Hook - Panel Alfa 2.1</title>
        <style>
            body { font-family: Arial, sans-serif; background: #0e0e10; color: #efeff1; margin: 0; padding: 20px; }
            .tab-container { max-width: 600px; margin: auto; background: #18181b; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
            h2 { border-bottom: 2px solid #9146ff; padding-bottom: 10px; }
            .option-group { display: flex; justify-content: space-between; align-items: center; margin: 15px 0; padding: 10px; background: #26262b; border-radius: 4px; }
            .switch { position: relative; display: inline-block; width: 50px; height: 24px; }
            .switch input { opacity: 0; width: 0; height: 0; }
            .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 24px; }
            .slider:before { position: absolute; content: ""; height: 16px; width: 16px; left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%; }
            input:checked + .slider { background-color: #9146ff; }
            input:checked + .slider:before { transform: translateX(26px); }
            button { background: #9146ff; color: white; border: none; padding: 10px 20px; border-radius: 4px; cursor: pointer; font-weight: bold; margin-top: 15px; }
            button:hover { background: #772ce8; }
        </style>
    </head>
    <body>
    <div class="tab-container">
        <h2>Configuración del Bot</h2>
        <p>Seleccioná las opciones operativas que querés mantener activas para el canal:</p>
        
        <div class="option-group">
            <span>Activar Comandos Personalizados (!comandos)</span>
            <label class="switch">
                <input type="checkbox" id="customCommands" checked>
                <span class="slider"></span>
            </label>
        </div>

        <div class="option-group">
            <span>Moderación Automática de Enlaces / Spam</span>
            <label class="switch">
                <input type="checkbox" id="autoMod">
                <span class="slider"></span>
            </label>
        </div>

        <div class="option-group">
            <span>Manejo de Timers (Mensajes periódicos)</span>
            <label class="switch">
                <input type="checkbox" id="timers">
                <span class="slider"></span>
            </label>
        </div>

        <div class="option-group">
            <span>Respuestas a Saludos y Despedidas</span>
            <label class="switch">
                <input type="checkbox" id="greetings" checked>
                <span class="slider"></span>
            </label>
        </div>

        <button onclick="guardarConfiguracion()">Guardar Configuración</button>
    </div>
    <script>
        function guardarConfiguracion() {
            const config = {
                customCommands: document.getElementById('customCommands').checked,
                autoMod: document.getElementById('autoMod').checked,
                timers: document.getElementById('timers').checked,
                greetings: document.getElementById('greetings').checked
            };
            console.log("Configuración guardada:", config);
            alert("¡Opciones actualizadas con éxito!");
        }
    </script>
    </body>
    </html>
  `);
});

module.exports = router;
