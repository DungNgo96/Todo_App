import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/data/states.dart';
import 'package:todo_app/presentation/pages/widgets/create_new_task_dialog.dart';

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
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: (db.screens != [] && db.screens.isNotEmpty == true)
              ? db.screens[db.navigationIndex]
              : Container(),
          floatingActionButton: db.navigationIndex == 0
              ? FloatingActionButton(
                  child: const Icon(Icons.add),
                  onPressed: () {
                    // showCreateTaskDialog(context);
                    showDialog(
                      context: context,
                      barrierColor: Colors.black87,
                      builder: (context) {
                        return const CreateNewTaskDialog();
                      },
                    );
                  },
                )
              : Container(),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black, width: 1))),
            child: BottomNavigationBar(
                unselectedItemColor: Colors.grey,
                backgroundColor: const Color(0x95171717),
                selectedItemColor: Colors.orangeAccent,
                currentIndex: db.navigationIndex,
                onTap: (index) {
                  db.changeIndex(index);
                },
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: 'All Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.unpublished_outlined),
                      label: 'Unfinished'),
                ]),
          ),
        );
      },
    );
  }

  void showCreateTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return const CreateNewTaskDialog();
      },
    ).then((response) {});
    // showModalBottomSheet(
    //     isScrollControlled: true,
    //     context: context,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     )),
    //     backgroundColor: Color(0xffffffff),
    //     builder: (builder) {
    //       return SingleChildScrollView(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Container(
    //               decoration: const BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(15),
    //                   topRight: Radius.circular(15),
    //                 ),
    //                 color: Colors.grey,
    //               ),
    //               height: 50,
    //               child: Center(
    //                   child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   const SizedBox(
    //                     width: 25,
    //                   ),
    //                   TextButton(
    //                     onPressed: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Text(
    //                       'Cancel',
    //                       style: TextStyle(
    //                           color: Colors.amber.shade700,
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.normal),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     width: 105,
    //                   ),
    //                   const Text(
    //                     'Add Task',
    //                     style: TextStyle(
    //                         color: Colors.white,
    //                         fontSize: 16,
    //                         fontWeight: FontWeight.w600),
    //                   ),
    //                 ],
    //               )),
    //             ),
    //             Container(
    //               padding: const EdgeInsets.only(
    //                 left: 20,
    //                 right: 20,
    //               ),
    //               height: MediaQuery.of(context).size.height * 0.3,
    //               decoration: const BoxDecoration(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(15),
    //                     topRight: Radius.circular(15),
    //                     bottomRight: Radius.circular(15),
    //                     bottomLeft: Radius.circular(15)),
    //                 color: Color(0xffffffff),
    //               ),
    //               child: Form(
    //                 // key: formKey,
    //                 child: Column(
    //                   //mainAxisSize: MainAxisSize.max,
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     const SizedBox(
    //                       height: 20,
    //                     ),
    //                     DefaultFormField(
    //                       controller: titleController,
    //                       label: 'New Task',
    //                       type: TextInputType.text,
    //                       validate: (String? value) {
    //                         if (value!.isEmpty) {
    //                           return 'Title must not be empty';
    //                         }
    //                         return null;
    //                       },
    //                       prefix: Icons.title,
    //                     ),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     DefaultFormField(
    //                         onTap: () {
    //                           showTimePicker(
    //                                   context: context,
    //                                   initialTime: TimeOfDay.now())
    //                               .then((value) => timeController.text =
    //                                   value!.format(context));
    //                         },
    //                         readOnly: true,
    //                         controller: timeController,
    //                         label: 'Task Time',
    //                         type: TextInputType.datetime,
    //                         validate: (String? value) {
    //                           if (value!.isEmpty) {
    //                             return 'Time must not be empty';
    //                           }
    //                           return null;
    //                         },
    //                         prefix: Icons.watch_later_outlined),
    //                     const SizedBox(
    //                       height: 10,
    //                     ),
    //                     DefaultFormField(
    //                         onTap: () {
    //                           print('Tapped');
    //                           showDatePicker(
    //                                   context: context,
    //                                   initialDate: DateTime.now(),
    //                                   firstDate: DateTime.now(),
    //                                   lastDate: DateTime.parse('2022-10-03'))
    //                               .then((value) => dateController.text =
    //                                   DateFormat.yMMMd().format(value!));
    //                         },
    //                         readOnly: true,
    //                         controller: dateController,
    //                         label: 'Task Deadline',
    //                         type: TextInputType.datetime,
    //                         validate: (String? value) {
    //                           if (value!.isEmpty) {
    //                             return 'Date must not be empty';
    //                           }

    //                           return null;
    //                         },
    //                         prefix: Icons.calendar_today),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     });
    // scaffoldKey.currentState!.showModalBottomSheet(
    //     (context) => SingleChildScrollView(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               Container(
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(15),
    //                     topRight: Radius.circular(15),
    //                   ),
    //                   color: Colors.grey,
    //                 ),
    //                 height: 50,
    //                 child: Center(
    //                     child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     const SizedBox(
    //                       width: 25,
    //                     ),
    //                     TextButton(
    //                       onPressed: () {
    //                         Navigator.pop(context);
    //                       },
    //                       child: Text(
    //                         'Cancel',
    //                         style: TextStyle(
    //                             color: Colors.amber.shade700,
    //                             fontSize: 16,
    //                             fontWeight: FontWeight.normal),
    //                       ),
    //                     ),
    //                     const SizedBox(
    //                       width: 105,
    //                     ),
    //                     const Text(
    //                       'Add Task',
    //                       style: TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 16,
    //                           fontWeight: FontWeight.w600),
    //                     ),
    //                   ],
    //                 )),
    //               ),
    //               Container(
    //                 padding: const EdgeInsets.only(
    //                   left: 20,
    //                   right: 20,
    //                 ),
    //                 height: MediaQuery.of(context).size.height * 0.3,
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(15),
    //                       topRight: Radius.circular(15),
    //                       bottomRight: Radius.circular(15),
    //                       bottomLeft: Radius.circular(15)),
    //                   color: Color(0xffffffff),
    //                 ),
    //                 child: Form(
    //                   // key: formKey,
    //                   child: Column(
    //                     //mainAxisSize: MainAxisSize.max,
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       const SizedBox(
    //                         height: 20,
    //                       ),
    //                       DefaultFormField(
    //                         controller: titleController,
    //                         label: 'New Task',
    //                         type: TextInputType.text,
    //                         validate: (String? value) {
    //                           if (value!.isEmpty) {
    //                             return 'Title must not be empty';
    //                           }
    //                           return null;
    //                         },
    //                         prefix: Icons.title,
    //                       ),
    //                       const SizedBox(
    //                         height: 10,
    //                       ),
    //                       DefaultFormField(
    //                           onTap: () {
    //                             showTimePicker(
    //                                     context: context,
    //                                     initialTime: TimeOfDay.now())
    //                                 .then((value) => timeController.text =
    //                                     value!.format(context));
    //                           },
    //                           controller: timeController,
    //                           label: 'Task Time',
    //                           type: TextInputType.datetime,
    //                           validate: (String? value) {
    //                             if (value!.isEmpty) {
    //                               return 'Time must not be empty';
    //                             }
    //                             return null;
    //                           },
    //                           prefix: Icons.watch_later_outlined),
    //                       const SizedBox(
    //                         height: 10,
    //                       ),
    //                       DefaultFormField(
    //                           onTap: () {
    //                             print('Tapped');
    //                             showDatePicker(
    //                                     context: context,
    //                                     initialDate: DateTime.now(),
    //                                     firstDate: DateTime.now(),
    //                                     lastDate: DateTime.parse('2022-10-03'))
    //                                 .then((value) => dateController.text =
    //                                     DateFormat.yMMMd().format(value!));
    //                           },
    //                           controller: dateController,
    //                           label: 'Task Deadline',
    //                           type: TextInputType.datetime,
    //                           validate: (String? value) {
    //                             if (value!.isEmpty) {
    //                               return 'Date must not be empty';
    //                             }

    //                             return null;
    //                           },
    //                           prefix: Icons.calendar_today),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     )),
    //     backgroundColor: Color(0xffffffff));
  }
}
