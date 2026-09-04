import 'package:flutter/material.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart';

import 'home_page.dart';
import 'product_links.dart';
import 'theme.dart';

class DeclmigApp extends StatefulWidget {
  const DeclmigApp({super.key});

  @override
  State<DeclmigApp> createState() => _DeclmigAppState();
}

class _DeclmigAppState extends State<DeclmigApp> {
  String? _linkNotice;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final incoming = SharedAuthProductLinkScope.maybeControllerOf(
      context,
    )?.take();
    if (incoming == null) return;
    final destination = resolveProductLink(incoming);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _linkNotice = switch (destination) {
          DeclmigProductDestination.status =>
            'Opened the migration connection status.',
          DeclmigProductDestination.unsupported =>
            'That Declarative Migrations link is not supported.',
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Declarative Migrations',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: HomePage(linkNotice: _linkNotice),
    );
  }
}
