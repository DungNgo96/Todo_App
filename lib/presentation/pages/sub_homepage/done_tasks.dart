import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/data/storage/database.dart';
import 'package:todo_app/data/storage/states.dart';
import 'package:todo_app/utils/check_condition.dart';
import 'package:todo_app/utils/constant/const.dart';

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
              padding: const EdgeInsets.only(left: 15, top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Done Tasks",
                    style: FONTCONST.SEMIBOLD_36,
                  ),
                  Container(height: size.height * 0.1),
                  doneTaskList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool checkBoxValue = getUpdatedStatusBool(
                                doneTaskList[index]["status"]);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
                                  color: checkBoxValue == false
                                      ? COLORCONST.ORANGE
                                      : COLORCONST.GREEN,
                                ),
                                height: size.height * 0.1,
                                child: IntrinsicHeight(
                                  child: Slidable(
                                    key: Key(doneTaskList[index]["title"]),
                                    endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            AppDataBase.get(context)
                                                .deleteFromDB(
                                                    doneTaskList[index]["id"]);
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
                                                checkColor: COLORCONST.WHITE,
                                                activeColor:
                                                    COLORCONST.LIGHTBLUE,
                                                value: checkBoxValue,
                                                onChanged: (value) {
                                                  String newStatus =
                                                      getUpdatedStatusString(
                                                          value);
                                                  setState(() {
                                                    AppDataBase.get(context)
                                                        .updateDB(
                                                            newStatus,
                                                            doneTaskList[index]
                                                                ["id"]);
                                                  });
                                                },
                                              ),
                                              Text(
                                                doneTaskList[index]["title"],
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
                                                doneTaskList[index]["date"],
                                                style: FONTCONST.REGULAR_20,
                                              ),
                                              Text(
                                                doneTaskList[index]["time"],
                                                style: FONTCONST.REGULAR_20,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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
