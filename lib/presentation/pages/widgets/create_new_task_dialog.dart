import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/storage/database.dart';
import 'package:todo_app/data/storage/states.dart';
import 'package:todo_app/presentation/pages/widgets/text_form_field.dart';
import 'package:todo_app/utils/check_condition.dart';
import 'package:todo_app/utils/constant/const.dart';
import 'package:todo_app/utils/formatter.dart';

class CreateNewTaskDialog extends StatefulWidget {
  const CreateNewTaskDialog({Key? key}) : super(key: key);

  @override
  _CreateNewTaskDialogState createState() => _CreateNewTaskDialogState();
}

class _CreateNewTaskDialogState extends State<CreateNewTaskDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  color: COLORCONST.WHITE,
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
                          child: Text(
                            "Create Task",
                            style: FONTCONST.BOLD_24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            titleController.clear();
                            timeController.clear();
                            dateController.clear();
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 24.0,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          controller: titleController,
                          label: "New Task",
                          hintText: "Enter new task",
                          type: TextInputType.text,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Title must not be empty";
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
                                  timeController.text = value!.format(context);
                                }
                              });
                            },
                            readOnly: true,
                            controller: timeController,
                            label: "Task Time",
                            hintText: "Select new time",
                            type: TextInputType.datetime,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Time must not be empty";
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
                                      lastDate: DateTime.parse("2022-10-03"))
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
                            label: "Task Deadline",
                            hintText: "Select new deadline",
                            type: TextInputType.datetime,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return "Date must not be empty";
                              }
                              return null;
                            },
                            prefix: Icons.calendar_today),
                      ],
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
                                    const BorderSide(color: COLORCONST.BLACK2)),
                            child: const Center(
                              child: Text(
                                "Cancel",
                                style: FONTCONST.REGULAR,
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
                          color: COLORCONST.BLACK2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Center(
                            child: Text(
                              "Create",
                              style: FONTCONST.REGULAR_WHITE,
                            ),
                          ),
                          onPressed: createTaskTextFieldContainInput(
                                  titleController.text,
                                  timeController.text,
                                  dateController.text)
                              ? () {
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
                                }
                              : () {},
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
}
