import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_app/features/auth/data/repositories/auth_repository.dart';
import 'package:task_app/features/auth/providers/auth_providers.dart';
import 'package:task_app/features/auth/presentation/screens/login_screen.dart';
import 'package:task_app/main.dart';

class FakeAuthRepository extends AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    return false;
  }
}

void main() {
  testWidgets('App starts with Login Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
        child: const MyApp(),
      ),
    );

    // Wait for the FutureBuilder in AuthWrapper to complete
    await tester.pumpAndSettle();

    // Verify that Login Screen is present
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Task Manager'), findsOneWidget);
  });
}
