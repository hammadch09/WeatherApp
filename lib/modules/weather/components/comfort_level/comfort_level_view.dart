import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../../../utils/utils.dart';
import '../current/current_model.dart';


class ComfortLevelView extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComfortLevelView({
    super.key,
    required this.weatherDataCurrent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 1,
            left: 20,
            bottom: 20,
            right: 20,
          ),
          child: const Text(
            'Comfort level',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                      handlerSize: 0,
                      trackWidth: 12,
                      progressBarWidth: 12,
                    ),
                    infoProperties: InfoProperties(
                      bottomLabelText: 'Humidity',
                      bottomLabelStyle: const TextStyle(
                        letterSpacing: 0.1,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                        hideShadow: true,
                        trackColor: Clr.firstGradientCotor.withAlpha(100),
                        progressBarColors: [
                          Clr.firstGradientCotor,
                          Clr.secondGradientCotor,
                        ]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Feels Like ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: Clr.textCotorBtack,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                        TextSpan(
                            text: ' ${weatherDataCurrent.current.feelsLike}',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: Clr.textCotorBtack,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                      ]
                  ),
                  ),
                  Container(
                    height: 25,
                    margin: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    width: 1,
                    color: Clr.dividerLine,
                  ),
                  RichText(text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Uv Index ',
                            style: TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: Clr.textCotorBtack,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                        TextSpan(
                            text: ' ${weatherDataCurrent.current.uvIndex}',
                            style: const TextStyle(
                              fontSize: 14,
                              height: 0.8,
                              color: Clr.textCotorBtack,
                              fontWeight: FontWeight.w400,
                            )
                        ),
                      ]
                  ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
