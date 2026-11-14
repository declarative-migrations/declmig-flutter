import 'package:declmig_flutter/src/api/client.dart';

void check(bool value, String name) {
  if (!value) throw StateError(name);
}

void main() {
  for (final valid in ['http://127.0.0.1:8080', 'https://api.example.test/v1']) {
    check(ApiClient.fromConfiguredBaseUrl(valid)?.baseUrl == valid, valid);
  }
  for (final invalid in ['', 'file:///etc/passwd', 'https://',
                         'https://u:p@example.test', 'https://host/path?q=1',
                         'https://host/#frag', 'https://host/white space']) {
    check(ApiClient.fromConfiguredBaseUrl(invalid) == null, invalid);
  }
  check(!ApiClient.fromConfiguredBaseUrl('http://localhost:8080')!.snapshot().connected,
      'snapshot must not claim live connectivity before probing');
}
