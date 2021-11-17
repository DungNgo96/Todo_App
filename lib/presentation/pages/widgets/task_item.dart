// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:todo_app/data/database.dart';
// import 'package:todo_app/data/states.dart';

// class TaskItem extends StatefulWidget {
//   final Map? tasks;
//   const TaskItem({Key? key, this.tasks}) : super(key: key);

//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   // bool? checkedValue = false;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // setState(() {
//     //   if (widget.tasks!["status"] == "Undone") {
//     //     checkedValue == false;
//     //   } else {
//     //     checkedValue == true;
//     //   }
//     // });
//     return BlocConsumer<AppDataBase, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var tasks = AppDataBase.get(context).allTasks;
//         return Container(
//           // decoration: BoxDecoration(
//           //     color: Colors.grey,
//           //     borderRadius: BorderRadius.circular(10),
//           //     border: Border.all(color: Colors.grey)),
//           color: Colors.grey,
//           height: size.height * 0.1,
//           child: SafeArea(
//               top: false,
//               bottom: false,
//               child: IntrinsicHeight(
//                 child: Slidable(
//                   key: Key(widget.tasks!['title']),
//                   endActionPane: ActionPane(
//                     motion: const ScrollMotion(),
//                     children: [
//                       SlidableAction(
//                         onPressed: (context) {
//                           AppDataBase.get(context)
//                               .deleteFromDB(widget.tasks!['id']);
//                         },
//                         backgroundColor: const Color(0xffdd0044),
//                         foregroundColor: Colors.white,
//                         icon: Icons.delete,
//                         label: "Delete",
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Checkbox(
//                               checkColor: Colors.white,
//                               activeColor: const Color(0xff3293DE),
//                               value: checkedValue,
//                               onChanged: (value) {
//                                 String newStatus;
//                                 if (value == false) {
//                                   newStatus = "Undone";
//                                 } else {
//                                   newStatus = "Done";
//                                 }
//                                 setState(() {
//                                   checkedValue = value;
//                                   AppDataBase.get(context)
//                                       .updateDB(newStatus, widget.tasks!["id"]);
//                                 });
//                               },
//                             ),
//                             Text(
//                               widget.tasks!['title'],
//                               style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               widget.tasks!['date'],
//                               style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w400),
//                             ),
//                             Text(
//                               widget.tasks!['time'],
//                               style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w400),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )),
//         );
//       },
//     );
//   }
// }
