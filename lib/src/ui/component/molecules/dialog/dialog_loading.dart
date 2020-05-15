
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';

// ignore: must_be_immutable
class DialogLoading extends StatelessWidget {
  var 
      nama,
      keterangan,
      contexts;

  DialogLoading({Key key,
    this.contexts,
  }) : super(key: key);

  void dismissDialog(contexts)
  {
    Navigator.pop(contexts);
  }


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          alignment: Alignment.center,
          width: 280,
          child: Center(
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(Dimens.Level_3),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: CircularProgressIndicator(),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: Dimens.Level_2),
                      child: LabelComponent(label: "Please Wait", ukuran: Dimens.Level_2, warna: AppColors.black),
                    )
                  ],
                )
            ),
          ),
        )
      ],
    );
  }
}