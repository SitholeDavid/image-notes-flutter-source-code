import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_plus/core/viewmodels/camera_viewmodel.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';
import 'package:notes_plus/ui/constants/ui_helpers.dart';
import 'package:notes_plus/ui/widgets/loading_indicator.dart';
import 'package:stacked/stacked.dart';

class CameraView extends StatelessWidget {
  final String selectedFunction;
  CameraView({this.selectedFunction});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CameraViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: model.preview == null
              ? loadingIndicator(true)
              : Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: model.getPreview(),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black54.withOpacity(0.4),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 200),
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Column(
                      children: [
                        largeSpace,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          height: 60,
                          width: double.infinity,
                          color: Colors.white,
                          child: TextButton(
                            onPressed: model.editDetectedText,
                            child: Text(
                              model.detectedText,
                              style: mediumTextFont.copyWith(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                            child: model.isBusy
                                ? Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.transparent,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 90),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          child: LoadingIndicator(
                                              indicatorType:
                                                  Indicator.lineSpinFadeLoader,
                                              color: Colors.white),
                                        ),
                                        mediumSpace,
                                        Text(
                                          'Scanning...',
                                          style: mediumTextFont.copyWith(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                : Text('')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  model.isBusy ? null : model.takePicture(),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: primaryColorDark.withOpacity(0.15),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Scan',
                                        style: mediumTextFont.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: primaryColor),
                                      ),
                                      Icon(
                                        Icons.camera_alt,
                                        color: primaryColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: model.newFile
                                    ? model.navigateToChooseFileView
                                    : model.navigateToViewFileRoute,
                                child: Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(35),
                                      color: primaryColor,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Proceed',
                                          style: mediumTextFont.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        largeSpace
                      ],
                    )
                  ],
                )),
      viewModelBuilder: () => CameraViewModel(),
      onModelReady: (model) async =>
          await model.initialise(this.selectedFunction),
    );
  }
}
