
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';

import '../500.dart';

class Error500Web extends StatelessWidget {
  Error500Web({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            CustomWebBar(),
            Error500(),
            ],
          ),
    );
  }
}
