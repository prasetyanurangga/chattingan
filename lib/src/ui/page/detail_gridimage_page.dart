//login_register.dart
import 'package:chattingan/src/model/file_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_bloc.dart';
import 'package:chattingan/src/bloc/authentication/authentication_state.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/model/user_chat_response_model.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class DetailGridImagePage extends StatefulWidget {
  DetailGridImagePage({Key key, this.title, this.count, this.data}) : super(key: key);
  final String title;
  final int count;
  final List<Files> data;

  @override
  _DetailGridImagePageState createState() => _DetailGridImagePageState();
}

class _DetailGridImagePageState extends State<DetailGridImagePage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationUnauthenticated) {
            Router.navigator.pushNamed(Router.landingPage);
          }
        },
        child : new Scaffold(
          backgroundColor: AppColors.white,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: AppColors.white,
            leading: new IconButton(
              icon: new Icon(Icons.chevron_left, color: AppColors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: LabelComponent(label: widget.title, ukuran: Dimens.Level_2, warna: AppColors.grey),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: LabelComponent(label: widget.count.toString() + ' Photos', ukuran: Dimens.Level_1_half, warna: AppColors.grey),
                  )
                ],
              ),
            ),
          ),
          body: KeyboardAvoider(
            autoScroll: true,
            child: Container(
              child: Column(
                children: List.generate(widget.data.length, (index){
                  return Container(
//                    width: MediaQuery.of(context).size.width,
//                    padding: EdgeInsets.all(Dimens.Level_1),
//                    child: Image.network(widget.data[index].url),
                  );
                }),
              ),
            ),
          ),
        )
    );
  }

}


