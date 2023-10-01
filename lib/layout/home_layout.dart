/*
 *
 * ----------------
 * | 241030072002 |
 * ----------------
 * Copyright © [2023] KERO CS FLUTTER DEVELOPMENT.
 * All Rights Reserved. For inquiries or permissions, contact  me ,
 * https://www.linkedin.com/in/kerolos-fady-software-engineer/
 *
 * /
 */

// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/CubitTodo/cubit.dart';
import 'package:todo_app/CubitTodo/states.dart';
import 'package:todo_app/defaults.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timrController = TextEditingController();
  var dateController = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  //   //import 'package:sqflite_common_ffi/sqflite_ffi.dart';
  //   // sqfliteFfiInit();
  //   // databaseFactory = databaseFactoryFfi;
  //   createDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, Object? state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            body: state is AppGetDatabaseLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.screens[cubit.currentIndexVar],
            appBar: AppBar(
              title: cubit.titles[cubit.currentIndexVar],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // try {
                //   var name = await getName();
                //   // ignore: avoid_print
                //   print(name);
                //   throw ("Error here Anonymous Object !!");
                // } catch (e) {
                //   // ignore: avoid_print
                //   print("error : ${e.toString()}");
                // }

                // getName().then((value) {
                //   print(value);
                //   print("anyThing After Value From getName ");
                // }).catchError((e) {
                //   print("Error");
                // });

                // insertToDatabase();
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timrController.text,
                      date: dateController.text,
                    );
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   date: dateController.text,
                    //   time: timrController.text,
                    // ).then((value) {
                    //   getDataFromDatabase(database).then((value) {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasksList = value;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet(
                        (context) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  color: Colors.grey[200],
                                  child: defaultFormFeild(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    label: 'Task title',
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return 'Title must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefix: Icons.title,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  child: defaultFormFeild(
                                    controller: timrController,
                                    type: TextInputType.datetime,
                                    label: 'Task time',
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return 'time must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefix: Icons.watch_later_outlined,
                                    onTp: () {
                                      // print('button pressed time');
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        print(value?.format(context));
                                        if (value != null) {
                                          timrController.text =
                                              value.format(context).toString();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  color: Colors.grey[200],
                                  child: defaultFormFeild(
                                    controller: dateController,
                                    type: TextInputType.datetime,
                                    label: 'Task Date',
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return 'Date must not be empty';
                                      } else {
                                        return null;
                                      }
                                    },

                                    prefix: Icons.calendar_today,
                                    // click: false,
                                    onTp: () {
                                      // print('button pressed time');
                                      showDatePicker(
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2024, 12, 1),
                                        context: context,
                                        initialDate: DateTime.now(),
                                      ).then((value) {
                                        print(
                                            DateFormat.yMMMd().format(value!));
                                        dateController.text =
                                            DateFormat.yMMMd().format(value);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                      isShow: false,
                      icon: Icons.edit,
                    );
                  });
                  cubit.changeBottomSheetState(
                    isShow: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                cubit.changeIndex(value);
              },
              currentIndex: cubit.currentIndexVar,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: "Archived",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   // throw Exception("in function error");
  //   return 'Kerolos Fady';
  // }
}
