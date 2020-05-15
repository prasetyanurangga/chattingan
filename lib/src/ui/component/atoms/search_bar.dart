import 'package:flutter/material.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchBarComponent extends StatelessWidget {
  var label, warna, controller;

  SearchBarComponent({Key key, this.label, this.warna, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:Dimens.Level_1_half, right: Dimens.Level_1_half),
      decoration: BoxDecoration(
        color: AppColors.veryLigthBlue,
        borderRadius: new BorderRadius.all(const Radius.circular(Dimens.Level_2)),
      ),
      child: TextFormField(
        controller: controller,
      style: GoogleFonts.poppins(
        color: AppColors.grey,
      ),
      decoration: InputDecoration(
        border : InputBorder.none,
        hintText: "Search",
        prefixIcon: const Icon(Icons.search),
        prefixStyle: TextStyle(
          color: AppColors.grey
        )
      ),
    )
    );
  }
}