import 'package:flutter/material.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';

Widget customTextButton({String buttonText, Function onTapCallback}) {
  return Row(children: [
    Expanded(
        child: TextButton(
      onPressed: onTapCallback,
      child: Text(
        buttonText,
        style: mediumTextFont.copyWith(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => primaryColorDark),
          padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.symmetric(vertical: 12, horizontal: 10)),
          shape: MaterialStateProperty.resolveWith((states) =>
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: primaryColorDark)))),
    ))
  ]);
}
