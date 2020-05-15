import 'package:flutter/material.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ButtonComponent extends StatelessWidget {
  var label, onPress,contexts, warna, warna_font;
  double min_lebar;

  ButtonComponent({Key key, this.label, this.onPress, this.contexts, this.warna : AppColors.redMaincolor, this.warna_font : AppColors.white, this.min_lebar : 400}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPress(contexts),//since this is only a UI app
      child: Text(label,
        style: GoogleFonts.poppins(
          fontSize: Dimens.Level_2,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: warna,
      elevation: 0,
      minWidth: min_lebar,
      height: 50,
      textColor: warna_font,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.Level_2)
      ),
    );
  }
}