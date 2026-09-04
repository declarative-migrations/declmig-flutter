import 'package:declmig_flutter/src/app.dart';
import 'package:declmig_flutter/src/product_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_auth_flutter/shared_auth_flutter.dart';

void main() {
  test('only the exact status route is supported', () {
    expect(
      resolveProductLink(Uri.parse('https://m.example.test/u/status')),
      DeclmigProductDestination.status,
    );
    for (final unsafe in [
      'http://m.example.test/u/status',
      'https://user@m.example.test/u/status',
      'https://m.example.test/u/status/more',
      'https://m.example.test/u/unknown',
      'https://m.example.test/u/status#fragment',
      'https://m.example.test/u/status?token=secret',
    ]) {
      expect(
        resolveProductLink(Uri.parse(unsafe)),
        DeclmigProductDestination.unsupported,
        reason: unsafe,
      );
    }
  });

  testWidgets('verified status link is retained across the auth boundary', (
    tester,
  ) async {
    final links = SharedAuthProductLinkController(
      authCallbackUrl: Uri.parse('https://m.example.test/auth/callback'),
    );
    addTearDown(links.dispose);
    expect(
      links.capture(Uri.parse('https://m.example.test/u/status')),
      isTrue,
    );

    await tester.pumpWidget(
      SharedAuthProductLinkScope(
        controller: links,
        child: const DeclmigApp(),
      ),
    );
    await tester.pump();

    expect(
        find.text('Opened the migration connection status.'), findsOneWidget);
    expect(links.value, isNull);
  });

  testWidgets('unsupported link falls back safely on a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 568);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final links = SharedAuthProductLinkController(
      authCallbackUrl: Uri.parse('https://m.example.test/auth/callback'),
    );
    addTearDown(links.dispose);
    expect(
      links.capture(Uri.parse('https://m.example.test/u/unsupported')),
      isTrue,
    );

    await tester.pumpWidget(
      SharedAuthProductLinkScope(
        controller: links,
        child: const DeclmigApp(),
      ),
    );
    await tester.pump();

    expect(
      find.text('That Declarative Migrations link is not supported.'),
      findsOneWidget,
    );
    expect(find.text('Not connected'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
