import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('Verificar inicio de TaskFlowApp', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());
    expect(find.text('Mis tareas'), findsOneWidget);
  });
}
