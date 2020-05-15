import 'package:chattingan/src/app/simple_bloc_delegate.dart';
import 'package:chattingan/src/app/theme.dart';
import 'package:chattingan/src/bloc/authentication/authentication_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_event.dart';
import 'package:chattingan/src/bloc/login_register/login_register_bloc.dart';
import 'package:chattingan/src/bloc/main/main_bloc.dart';
import 'package:chattingan/src/bloc/other/other_bloc.dart';
import 'package:chattingan/src/constant/env.dart';
import 'package:chattingan/src/constant/string.dart';
import 'package:chattingan/src/http/api_provider.dart';
import 'package:chattingan/src/repository/authentication/authentication_repository.dart';
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:chattingan/src/repository/main/main_repository.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/utils/internet_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(AppPage());
}

class AppPage extends StatelessWidget {
  var env;
  MainRepository mainRepository;


  AppPage({Key key, @required this.env}) : super(key: key);
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Env>(
          create: (context) => env,
          lazy: true,
        ),
        RepositoryProvider<InternetCheck>(
          create: (context) => InternetCheck(),
          lazy: true,
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          lazy: true,
        ),
        RepositoryProvider<MainRepository>(
          create: (context) => MainRepository(
              env: RepositoryProvider.of<Env>(context),
              apiProvider: RepositoryProvider.of<ApiProvider>(context),
              internetCheck:
              RepositoryProvider.of<InternetCheck>(context)
          ),
          lazy: true,
        ),
        RepositoryProvider<LoginRegisterRepository>(
          create: (context) => LoginRegisterRepository(
              env: RepositoryProvider.of<Env>(context),
              apiProvider: RepositoryProvider.of<ApiProvider>(context),
              internetCheck:
              RepositoryProvider.of<InternetCheck>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(),
          lazy: true,
        ),
      ],
      child: MultiBlocProvider  (
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                return AuthenticationBloc(
                    authenticationRepository :
                    RepositoryProvider.of<AuthenticationRepository>(context))
                  ..add(AuthStarted());
              },
            ),
            BlocProvider<OtherBloc>(
              create: (context)  => OtherBloc(
                  mainRepository: MainRepository(
                  env: RepositoryProvider.of<Env>(context),
                  apiProvider: RepositoryProvider.of<ApiProvider>(context),
                  internetCheck:
                    RepositoryProvider.of<InternetCheck>(context))
                  ),
              ),
            BlocProvider<MainBloc>(
              create: (context)  => MainBloc(
                mainRepository: MainRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                    RepositoryProvider.of<InternetCheck>(context))
              ),
            ),
            BlocProvider<LoginRegisterBloc>(
              create: (context)  => LoginRegisterBloc(
                  authenticationBloc : BlocProvider.of<AuthenticationBloc>(context),
                  loginRegisterRepository: LoginRegisterRepository(
                      env: RepositoryProvider.of<Env>(context),
                      apiProvider: RepositoryProvider.of<ApiProvider>(context),
                      internetCheck:
                      RepositoryProvider.of<InternetCheck>(context))
              ),
            ),
          ],
          child: MaterialApp(
            title: Strings.app_name,
            theme: TemaUtama(),
            onGenerateRoute: Router.onGenerateRoute,
            navigatorKey: Router.navigator.key,
            initialRoute: Router.landingPage,
          )
      ),
    );
  }
}
