import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_plus/core/viewmodels/home_viewmodel.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/margins.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';
import 'package:notes_plus/ui/constants/ui_helpers.dart';
import 'package:notes_plus/ui/widgets/loading_indicator.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: backgroundColor,
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(
                        bottom: 25,
                        top: 60,
                        left: pageHorizontalMargin,
                        right: pageHorizontalMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 35),
                              child: Text(
                                'upload and link files to your notes'
                                    .toUpperCase(),
                                style: largeTextFont.copyWith(
                                    color: primaryColor,
                                    fontSize: 19,
                                    letterSpacing: 2.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            mediumSpace,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Easily link your photos, videos, links and pdf files to your personal notes.',
                                style: mediumTextFont.copyWith(
                                    fontSize: 14, letterSpacing: 1.3),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () =>
                                    model.navigateToCameraView('NEW'),
                                child: Text(
                                  'New File',
                                  style: mediumTextFont.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor),
                                ),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.resolveWith(
                                        (states) => EdgeInsets.all(15)),
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => primaryColorDark
                                                .withOpacity(0.15)),
                                    shape: MaterialStateProperty.resolveWith(
                                        (states) => RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            side: BorderSide(
                                                color: primaryColorDark)))),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: TextButton(
                              onPressed: () =>
                                  model.navigateToCameraView('EXISTING'),
                              child: Text(
                                'View File',
                                style: mediumTextFont.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => primaryColor),
                                padding: MaterialStateProperty.resolveWith(
                                    (states) => EdgeInsets.all(15)),
                                shape: MaterialStateProperty.resolveWith(
                                    (states) => RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: primaryColorDark))),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  loadingIndicator(model.isBusy)
                ],
              ),
            ),
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (model) async => await model.initialise());
  }
}
