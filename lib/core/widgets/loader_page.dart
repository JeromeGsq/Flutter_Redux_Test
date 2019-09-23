import 'package:flutter/material.dart';

class LoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
      ),
    );
  }
}
