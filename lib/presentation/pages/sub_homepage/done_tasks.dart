import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/data/states.dart';
import 'package:todo_app/presentation/pages/widgets/task_item.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  _DoneTasksState createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppDataBase, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var doneTaskList = AppDataBase.get(context).doneTasks;
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: size.height,
              padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "All Tasks",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(height: size.height * 0.1),
                  doneTaskList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // return TaskItem(
                            //   tasks: doneTaskList[index],
                            // );
                            bool checkBoxValue;
                            if (doneTaskList[index]["status"] == "Undone") {
                              checkBoxValue = false;
                            } else {
                              checkBoxValue = true;
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                color: Colors.grey,
                                height: size.height * 0.1,
                                child: SafeArea(
                                    top: false,
                                    bottom: false,
                                    child: IntrinsicHeight(
                                      child: Slidable(
                                        key: Key(doneTaskList[index]['title']),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                AppDataBase.get(context)
                                                    .deleteFromDB(
                                                        doneTaskList[index]
                                                            ['id']);
                                              },
                                              backgroundColor:
                                                  const Color(0xffdd0044),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: "Delete",
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        const Color(0xff3293DE),
                                                    value: checkBoxValue,
                                                    onChanged: (value) {
                                                      String newStatus;
                                                      if (value == false) {
                                                        newStatus = "Undone";
                                                      } else {
                                                        newStatus = "Done";
                                                      }
                                                      setState(() {
                                                        AppDataBase.get(context)
                                                            .updateDB(
                                                                newStatus,
                                                                doneTaskList[
                                                                        index]
                                                                    ["id"]);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    doneTaskList[index]
                                                        ['title'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    doneTaskList[index]['date'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    doneTaskList[index]['time'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            );
                          },
                          itemCount: doneTaskList.length,
                        )
                      : Center(
                          child: Image.asset("assets/images/no_tasks.png"),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
