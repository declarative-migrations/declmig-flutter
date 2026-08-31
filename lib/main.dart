import 'package:flutter/widgets.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart' as shared_auth;
import 'package:declmig_flutter/src/app.dart';

void main() => runApp(
      const shared_auth.SharedAuthAppShell(
        title: 'Declarative Migrations',
        logoAssetPath: 'assets/branding/app-logo.png',
        child: DeclmigApp(),
      ),
    );
