import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/ui/component/atoms/button.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DialogFile extends StatelessWidget {
  var 
      nama,
      keterangan,
      contexts;

  DialogFile({Key key,
    this.nama : 'Lorem Ipsum',
    this.keterangan : 'dolor sir amet',
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
          width: Dimens.Level_40,
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(Dimens.Level_3),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimens.Level_half, left: Dimens.Level_half, right: Dimens.Level_half, bottom: Dimens.Level_2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Wrap(
                              children: [
                                 CircleAvatar(
                                  maxRadius: Dimens.Level_2,
                                  child: Icon(Icons.insert_drive_file),
                                ),

                              ],
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: Dimens.Level_2),
                                child: Column(
                                  children: [
                                    Container(
                                      child: LabelComponent(label: nama.toString().length > 25 ? nama.toString().substring(0, 25) + '...' : nama.toString(), ukuran: Dimens.Level_2, warna: AppColors.black),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: LabelComponent(label: keterangan, ukuran: Dimens.Level_1_half, warna: AppColors.black),
                                    ),
                                  ],
                                ),
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex : 1,
                          child: Container(
                              padding: EdgeInsets.all(Dimens.Level_1),
                              child: ButtonComponent(label: "Cancel",warna: AppColors.redMaincolor,warna_font: AppColors.white, onPress: dismissDialog, contexts: contexts,)
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.all(Dimens.Level_1),
                              child: ButtonComponent(label: "Send",warna: AppColors.redMaincolor,warna_font: AppColors.white, onPress: dismissDialog, contexts: contexts,)
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          ),
        )
      ],
    );
  }
}