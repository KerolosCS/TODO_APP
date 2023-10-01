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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../CubitTodo/cubit.dart';
import '../CubitTodo/states.dart';
import '../defaults.dart';

class DoneTaskSreen extends StatelessWidget {
  const DoneTaskSreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).doneTasksList;
        return tasksBuilder(tasks: tasks, txt: "No Done Tasks yet");
      },
    );
  }
}
