import 'package:WeatherApp/modules/weather/components/static/loader.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../weather_logic.dart';

class PermissionStaticView extends StatefulWidget {
  const PermissionStaticView({Key? key}) : super(key: key);

  @override
  State<PermissionStaticView> createState() => _PermissionStaticViewState();
}

class _PermissionStaticViewState extends State<PermissionStaticView> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    manageLifecycleState(state);
    super.didChangeAppLifecycleState(state);
  }

  // final weatherLogic = Get.put(WeatherLogic());

  void manageLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        Get.off(const LoaderView());
        // await weatherLogic.getLocation();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Need Location Permission"),
            TextButton(
              onPressed: () async {
                await Geolocator.openAppSettings();
              },
              child: const Text("Go To Permission Setting"),
            ),
          ],
        ),
      ),
    );
  }
}
