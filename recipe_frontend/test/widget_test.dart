import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:recipe_frontend/src/app/app.dart';
import 'package:recipe_frontend/src/app/providers/app_providers.dart';
import 'package:recipe_frontend/src/core/config/app_config.dart';

void main() {
  testWidgets('App builds', (WidgetTester tester) async {
    // Provide a fake env for test so AppConfig can be created.
    dotenv.testLoad(fileInput: 'RECIPE_API_BASE_URL=https://example.com');

    final config = AppConfig.fromEnv(dotenv.env);

    await tester.pumpWidget(
      MultiProvider(
        providers: buildAppProviders(config: config),
        child: const RecipeHubApp(),
      ),
    );

    // Initial state is splash until auth provider bootstraps.
    await tester.pump(const Duration(milliseconds: 10));
    expect(find.byType(RecipeHubApp), findsOneWidget);
  });
}
