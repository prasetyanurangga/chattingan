import 'package:chattingan/src/constant/env.dart';
import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:chattingan/src/utils/internet_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattingan/src/bloc/login_register/login_register_bloc.dart';
import 'package:chattingan/src/bloc/login_register/login_register_event.dart';
import 'package:chattingan/src/bloc/login_register/login_register_state.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/ui/component/atoms/button.dart';
import 'package:chattingan/src/ui/component/atoms/passwordfield.dart';
import 'package:chattingan/src/ui/component/atoms/textfield.dart';
import 'package:chattingan/src/ui/component/molecules/dialog/dialog_loading.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginButtonPressed(test) {
    BlocProvider.of<LoginRegisterBloc>(context).add(
      LoginButtonPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {



    return BlocListener<LoginRegisterBloc, LoginRegisterState>(
      listener: (context, state) {
        if (state is LoginRegisterFailure) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }

        if(state is LoginRegisterSuccess)
          {
            Navigator.pop(context);
          }

        if(state is LoginRegisterLoading)
          {
            Dialog simpleDialog =  Dialog(

              backgroundColor: AppColors.white,
              child: DialogLoading(contexts : context ),
            );
            showDialog(
                context: context,
                builder: (BuildContext context) => simpleDialog,
                barrierDismissible: false,
            );
          }
      },
      child: BlocBuilder<LoginRegisterBloc, LoginRegisterState>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return new Future(() => false); //return a `Future` with false value so this route cant be popped or closed.
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    child : Image.asset('assets/images/login.png', width : 200.0, height : 100.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top : Dimens.Level_half,left : Dimens.Level_5,right : Dimens.Level_5,bottom : Dimens.Level_half),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(Dimens.Level_1),
                        color: AppColors.veryLigthBlue,
                        child: new TextFieldComponent(
                          hint :"Email",
                          controller: _emailController,
                          warna: AppColors.grey,
                          suffixIcon: Icon(Icons.email, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top : Dimens.Level_0,left : Dimens.Level_5,right : Dimens.Level_5,bottom : Dimens.Level_half),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(Dimens.Level_1),
                        color: AppColors.veryLigthBlue,
                        child: new PasswordFieldComponent(
                          hint :"Password",
                          controller: _passwordController,
                          warna: AppColors.grey,
                          suffixIcon: Icon(Icons.vpn_key, color: AppColors.grey),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top : Dimens.Level_0,left : Dimens.Level_5,right : Dimens.Level_5,bottom : Dimens.Level_half),
                    child: new InkWell(
                        child: LabelComponent(label : "Don't have a account ? Register"),
                        onTap: () {
                          print("pindah");
                          Router.navigator.pushNamed(
                              Router.registerPage,
                              arguments: registerPageArguments(
                                  loginRegisterRepository: LoginRegisterRepository(
                                      env: RepositoryProvider.of<Env>(context),
                                      apiProvider: RepositoryProvider.of<ApiProvider>(context),
                                      internetCheck:
                                      RepositoryProvider.of<InternetCheck>(context))
                              )
                          );
                        }
                    ),
                  ),
                  Container(

                    margin: EdgeInsets.only(top : Dimens.Level_3,left : Dimens.Level_5,right : Dimens.Level_5,bottom : Dimens.Level_5),

                    child : new ButtonComponent(
                      label : "Login", onPress: _onLoginButtonPressed , contexts: "test" , warna: AppColors.redMaincolor, warna_font: AppColors.white,
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }



}
