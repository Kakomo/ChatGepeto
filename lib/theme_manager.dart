import 'dart:async';

class ThemeManager {
  static bool _isDarkMode = false;

  static bool get isDarkMode => _isDarkMode;

  static void toggleDarkMode(bool value) {
    _isDarkMode = value;
    // Notifica os listeners de que o tema mudou para que a interface do usuário seja atualizada
    notifyListeners();
    print('Mudou o tema ');
  }

  // Outras configurações relacionadas ao tema podem ser adicionadas aqui

  // Criar um StreamController para notificar os ouvintes quando o tema muda
  static final StreamController<bool> _themeController = StreamController<bool>.broadcast();

  // Método para adicionar ouvintes ao StreamController
  static void addThemeListener(Function(bool) listener) {
    _themeController.stream.listen(listener);
  }

  // Método para notificar os ouvintes quando o tema muda
  static void notifyListeners() {
    _themeController.add(_isDarkMode);
  }

  // Certifique-se de fechar o StreamController quando não estiver mais em uso
  static void dispose() {
    _themeController.close();
  }
}
