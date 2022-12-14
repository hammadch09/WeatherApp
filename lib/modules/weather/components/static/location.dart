import 'dart:developer';

import 'package:WeatherApp/modules/weather/weather_logic.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'loader.dart';

class LocationStaticView extends StatefulWidget {
  const LocationStaticView({Key? key}) : super(key: key);

  @override
  State<LocationStaticView> createState() => _LocationStaticViewState();
}

class _LocationStaticViewState extends State<LocationStaticView> with WidgetsBindingObserver  {

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

  final weatherLogic = Get.put(WeatherLogic());

  void manageLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        Get.off(const LoaderView());
        await weatherLogic.getLocation();
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
            const Text("Please turn on your location"),
            TextButton(
              onPressed: () async {
                await Geolocator.openLocationSettings();
                // await weather.onCheckLocation();
              },
              child: const Text("Open Location Setting"),
            )
          ],
        ),
      ),
    );
  }
}
