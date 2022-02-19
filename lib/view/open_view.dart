import 'package:flutter/material.dart';
//import 'package:flutter_application_1/widget/custom_app_bar.dart';

class OpenView extends StatelessWidget {
  const OpenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "SQUARY",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(),
    );
  }
}
