import 'package:flutter/foundation.dart';
// Dependiendo de cómo manejes las peticiones HTTP y la redirección en Flutter (por ejemplo, url_launcher o webview)
// acá estructuramos la lógica para disparar el login y atrapar el callback.

class TwitchAuthService {
  final String clientId = 'TU_CLIENT_ID';
  final String redirectUri = 'TU_REDIRECT_URI'; // Ej: http://localhost:3000/auth/twitch/callback o deep link
  final String scope = 'user:read:email'; // Los scopes que necesites

  void iniciarAutenticacion() {
    final authUrl = 'https://id.twitch.tv/oauth2/authorize'
        '?client_id=$clientId'
        '&redirect_uri=$redirectUri'
        '&response_type=code'
        '&scope=$scope';
    
    // Acá disparás la apertura de la URL con url_launcher
    if (kDebugMode) {
      print('URL de autenticación generada: $authUrl');
    }
  }

  Future<void> manejarCallback(String authorizationCode) async {
    // Acá realizás el POST a https://id.twitch.tv/oauth2/token 
    // para intercambiar el código por el access_token.
    if (kDebugMode) {
      print('Código recibido para cocinar: $authorizationCode');
    }
  }
}

