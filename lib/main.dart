import 'package:flutter/material.dart';
import 'package:notes_plus/locator.dart';
import 'package:notes_plus/ui/router.dart';
import 'package:notes_plus/ui/shared/setup_dialog_ui.dart';
import 'package:notes_plus/ui/views/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Plus',
      onGenerateRoute: generateRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
