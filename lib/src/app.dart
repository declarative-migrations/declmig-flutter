import 'package:flutter/material.dart';

import 'home_page.dart';
import 'theme.dart';

class DeclmigApp extends StatelessWidget {
  const DeclmigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Declarative Migrations',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const HomePage(),
    );
  }
}

