import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/presentation/pages/home.dart';

void main() {
  testWidgets("Home Widget test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // check bottom navigation bar
    var bottomNavigator = find.byType(BottomNavigationBar);
    expect(bottomNavigator, findsOneWidget);
    var buttonAllTask = find.byIcon(Icons.task);
    expect(buttonAllTask, findsOneWidget);
    var buttonDone = find.byIcon(Icons.check_circle_outline);
    expect(buttonDone, findsOneWidget);
    var buttonUndone = find.byIcon(Icons.unpublished_outlined);
    expect(buttonUndone, findsOneWidget);

    var floatingButton = find.byType(FloatingActionButton);

    // check changing tab in bottom navigation bar
    await tester.tap(buttonDone);
    await tester.pump();
    expect(find.text("Done Tasks"), findsOneWidget);

    // check floating action button
    expect(floatingButton, findsNothing);

    await tester.tap(buttonUndone);
    await tester.pump();
    expect(find.text("Undone Tasks"), findsOneWidget);

    // check floating action button
    expect(floatingButton, findsNothing);

    await tester.tap(buttonAllTask);
    await tester.pump();
    expect(find.text("All Tasks"), findsWidgets);

    // check floating action button
    expect(floatingButton, findsOneWidget);

    await tester.tap(floatingButton);
    await tester.pump();
    expect(find.byType(Dialog), findsOneWidget);
  });
}
