import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_plus/ui/constants/routes.dart';
import 'package:notes_plus/ui/views/camera_view.dart';
import 'package:notes_plus/ui/views/choose_file_view.dart';
import 'package:notes_plus/ui/views/home_view.dart';
import 'package:notes_plus/ui/views/view_file_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return MaterialPageRoute(builder: (_) => HomeView());
    case CameraViewRoute:
      String selectedOption = settings.arguments.toString();
      return MaterialPageRoute(
          builder: (_) => CameraView(
                selectedFunction: selectedOption,
              ));
    case ChooseFileViewRoute:
      String detectedText = settings.arguments.toString();

      return MaterialPageRoute(
          builder: (_) => ChooseFileView(detectedText: detectedText));
    case ViewFileViewRoute:
      String detectedText = settings.arguments.toString();

      return MaterialPageRoute(
          builder: (_) => ViewFileView(
                detectedText: detectedText,
              ));
    default:
      return MaterialPageRoute(builder: (_) => null);
  }
}
