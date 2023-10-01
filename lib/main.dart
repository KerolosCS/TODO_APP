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

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/home_layout.dart';
import 'constants/const.dart';

void main(List<String> args) {
  Bloc.observer = MyBlocObserver();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    ),
  );
}
