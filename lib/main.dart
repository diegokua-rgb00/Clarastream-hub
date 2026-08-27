import 'dart:io';
import 'package:flutter/material.dart';

void main() {
  runApp(const StreamerHubUnificadoApp());
}

class StreamerHubUnificadoApp extends StatelessWidget {
  const StreamerHubUnificadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgDark = Color(0xFF0F0E17);
    const Color cardColor = Color(0xFF1B1A29);
    const Color accentColor = Color(0xFFFF8906);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streamer Hub Pro',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        cardColor: cardColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          secondary: Color(0xFFE53170),
        ),
      ),
      home: const PantallaPrincipalUnificada(),
    );
  }
}

class PantallaPrincipalUnificada extends StatefulWidget {
  const PantallaPrincipalUnificada({super.key});

  @override
  State<PantallaPrincipalUnificada> createState() => _PantallaPrincipalUnificadaState();
}

class _PantallaPrincipalUnificadaState extends State<PantallaPrincipalUnificada> {
  final List<String> _mensajesChat = [
    "[Sistema]: Bienvenido al Hub de Consola - Listo para operar.",
  ];

  final TextEditingController _mensajeController = TextEditingController();

  void _enviarMensajeAlChat(String texto) {
    if (texto.trim().isEmpty) return;
    setState(() {
      _mensajesChat.add("[Tú (Consola)]: $texto");
    });
    _mensajeController.clear();
  }

  void _dispararAccionBot(String nombreComando, String efectoChistoso) {
    setState(() {
      _mensajesChat.add("[Bot Hub]: 🤖 $efectoChistoso");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twitch Hub - Consola'),
        backgroundColor: const Color(0xFF1B1A29),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF161522),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _BotonBotAccion(
                    titulo: '¡Asaltar Stream!',
                    icono: Icons.local_police,
                    color: Colors.amber,
                    onTap: () => _dispararAccionBot('Asalto', '¡Atención chat! Nos cayeron los fideos armados, ¡a resguardar el loot! 🚨'),
                  ),
                  const SizedBox(width: 8),
                  _BotonBotAccion(
                    titulo: 'Púteme, Bot',
                    icono: Icons.bolt,
                    color: Colors.redAccent,
                    onTap: () => _dispararAccionBot('Puteada', 'El bot mira al streamer y grita: ¡Andá a laburar, vago de cuarta! 🤬'),
                  ),
                  const SizedBox(width: 8),
                  _BotonBotAccion(
                    titulo: 'Masaje Virtual',
                    icono: Icons.spa,
                    color: Colors.greenAccent,
                    onTap: () => _dispararAccionBot('Masaje', 'El bot activa contracturas. Masaje cervical en proceso... Ahh, alivio puro. 💆‍♂️'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: _mensajesChat.length,
              itemBuilder: (context, index) {
                final mensaje = _mensajesChat[index];
                final esAlerta = mensaje.contains("[Sistema]") || mensaje.contains("[Bot Hub]");
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: esAlerta ? Colors.deepOrange.withOpacity(0.15) : const Color(0xFF1B1A29),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: esAlerta ? Colors.deepOrangeAccent : Colors.white10,
                    ),
                  ),
                  child: Text(
                    mensaje,
                    style: TextStyle(
                      fontSize: 14,
                      color: esAlerta ? Colors.orangeAccent : Colors.white,
                      fontWeight: esAlerta ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF1B1A29),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _mensajeController,
                    decoration: const InputDecoration(
                      hintText: 'Responder al chat desde la consola...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    onSubmitted: _enviarMensajeAlChat,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFFF8906)),
                  onPressed: () => _enviarMensajeAlChat(_mensajeController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BotonBotAccion extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final VoidCallback onTap;

  const _BotonBotAccion({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF222131),
        foregroundColor: Colors.white,
        side: BorderSide(color: color, width: 1),
      ),
      onPressed: onTap,
      icon: Icon(icono, color: color, size: 18),
      label: Text(titulo, style: const TextStyle(fontSize: 12)),
    );
  }
}
