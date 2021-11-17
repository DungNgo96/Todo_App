import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/data/states.dart';
import 'package:todo_app/presentation/pages/widgets/text_form_field.dart';

class CreateNewTaskDialog extends StatefulWidget {
  const CreateNewTaskDialog({Key? key}) : super(key: key);

  @override
  _CreateNewTaskDialogState createState() => _CreateNewTaskDialogState();
}

class _CreateNewTaskDialogState extends State<CreateNewTaskDialog> {
  // bool isAgree = false;
  // ScrollController scrollController = new ScrollController();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;

    return BlocConsumer<AppDataBase, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppDataBase db = AppDataBase.get(context);
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  color: Color(0xffffffff),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: size.height * 0.05,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Create Task",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24.0,
                                color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            titleController.clear();
                            timeController.clear();
                            dateController.clear();
                            Navigator.pop(context);
                            // print("Title: " + titleController.text);
                            // print("Time: " + timeController.text);
                            // print("Date: " + dateController.text);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 24.0,
                          ),
                        )
                      ],
                    ),
                    Form(
                      // key: formKey,
                      child: Column(
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          DefaultFormField(
                            controller: titleController,
                            label: 'New Task',
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'Title must not be empty';
                              }
                              return null;
                            },
                            prefix: Icons.title,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: checkInputtedTime(
                                            timeController.text))
                                    .then((value) {
                                  var checkNullValue = value;
                                  if (checkNullValue != null) {
                                    timeController.text =
                                        value!.format(context);
                                  }
                                });
                              },
                              readOnly: true,
                              controller: timeController,
                              label: 'Task Time',
                              type: TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Time must not be empty';
                                }
                                return null;
                              },
                              prefix: Icons.watch_later_outlined),
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultFormField(
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: checkInputtedDate(
                                            dateController.text),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse('2022-10-03'))
                                    .then((value) {
                                  var checkNullValue = value;
                                  if (checkNullValue != null) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  }
                                });
                              },
                              readOnly: true,
                              controller: dateController,
                              label: 'Task Deadline',
                              type: TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Date must not be empty';
                                }

                                return null;
                              },
                              prefix: Icons.calendar_today),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side:
                                    const BorderSide(color: Color(0x95171717))),
                            child: const Center(
                              child: Text(
                                "Cancel",
                              ),
                            ),
                            onPressed: () {
                              titleController.clear();
                              timeController.clear();
                              dateController.clear();
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        MaterialButton(
                          color: const Color(0x95171717),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: const Center(
                            child: Text(
                              "Create",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            db
                                .insertToDB(
                                    title: titleController.text,
                                    time: timeController.text,
                                    date: dateController.text)
                                .then((value) {
                              titleController.clear();
                              timeController.clear();
                              dateController.clear();
                              Navigator.pop(context);
                            });
                          },
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  TimeOfDay checkInputtedTime(String time) {
    if (time != "" && time.isNotEmpty) {
      final format = DateFormat.jm();
      return TimeOfDay.fromDateTime(format.parse(time));
    } else {
      return TimeOfDay.now();
    }
  }

  DateTime checkInputtedDate(String date) {
    if (date != "" && date.isNotEmpty) {
      return DateFormat("MMM dd, yyyy").parse(date);
    } else {
      return DateTime.now();
    }
  }
}
