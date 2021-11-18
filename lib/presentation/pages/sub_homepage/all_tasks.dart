import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/data/storage/database.dart';
import 'package:todo_app/data/storage/states.dart';
import 'package:todo_app/utils/constant/const.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppDataBase, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var allTaskList = AppDataBase.get(context).allTasks;
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
                  Text(
                    TEXTCONST.ALLTASK,
                    style: FONTCONST.SEMIBOLD_36,
                  ),
                  Container(height: size.height * 0.1),
                  allTaskList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool checkBoxValue;
                            if (allTaskList[index]["status"] ==
                                TEXTCONST.UNDONE) {
                              checkBoxValue = false;
                            } else {
                              checkBoxValue = true;
                            }
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  color: checkBoxValue == false
                                      ? COLORCONST.ORANGE
                                      : COLORCONST.GREEN,
                                ),
                                height: size.height * 0.1,
                                child: SafeArea(
                                    top: false,
                                    bottom: false,
                                    child: IntrinsicHeight(
                                      child: Slidable(
                                        key: Key(allTaskList[index]["title"]),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                AppDataBase.get(context)
                                                    .deleteFromDB(
                                                        allTaskList[index]
                                                            ["id"]);
                                              },
                                              backgroundColor: COLORCONST.RED,
                                              foregroundColor: COLORCONST.WHITE,
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
                                                    checkColor:
                                                        COLORCONST.WHITE,
                                                    activeColor:
                                                        COLORCONST.LIGHTBLUE,
                                                    value: checkBoxValue,
                                                    onChanged: (value) {
                                                      String newStatus;
                                                      if (value == false) {
                                                        newStatus =
                                                            TEXTCONST.UNDONE;
                                                      } else {
                                                        newStatus =
                                                            TEXTCONST.DONE;
                                                      }
                                                      setState(() {
                                                        AppDataBase.get(context)
                                                            .updateDB(
                                                                newStatus,
                                                                allTaskList[
                                                                        index]
                                                                    ["id"]);
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    allTaskList[index]["title"],
                                                    style: FONTCONST.REGULAR_20,
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
                                                    allTaskList[index]["date"],
                                                    style: FONTCONST.REGULAR_20,
                                                  ),
                                                  Text(
                                                    allTaskList[index]["time"],
                                                    style: FONTCONST.REGULAR_20,
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
                          itemCount: allTaskList.length,
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
