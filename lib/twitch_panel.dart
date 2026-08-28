import 'package:flutter/material.dart';

// 1. PANTALLA DE LOGIN DE TWITCH
class TwitchLoginScreen extends StatelessWidget {
  const TwitchLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.live_tv, size: 80, color: Colors.purpleAccent),
          const SizedBox(height: 20),
          const Text(
            'Conectar con Twitch',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Ingresá tus credenciales para vincular tu cuenta de forma segura.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Usuario / Correo',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9146FF), // Color oficial de Twitch
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Conectando con Twitch...')),
                );
              },
              const Text('Iniciar Sesión', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. PESTAÑA DE NIGHTBOT CON OPCIONES ACTIVABLES
class NightbotOptionsScreen extends StatefulWidget {
  const NightbotOptionsScreen({super.key});

  @override
  State<NightbotOptionsScreen> createState() => _NightbotOptionsScreenState();
}

class _NightbotOptionsScreenState extends State<NightbotOptionsScreen> {
  bool comandosActivos = true;
  bool moderacionSpam = false;
  bool timersActivos = true;
  bool saludosChat = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Opciones de Nightbot',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        const Text(
          'Activá o desactivá las funciones operativas con un solo toque.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          title: const Text('Comandos Personalizados (!comandos)'),
          subtitle: const Text('Permite responder comandos automáticos en el chat'),
          value: comandosActivos,
          activeColor: Colors.purpleAccent,
          onChanged: (val) {
            setState(() {
              comandosActivos = val;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Moderación de Enlaces / Spam'),
          subtitle: const Text('Bloquea enlaces no permitidos automáticamente'),
          value: moderacionSpam,
          activeColor: Colors.purpleAccent,
          onChanged: (val) {
            setState(() {
              moderacionSpam = val;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Timers Periódicos'),
          subtitle: const Text('Envía recordatorios cada cierto tiempo'),
          value: timersActivos,
          activeColor: Colors.purpleAccent,
          onChanged: (val) {
            setState(() {
              timersActivos = val;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Saludos y Despedidas'),
          subtitle: const Text('Interactúa cuando ingresan usuarios'),
          value: saludosChat,
          activeColor: Colors.purpleAccent,
          onChanged: (val) {
            setState(() {
              saludosChat = val;
            });
          },
        ),
      ],
    );
  }
}
