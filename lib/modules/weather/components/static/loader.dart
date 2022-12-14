import 'package:flutter/material.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/clouds.png',
              height: 200,
              width: 200,
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
