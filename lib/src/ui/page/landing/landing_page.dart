
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:chattingan/src/ui/page/main/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_state.dart';
import 'package:chattingan/src/constant/env.dart';
import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/ui/page/landing/splash_page.dart';
import 'package:chattingan/src/ui/page/login/login_page.dart';
import 'package:chattingan/src/utils/internet_check.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationLoading) {
           //return const LoadingWidget();
          }

          if (state is AuthenticationAuthenticated) {
            return MainPage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
                loginRegisterRepository: LoginRegisterRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                    RepositoryProvider.of<InternetCheck>(context))
            );
          }
          return SplashPage();
        });
  }
}