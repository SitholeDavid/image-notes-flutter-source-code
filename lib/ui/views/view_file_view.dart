import 'package:flutter/material.dart';
import 'package:notes_plus/core/viewmodels/view_file_viewmodel.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';
import 'package:stacked/stacked.dart';

class ViewFileView extends StatelessWidget {
  final String detectedText;
  ViewFileView({this.detectedText});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewFileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(15),
          color: primaryColorDark.withOpacity(0.15),
          child: model.isBusy
              ? Center()
              : Center(
                  child: SelectableText(
                    model.linkValue,
                    style: mediumTextFont,
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
      viewModelBuilder: () => ViewFileViewModel(),
      onModelReady: (model) async => await model.showFile(detectedText),
    );
  }
}
