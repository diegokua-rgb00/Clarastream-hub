import 'package:flutter/material.dart';

void main() {
  runApp(const ClaraHubApp());
}

class ClaraHubApp extends StatelessWidget {
  const ClaraHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6200EE);
    const backgroundColor = Color(0xFF121212);
    
    return MaterialApp(
      title: 'Clara Hub - Motor Propio',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: primaryColor,
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainControlScreen(),
    );
  }
}

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({super.key});

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const TimersScreen(),
    const FiltersScreen(),
    const CommandsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clara Hub - Control Nativo'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Timers y Saludos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Filtros y Spam',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Comandos',
          ),
        ],
      ),
    );
  }
}

class TimersScreen extends StatefulWidget {
  const TimersScreen({super.key});

  @override
  State<TimersScreen> createState() => _TimersScreenState();
}

class _TimersScreenState extends State<TimersScreen> {
  bool saludoActivo = false;
  String frecuencia = '20 minutos';
  final TextEditingController _mensajeController = TextEditingController(
    text: '¡Bienvenidos al stream! No se olviden de dejar su follow y compartir.',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('Automatización de Mensajes y Timers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Configura saludos automáticos recurrentes directo en el chat sin depender de plataformas externas.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Activar Saludo / Mensaje Automático'),
            subtitle: Text('Envía el mensaje cada $frecuencia'),
            value: saludoActivo,
            onChanged: (val) {
              setState(() {
                saludoActivo = val;
              });
            },
          ),
          const Divider(),
          const Text('Frecuencia del Timer:', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: frecuencia,
            isExpanded: true,
            dropdownColor: const Color(0xFF1E1E1E),
            items: ['5 minutos', '10 minutos', '20 minutos', '30 minutos'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                frecuencia = newValue!;
              });
            },
          ),
          const SizedBox(height: 20),
          const Text('Texto del Mensaje:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _mensajeController,
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            icon: const Icon(Icons.save),
            label: const Text('Guardar y Aplicar Timer'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Timer de chat configurado con éxito en Clara Hub.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool bloquearLinks = true;
  bool bloquearSimbolos = true;
  final TextEditingController _palabrasController = TextEditingController(
    text: 'palabra1, insulto2, spam3',
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('Filtros de Moderación y Seguridad', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Control total de bloqueo de enlaces y palabras prohibidas de forma nativa.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('Bloquear Enlaces (Anti-Spam)'),
            subtitle: const Text('Elimina automáticamente links no autorizados'),
            value: bloquearLinks,
            onChanged: (val) {
              setState(() {
                bloquearLinks = val;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Filtro de Símbolos Excesivos'),
            subtitle: const Text('Evita abuso de mayúsculas y caracteres repetidos'),
            value: bloquearSimbolos,
            onChanged: (val) {
              setState(() {
                bloquearSimbolos = val;
              });
            },
          ),
          const Divider(),
          const Text('Lista Negra de Palabras (separadas por coma):', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _palabrasController,
            maxLines: 2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            icon: const Icon(Icons.security),
            label: const Text('Actualizar Reglas de Moderación'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filtros de chat actualizados correctamente.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CommandsScreen extends StatelessWidget {
  const CommandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Gestión de Comandos del Bot', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text('Administra tus comandos personalizados (!discord, !redes, !redesocial) con control total.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.bolt, color: Colors.amber),
                  title: Text('!discord'),
                  subtitle: Text('Muestra el enlace de invitación al servidor.'),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                ),
                ListTile(
                  leading: Icon(Icons.bolt, color: Colors.amber),
                  title: Text('!redes'),
                  subtitle: Text('Comparte las redes sociales oficiales.'),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            icon: const Icon(Icons.add),
            label: const Text('Crear Nuevo Comando'),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función de creación de comandos lista para integrar.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

