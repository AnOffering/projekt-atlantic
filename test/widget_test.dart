
import 'package:flutter_test/flutter_test.dart';
import 'package:projekt_atlantic/main.dart';

void main() {
  testWidgets('App starts correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp()); // Replace with your actual app class name
    
    // Verify if the 'Projekt Atlantic' title is shown.
    expect(find.text('Projekt Atlantic'), findsOneWidget);
  });
}