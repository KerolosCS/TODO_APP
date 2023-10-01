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

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/CubitTodo/cubit.dart';
import 'package:todo_app/CubitTodo/states.dart';
import 'package:todo_app/defaults.dart';

class NewTaskScreen extends StatelessWidget {
  // List<Map>? tasks;
  const NewTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasksList;
        return tasksBuilder(tasks: tasks, txt: "No Tasks Yet");
      },
    );
  }
}
