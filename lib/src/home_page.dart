import 'package:flutter/material.dart';
import 'package:ores_flutter/ores_flutter.dart';

import 'api/models.dart';
import 'widgets/status_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const status = ConnectionStatus(connected: false, endpoint: 'unset');
    return Scaffold(
      appBar: AppBar(title: const Text('Declarative Migrations')),
      body: const Padding(
        padding: EdgeInsets.all(OresSpacing.lg),
        child: StatusCard(status: status),
      ),
    );
  }
}
