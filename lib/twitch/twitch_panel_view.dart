import 'package:flutter/material.dart';
import 'twitch_auth.dart';

class TwitchPanelView extends StatelessWidget {
  const TwitchPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    final twitchAuth = TwitchAuthService();

    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          twitchAuth.iniciarAutenticacion();
        },
        icon: const Icon(Icons.login),
        label: const Text('Conectar con Twitch'),
      ),
    );
  }
}

