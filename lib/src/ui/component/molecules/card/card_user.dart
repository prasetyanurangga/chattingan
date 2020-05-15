import 'package:badges/badges.dart';
import 'package:chattingan/src/constant/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chattingan/src/ui/component/molecules/utils/chip_button_home.dart';
import 'package:chattingan/src/ui/component/atoms/label.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:like_button/like_button.dart';

// ignore: must_be_immutable
class CardUser extends StatelessWidget {
  var heightPhoto,
      widthPhoto,
      maxRadiusPhoto,
      marginSide,
      marginUpdown,
      borderRadius,
      avatarUser,
      userName,
      lastChat,
      lastSeen,
      isOnline,
      countChat;

  CardUser({Key key,
    this.avatarUser = Strings.dummy_image_avatar,
    this.heightPhoto : Dimens.Level_8,
    this.widthPhoto : Dimens.Level_8,
    this.maxRadiusPhoto : Dimens.Level_3,
    this.marginSide : Dimens.Level_3,
    this.marginUpdown : Dimens.Level_1,
    this.borderRadius : const Radius.circular(Dimens.Level_1),
    this.userName : "Sofi",
    this.lastChat : "Hello",
    this.lastSeen : "2 April 2020",
    this.countChat : "10",
    this.isOnline : false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        elevation: Dimens.Level_half,
        margin: EdgeInsets.only(left : marginSide, right: marginSide, top: marginUpdown, bottom: marginUpdown),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: new BorderRadius.all(borderRadius),
            ),
            padding: EdgeInsets.all(Dimens.Level_1),
            child: Row(
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: Dimens.Level_1),
                      child: CircleAvatar(
                        maxRadius: maxRadiusPhoto,
                        child: Image.network(
                            avatarUser,
                            width: widthPhoto,
                            height: heightPhoto
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          alignment : Alignment.centerLeft,
                          child: LabelComponent(
                            label: userName,
                            ketebalan: FontWeight.bold,
                            ukuran: Dimens.Level_2,
                          ),
                        ),
                        Visibility(
                          visible: isOnline,
                          child: Container(
                            alignment : Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: Dimens.Level_1,
                                  height: Dimens.Level_1,
                                  decoration: new BoxDecoration(
                                    color: AppColors.green,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: Dimens.Level_1),
                                  child: LabelComponent(
                                    label: "Online",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !isOnline,
                          child: Container(
                            alignment : Alignment.centerLeft,
                            child: LabelComponent(
                              label: "Offline",
                              warna: AppColors.redMaincolor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}