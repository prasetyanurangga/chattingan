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
class CardUserChat extends StatelessWidget {
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
      hasRead,
      countChat;

  CardUserChat({Key key,
    this.avatarUser = Strings.dummy_image_avatar,
    this.heightPhoto : Dimens.Level_8,
    this.widthPhoto : Dimens.Level_8,
    this.maxRadiusPhoto : Dimens.Level_3,
    this.marginSide : Dimens.Level_3,
    this.marginUpdown : Dimens.Level_1,
    this.borderRadius : const Radius.circular(Dimens.Level_1),
    this.userName : "Sofi",
    this.hasRead : false,
    this.lastChat : "Hello",
    this.lastSeen : "2 April 2020",
    this.countChat : "10",
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LabelComponent(
                            label: userName,
                            ketebalan: FontWeight.bold,
                            ukuran: Dimens.Level_2,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LabelComponent(
                            label: lastChat,
                            ketebalan: FontWeight.normal,
                            ukuran: Dimens.Level_1_half,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Wrap(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: LabelComponent(
                              label: lastSeen,
                              ketebalan: FontWeight.bold,
                              ukuran: Dimens.Level_2,
                              warna: AppColors.redMaincolor,
                            ),
                          ),
                          Container(
                            child: Visibility(
                              visible: hasRead,
                              child: Badge(
                                  badgeColor: AppColors.redMaincolor,
                                  shape: BadgeShape.circle,
                                  borderRadius: Dimens.Level_3,
                                  toAnimate: false,
                                  badgeContent: Container(
                                    margin: EdgeInsets.all(Dimens.Level_half),
                                    child: LabelComponent(label: countChat, ukuran: Dimens.Level_2, warna: AppColors.white),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}