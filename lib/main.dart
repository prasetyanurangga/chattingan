
import 'package:flutter/material.dart';
import 'package:chattingan/src/app/app.dart';
import 'package:chattingan/src/bloc/app_bloc.dart';
import 'package:chattingan/src/constant/env.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = AppBloc();
  runApp(AppPage(env: EnvValue.production));
}
