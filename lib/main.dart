import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/data/states.dart';
import 'package:todo_app/presentation/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const HomePage(),
    //   debugShowCheckedModeBanner: false,
    // );
    return BlocProvider(
      create: (context) => AppDataBase()..createDB(),
      child: BlocConsumer<AppDataBase, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // AppDataBase db = AppDataBase.get(context);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
