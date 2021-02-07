import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:notes_plus/core/constants/enums.dart';
import 'package:notes_plus/core/viewmodels/choose_file_viewmodel.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/margins.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';
import 'package:notes_plus/ui/constants/ui_helpers.dart';
import 'package:stacked/stacked.dart';

class ChooseFileView extends StatelessWidget {
  final String detectedText;

  ChooseFileView({this.detectedText});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChooseFileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(
                horizontal: pageHorizontalMargin, vertical: pageVerticalMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                largeSpace,
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    'Choose the file type you wish to store',
                    style: largeTextFont.copyWith(
                        color: primaryColor, fontSize: 19, letterSpacing: 2.5),
                    textAlign: TextAlign.center,
                  ),
                ),
                extraLargeSpace,
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    childAspectRatio: 100 / 120,
                    children: [
                      fileOption('Picture', EvilIcons.camera, FileType.IMAGE,
                          model.chooseFile),
                      fileOption(
                          'Document',
                          MaterialCommunityIcons.file_document_outline,
                          FileType.DOC,
                          model.chooseFile),
                      fileOption('Link', MaterialCommunityIcons.link,
                          FileType.LINK, model.chooseFile),
                      fileOption('Video', AntDesign.videocamera, FileType.VIDEO,
                          model.chooseFile),
                    ],
                  ),
                )
              ],
            )),
      ),
      viewModelBuilder: () => ChooseFileViewModel(),
      onModelReady: (model) => model.initialise(detectedText),
    );
  }
}

Widget fileOption(
    String title, IconData icon, FileType type, Function onTapCallback) {
  return GestureDetector(
    onTap: () => onTapCallback(type),
    child: Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: primaryColorDark.withOpacity(0.35),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          Text(
            title,
            style: mediumTextFont.copyWith(color: Colors.white),
          )
        ],
      ),
    ),
  );
}
