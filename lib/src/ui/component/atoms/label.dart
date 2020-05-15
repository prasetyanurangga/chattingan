import 'package:flutter/material.dart';
import 'package:chattingan/src/constant/color.dart';
import 'package:chattingan/src/constant/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LabelComponent extends StatelessWidget {
  var label = 'Lorem Ipsum', warna = AppColors.black, ukuran = Dimens.Level_2, ketebalan  = FontWeight.normal, jenis = FontStyle.normal;

  LabelComponent({Key key, this.label, this.warna, this.ukuran, this.ketebalan, this.jenis}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: GoogleFonts.poppins(
          fontSize: ukuran,
          fontWeight: ketebalan,
          fontStyle: jenis,
          color: warna
      )
    );
  }
}