import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart';

final class _SignedOutGateway implements CustomerAuthGateway {
  @override
  Future<AuthenticatedSession?> restore() async => null;

  @override
  Future<AuthenticatedSession> signIn({
    required String email,
    required String password,
  }) =>
      throw const AuthRejectedException();

  @override
  Future<SignUpResult> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async =>
      const SignUpConfirmationRequired();

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('customer auth gate shows product logo and hides admin', (
    tester,
  ) async {
    final controller = AuthController(gateway: _SignedOutGateway());
    await tester.pumpWidget(
      SharedAuthAppShell(
        title: 'Declarative Migrations',
        logoAssetPath: 'assets/branding/app-logo.png',
        config: SharedAuthConfig(
          supabaseUrl: 'https://project.supabase.co',
          supabasePublishableKey: 'sb_publishable_example',
          sharedAuthBaseUrl: 'https://ores-shared-auth.com/shared-auth',
          adminLoginEnabled: false,
        ),
        controller: controller,
        child: const MaterialApp(
          home: Scaffold(body: Text('Protected product')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Product logo'), findsOneWidget);
    expect(find.text('Log in'), findsWidgets);
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Open admin portal'), findsNothing);
    expect(find.text('Protected product'), findsNothing);

    await controller.close();
  });
}
