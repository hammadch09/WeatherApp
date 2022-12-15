import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'header_logic.dart';

class HeaderView extends StatelessWidget {
  final String city;
  const HeaderView({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HeaderLogic>(
        init: HeaderLogic(),
        builder: (header) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  city,
                  style: const TextStyle(fontSize: 35, height: 2),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  header.date,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[700], height: 1.5),
                ),
              )
            ],
          );
        });
  }
}
