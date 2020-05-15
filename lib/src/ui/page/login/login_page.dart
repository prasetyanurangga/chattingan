//login_register.dart
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_bloc.dart';
import 'package:chattingan/src/bloc/login_register/login_register_bloc.dart';
import 'package:chattingan/src/ui/page/login/login_form.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class LoginPage extends StatelessWidget {
  final LoginRegisterRepository loginRegisterRepository;
  LoginPage({Key key, this.title, @required this.loginRegisterRepository})
      :
        super(key: key);
  final String title;

  Widget build(BuildContext context) {
    return new  Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomPadding: false,
        body :  KeyboardAvoider(
          autoScroll: true,
          child: LoginForm(),
        )
    );
  }
}
