import 'dart:io';

import 'package:flutter/material.dart';

Map<String, dynamic> dialogCustomData(dynamic value,
        {TextInputType inputType = TextInputType.text}) =>
    {'value': value, 'inputType': inputType};

Future moveFile(File sourceFile, String newPath) async {
  try {
    await sourceFile.rename(newPath);
  } on FileSystemException catch (e) {
    // if rename fails, copy the source file and then delete it
    await sourceFile.copy(newPath);
    await sourceFile.delete();
  }
}
