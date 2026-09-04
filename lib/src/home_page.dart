import 'package:flutter/material.dart';

import 'api/models.dart';
import 'widgets/status_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.linkNotice});

  final String? linkNotice;

  @override
  Widget build(BuildContext context) {
    const status = ConnectionStatus(connected: false, endpoint: 'unset');
    return Scaffold(
      appBar: AppBar(title: const Text('Declarative Migrations')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (linkNotice case final notice?) ...[
              MaterialBanner(
                content: Text(notice),
                actions: const [SizedBox.shrink()],
              ),
              const SizedBox(height: 16),
            ],
            const StatusCard(status: status),
          ],
        ),
      ),
    );
  }
}
