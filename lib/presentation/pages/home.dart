import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/storage/database.dart';
import 'package:todo_app/data/storage/states.dart';
import 'package:todo_app/presentation/pages/widgets/create_new_task_dialog.dart';
import 'package:todo_app/utils/constant/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppDataBase, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppDataBase db = AppDataBase.get(context);
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: true,
            body: (db.screens != [] && db.screens.isNotEmpty == true)
                ? db.screens[db.navigationIndex]
                : Container(),
            floatingActionButton: db.navigationIndex == 0
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    backgroundColor: COLORCONST.BLUE,
                    elevation: 10,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: COLORCONST.BARRIER,
                        builder: (context) {
                          return const CreateNewTaskDialog();
                        },
                      );
                    },
                  )
                : Container(),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(color: COLORCONST.BLACK, width: 1))),
              child: BottomNavigationBar(
                  unselectedItemColor: COLORCONST.GREY2,
                  backgroundColor: COLORCONST.BLUE,
                  selectedItemColor: COLORCONST.GREEN2,
                  currentIndex: db.navigationIndex,
                  onTap: (index) {
                    db.changeIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.task), label: TEXTCONST.ALLTASK),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.check_circle_outline),
                        label: TEXTCONST.DONE),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.unpublished_outlined),
                        label: TEXTCONST.UNDONE),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
