import 'package:WeatherApp/modules/weather/components/location_list/location_list_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LocationListView extends StatelessWidget {
  LocationListView({Key? key}) : super(key: key);

  final locationListLogic = Get.put(LocationListLogic());

  @override
  Widget build(BuildContext context) {
    Widget _dialog(BuildContext context, latitudeField, longitudeField,
        GlobalKey<FormState> formKey) {
      return AlertDialog(
        title: const Text('Add Coordinates'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: latitudeField,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" is not a valid number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Latitude here",
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: longitudeField,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter latitude';
                  }
                  final n = num.tryParse(value);
                  if (n == null) {
                    return '"$value" is not a valid number';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Longitude here",
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              formKey.currentState?.reset();
            },
          ),
          TextButton(
            onPressed: () {
              locationListLogic.onSubmit(context);
            },
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.red, fontSize: 17),
            ),
          )
        ],
      );
    }

    void _scaleDialog(
        latitudeField, longitudeField, GlobalKey<FormState> formKey) {
      showGeneralDialog(
        context: context,
        pageBuilder: (ctx, a1, a2) {
          return Container();
        },
        transitionBuilder: (ctx, a1, a2, child) {
          var curve = Curves.easeInOut.transform(a1.value);
          return Transform.scale(
            scale: curve,
            child: _dialog(ctx, latitudeField, longitudeField, formKey),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
    }

    return GetBuilder<LocationListLogic>(
        init: LocationListLogic(),
        builder: (locations) {
          print(locations.locationList);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Locations List'),
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: locations.locationList.length,
                      itemBuilder: (context, i) {
                        print('length ${locations.locationList.length}');
                        return Card(
                          child: ListTile(
                            title: Text(locations.locationList[i]['city']),
                            subtitle: Text(locations.locationList[i]['country']),
                            trailing: const Icon(Icons.delete),
                            onTap: () {
                              showDialog(context: context, builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text("Are you really want to delete?"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: const Text('Cancel')),
                                    TextButton(onPressed: () {}, child: const Text('Yes', style: TextStyle(color: Colors.red),))
                                  ],
                                );
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: ElevatedButton(
                          onPressed: () => _scaleDialog(
                              locations.latitudeFieldController(),
                              locations.longitudeFieldController(),
                              locations.formKey),
                          child: const Text("Add Location"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}