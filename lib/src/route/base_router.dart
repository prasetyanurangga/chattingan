// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:chattingan/src/model/file_model.dart';
import 'package:chattingan/src/repository/login_register/login_register_repository.dart';
import 'package:chattingan/src/ui/page/chat/chat_page.dart';
import 'package:chattingan/src/ui/page/detail_gridimage_page.dart';
import 'package:chattingan/src/ui/page/login/login_page.dart';
import 'package:chattingan/src/ui/page/main/main_page.dart';
import 'package:chattingan/src/ui/page/main/users_page.dart';
import 'package:chattingan/src/ui/page/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/ui/page/landing/landing_page.dart';

class Router {
  static const landingPage = '/';
  static const mainPage = '/main-page';
  static const chatPage = '/chat-page';
  static const userPage = '/user-page';
  static const loginPage = '/login-page';
  static const registerPage = '/register-page';
  static const detailGridImagePage = '/detail-grid-image-page';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.landingPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LandingPage(),
          settings: settings,
        );
      case Router.loginPage:
        if (hasInvalidArgs<loginPageArguments>(args)) {
          return misTypedArgsRoute<loginPageArguments>(args);
        }
        final typedArgs = args as loginPageArguments ?? loginPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              LoginPage(key: typedArgs.key, title: typedArgs.title, loginRegisterRepository: typedArgs.loginRegisterRepository),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      case Router.registerPage:
        if (hasInvalidArgs<registerPageArguments>(args)) {
          return misTypedArgsRoute<registerPageArguments>(args);
        }
        final typedArgs = args as registerPageArguments ?? registerPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              RegisterPage(key: typedArgs.key, title: typedArgs.title, loginRegisterRepository: typedArgs.loginRegisterRepository),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      case Router.mainPage:
        if (hasInvalidArgs<mainPageArguments>(args)) {
          return misTypedArgsRoute<mainPageArguments>(args);
        }
        final typedArgs = args as mainPageArguments ?? mainPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              MainPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      case Router.userPage:
        if (hasInvalidArgs<userPageArguments>(args)) {
          return misTypedArgsRoute<userPageArguments>(args);
        }
        final typedArgs = args as userPageArguments ?? userPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              UsersPage(key: typedArgs.key, title: typedArgs.title),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      case Router.chatPage:
        if (hasInvalidArgs<chatPageArguments>(args)) {
          return misTypedArgsRoute<chatPageArguments>(args);
        }
        final typedArgs = args as chatPageArguments ?? chatPageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ChatPage(
                  key: typedArgs.key,
                  title: typedArgs.title,
                  senderId : typedArgs.senderId,
                  senderName : typedArgs.senderName,
                  senderIsOnline : typedArgs.senderIsOnline,
                  previousPage: typedArgs.previousPage,
              ),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      case Router.detailGridImagePage:
        if (hasInvalidArgs<DetailGridImagePageArguments>(args)) {
          return misTypedArgsRoute<DetailGridImagePageArguments>(args);
        }
        final typedArgs = args as DetailGridImagePageArguments ?? DetailGridImagePageArguments();
        return PageRouteBuilder<dynamic>(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              DetailGridImagePage(key: typedArgs.key, title: typedArgs.title, data: typedArgs.data, count: typedArgs.count),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          transitionDuration: Duration(milliseconds: 400),
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

class mainPageArguments {
  final Key key;
  final String title;
  mainPageArguments({this.key, this.title});
}

class userPageArguments {
  final Key key;
  final String title;
  userPageArguments({this.key, this.title});
}

class loginPageArguments {
  final Key key;
  final String title;
  final LoginRegisterRepository loginRegisterRepository;
  loginPageArguments({this.key, this.title, this.loginRegisterRepository});
}

class registerPageArguments {
  final Key key;
  final String title;
  final LoginRegisterRepository loginRegisterRepository;
  registerPageArguments({this.key, this.title, this.loginRegisterRepository});
}

class chatPageArguments {
  final Key key;
  final String title;
  final String senderId;
  final String senderName;
  final bool senderIsOnline;
  final String previousPage;
  chatPageArguments({this.key, this.title, this.senderId, this.senderName, this.previousPage, this.senderIsOnline});
}

//DetailGridImagePage arguments holder class
class DetailGridImagePageArguments {
  final Key key;
  final String title;
  final int count;
  final List<Files> data;
  DetailGridImagePageArguments({this.key, this.title, this.count, this.data});
}
