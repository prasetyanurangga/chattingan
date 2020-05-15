import 'package:flutter/material.dart';
import 'dart:async';

import 'package:chattingan/src/constant/dimens.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFieldComponent extends StatefulWidget {
  var label, controller,hint, border, warna, ukuran, onTap, value, prefixIcon,suffixIcon, keyboard, maxLine, inputFormatter,errorText;

  TextFieldComponent({Key key,
    this.label,
    this.controller,
    this.hint : "",
    this.border : InputBorder.none,
    this.warna : Colors.black,
    this.ukuran : Dimens.Level_2,
    this.onTap,
    this.value : '',
    this.prefixIcon,
    this.suffixIcon,
    this.keyboard : TextInputType.text,
    this.maxLine: 1,
    this.errorText : null,
    this.inputFormatter,
  }) : super(key: key);

  @override
  _TextFieldComponentState createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {

  @override
  void initState() {
    super.initState();
    print(widget.value);
    if(widget.value != '')
      {
        widget.controller = new TextEditingController();
        widget.controller.text = widget.value;
      }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTap: () => widget.onTap(),
      inputFormatters: widget.inputFormatter,
      keyboardType: widget.keyboard,
      maxLines: widget.maxLine,
      style: GoogleFonts.poppins(
        color: widget.warna,
      ),
      decoration: InputDecoration(
          prefix: widget.prefixIcon,
          errorText: widget.errorText,
          suffixIcon: widget.suffixIcon,
          border: widget.border,
          hintText: widget.hint,
          labelStyle: GoogleFonts.poppins(
              fontSize: widget.ukuran
          )
      ),
    );
  }
}