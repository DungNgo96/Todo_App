import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/presentation/pages/home.dart';

void main() {
  testWidgets("Dialog Widget test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    var floatingButton = find.byType(FloatingActionButton);
    expect(floatingButton, findsOneWidget);

    await tester.tap(floatingButton);
    await tester.pump();
    expect(find.byType(Dialog), findsOneWidget);

    // check text fields
    var textField = find.byType(TextField);
    expect(textField, findsWidgets);
    var button = find.byType(MaterialButton);
    expect(button, findsWidgets);

    expect(find.text('New Task'), findsOneWidget);
    expect(find.text('Task Time'), findsOneWidget);
    expect(find.text('Task Deadline'), findsOneWidget);
    expect(find.byIcon(Icons.title), findsOneWidget);
    expect(find.byIcon(Icons.watch_later_outlined), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);

    // check close dialog
    var closeIcon = find.byIcon(Icons.close);
    expect(closeIcon, findsOneWidget);
    await tester.tap(closeIcon);
    await tester.pump();
    expect(closeIcon, findsNothing);
  });
}
