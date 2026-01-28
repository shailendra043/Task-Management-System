import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/main.dart';
import 'package:task_app/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('App starts with Login Screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Note: MyApp already includes ProviderScope, but for tests we often wrap it again
    // or we can just pump MyApp if it has the scope. In main.dart, main() wraps it.
    // MyApp itself is a ConsumerWidget.
    
    // We need to wrap it here because MyApp expects to be in a ProviderScope 
    // (actually in main.dart we wrapped MyApp in ProviderScope, but MyApp itself doesn't include it in its build method)
    // Wait, let's check main.dart.
    // main() { runApp(ProviderScope(child: MyApp())); }
    // MyApp build() ...
    
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // Wait for the FutureBuilder in AuthWrapper to complete
    await tester.pumpAndSettle();

    // Verify that Login Screen is present
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Task Manager'), findsOneWidget); // Logo text
  });
}
