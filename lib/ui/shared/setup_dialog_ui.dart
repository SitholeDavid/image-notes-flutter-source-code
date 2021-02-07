import 'package:flutter_icons/flutter_icons.dart';
import 'package:notes_plus/core/constants/enums.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/constants/colors.dart';
import 'package:notes_plus/ui/constants/margins.dart';
import 'package:notes_plus/ui/constants/text_sizes.dart';
import 'package:notes_plus/ui/constants/ui_helpers.dart';
import 'package:notes_plus/ui/shared/custom_text_button.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

void setupDialogUi() {
  final DialogService _dialogService = locator<DialogService>();

  final builders = {
    DialogType.editInputField: (context, sheetRequest, completer) =>
        _EditInputDialog(completer: completer, request: sheetRequest),
  };

  _dialogService.registerCustomDialogBuilders(builders);
}

class _EditInputDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  var inputController;
  _EditInputDialog({Key key, this.request, this.completer}) : super(key: key) {
    inputController =
        TextEditingController(text: request.customData['value'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: pageHorizontalMargin, vertical: pageVerticalMargin),
      color: backgroundColor,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediumSpace,
            IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.topLeft,
              icon: Icon(
                Entypo.cross,
                color: Colors.black87,
              ),
              onPressed: null,
            ),
            extraLargeSpace,
            largeSpace,
            Text(
              request.title,
              style:
                  smallTextFont.copyWith(color: Colors.black87, fontSize: 14),
            ),
            TextFormField(
              keyboardType:
                  request.customData['inputType'] ?? TextInputType.text,
              controller: inputController,
              autofocus: true,
            ),
            Expanded(child: Text('')),
            customTextButton(
                buttonText: request.mainButtonTitle,
                onTapCallback: () => completer(
                    DialogResponse(responseData: inputController.text))),
            mediumSpace
          ],
        ),
      ),
    );
  }
}
