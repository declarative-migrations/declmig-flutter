import 'package:flutter/material.dart';
import 'package:ores_flutter/ores_flutter.dart';

import 'api/models.dart';
import 'api/client.dart';
import 'widgets/status_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const configured = String.fromEnvironment('DECLMIG_API_BASE');
    final api = ApiClient.fromConfiguredBaseUrl(configured);
    final status = api?.snapshot() ?? ConnectionStatus(
      connected: false,
      endpoint: configured.isEmpty ? 'unset' : 'invalid configured endpoint',
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Declarative Migrations')),
      body: Padding(
        padding: EdgeInsets.all(OresSpacing.lg),
        child: StatusCard(status: status),
      ),
    );
  }
}
