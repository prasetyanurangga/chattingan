import 'package:chattingan/src/bloc/main/main_bloc.dart';
import 'package:chattingan/src/bloc/main/main_event.dart';
import 'package:chattingan/src/bloc/other/other_bloc.dart';
import 'package:chattingan/src/bloc/other/other_event.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
// ignore: must_be_immutable
class CardChat extends StatelessWidget {
  var message, timesend, avatarUser, warnaDasar,
      warnaFont_label1,
      wanraFont_label2,
      wanraFont_label3,
      ukuran_label1,
      ukuran_label2,
      ukuran_label3,
      namaFile,
      IdFile,
      hasFile,
      hasRead,
      isSender;

  CardChat({Key key,
    this.message = 'Lorem Ipsum',
    this.namaFile = 'Lorem Ipsum',
    this.IdFile,
    this.hasFile = false,
    this.hasRead = false,
    this.timesend = 'Dolor',
    this.avatarUser,
    this.warnaDasar : AppColors.veryLigthBlue,
    this.warnaFont_label1 : AppColors.black,
    this.wanraFont_label2 : AppColors.black,
    this.ukuran_label1 : Dimens.Level_2,
    this.ukuran_label2 : Dimens.Level_1_half,
    this.ukuran_label3 : Dimens.Level_1_half,
    this.isSender : true,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding : EdgeInsets.all(Dimens.Level_half),
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.Level_2),
            ),
            child: Container(
                decoration: BoxDecoration(
                  color: isSender ? AppColors.white : AppColors.blueGrey,
                  borderRadius: new BorderRadius.all(const Radius.circular(Dimens.Level_2)),
                ),
                padding: EdgeInsets.all(Dimens.Level_1_half),
                child: Column(
                  children: <Widget>[
                    Visibility(
                      visible: hasFile,
                      child: GestureDetector(
                        onTap: ()
                        {
                          BlocProvider.of<OtherBloc>(context).add(
                            FetchFile(
                                fileId: IdFile
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimens.Level_1),
                          decoration: BoxDecoration(
                            color: !isSender ? AppColors.white : AppColors.blueGrey,
                            borderRadius: new BorderRadius.all(const Radius.circular(Dimens.Level_2)),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: <Widget>[
                              Wrap(
                                children: <Widget>[
                                  Container(
                                    child: Icon(Icons.insert_drive_file),
                                    margin: EdgeInsets.only(right: Dimens.Level_half),
                                  )
                                ],
                              ),
                              Expanded(
                                child: LabelComponent(label: namaFile, ukuran: Dimens.Level_2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top : Dimens.Level_1, left: Dimens.Level_1),
                      child: LabelComponent(label: message, ukuran: Dimens.Level_2),
                    ),
                  ],
                )
            ),
          ),
          Container(
            alignment: Alignment.centerRight,

            padding: EdgeInsets.only(right:  Dimens.Level_1_half, left:  Dimens.Level_1_half),
            child: Stack(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Container(
                      alignment: !isSender ? Alignment.centerLeft : Alignment.centerRight,
                      child: LabelComponent(label: timesend, ukuran: Dimens.Level_1_half),
                    )
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Container(
                      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
                      child : Visibility(
                      visible: hasRead,
                      child: LabelComponent(label: "read", ukuran: Dimens.Level_1_half, warna: AppColors.green, ketebalan: FontWeight.bold),
                    )
                     )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}