import 'models.dart';

class ApiClient {
  static bool isValidBaseUrl(String baseUrl) {
    if (baseUrl != baseUrl.trim() || RegExp(r'\s').hasMatch(baseUrl)) {
      return false;
    }
    final uri = Uri.tryParse(baseUrl);
    return uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.hasAuthority &&
        uri.host.isNotEmpty &&
        uri.userInfo.isEmpty &&
        !uri.hasQuery &&
        !uri.hasFragment;
  }

  /// Invalid or unconfigured endpoints must never be probed.
  static ApiClient? fromConfiguredBaseUrl(String baseUrl) =>
      isValidBaseUrl(baseUrl) ? ApiClient(baseUrl: baseUrl) : null;
  const ApiClient({required this.baseUrl});
  final String baseUrl;

  ConnectionStatus snapshot() =>
      ConnectionStatus(connected: false, endpoint: baseUrl);
}

