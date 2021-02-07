import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_plus/ui/constants/colors.dart';

Widget loadingIndicator(bool isLoading) {
  return isLoading
      ? Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.black26,
          child: Container(
            height: 60,
            width: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.circleStrokeSpin,
              color: primaryColorDark,
            ),
          ),
        )
      : SizedBox(
          height: 0,
        );
}
