import 'package:flutter/material.dart';

import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:chattingan/src/route/base_router.dart';
import 'package:like_button/like_button.dart';

// ignore: must_be_immutable
class ChipButtonHome extends StatelessWidget {
  var warna_like, warna_komen, id_card;

  ChipButtonHome({Key key, this.warna_like, this.warna_komen, this.id_card : '0'}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Future<bool> goToLikePage(bool isLiked) async{
      if(isLiked == false)
        {

        }
      return !isLiked;
    }
    Future<bool> goToKomenPage(bool isLiked) async{
      return false;
    }

    return Container(
      padding: EdgeInsets.all(Dimens.Level_1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.all(Dimens.Level_1),
            child: LikeButton(
                onTap: goToLikePage,
                isLiked: true,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.thumb_up,
                    color: isLiked ? warna_like : Colors.grey,
                  );
                },
                likeCount: 20,
              ),
          ),
          Container(
            margin: EdgeInsets.all(Dimens.Level_1),
            child: LikeButton(
                isLiked: false,
                onTap: goToKomenPage,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.chat_bubble,
                    color: isLiked ? warna_komen : Colors.grey,
                  );
                },
                likeCount: 20,
              ),

          ),
        ],
      ),
    );
  }
}