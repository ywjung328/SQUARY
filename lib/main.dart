import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/image_data_provider.dart';
import 'package:flutter_application_1/view/open_view.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ImageDataProvider>(
      create: (context) => ImageDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.white,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          sliderTheme: SliderThemeData(
            valueIndicatorTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        home: const OpenView(),
      ),
    );
  }
}
