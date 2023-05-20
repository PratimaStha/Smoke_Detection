import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths:
                      CustomSliderWidths(trackWidth: 6, progressBarWidth: 13),
                  customColors: CustomSliderColors(
                      trackColor: Color.fromARGB(255, 168, 169, 172),
                      progressBarColor: Color.fromARGB(255, 224, 17, 17),
                      shadowColor: Color.fromARGB(255, 221, 78, 78),
                      shadowMaxOpacity: 20, //);
                      shadowStep: 5),
                  infoProperties: InfoProperties(
                    bottomLabelStyle: TextStyle(
                        // color: Color.fromARGB(255, 251, 0, 0),
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    topLabelText: ' Smoke Level',
                    mainLabelStyle: TextStyle(
                        color: Color(0xff54826D),
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                    //     modifier: (double value) {
                    //       return '${widget.temperature} ˚C';
                    //     }),
                    // startAngle: 90,
                    // angleRange: 360,
                    // size: 200.0,
                    //animationEnabled: true),
                    //   min: 0,
                    //   max: 100,
                    //   initialValue: widget.temperature,
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                  ),
                ),
                initialValue: 60,
                onChange: (double value) {
                  print(value);
                }),
            SizedBox(
              height: 50,
            ),
            SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths:
                      CustomSliderWidths(trackWidth: 6, progressBarWidth: 13),
                  customColors: CustomSliderColors(
                      trackColor: Color.fromARGB(255, 123, 126, 133),
                      progressBarColor: Color.fromARGB(255, 25, 142, 25),
                      shadowColor: Color.fromARGB(255, 118, 215, 178),
                      shadowMaxOpacity: 20, //);
                      shadowStep: 5),
                  infoProperties: InfoProperties(
                    bottomLabelStyle: TextStyle(
                        // color: Color.fromARGB(255, 251, 0, 0),
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
                    topLabelText: ' Gas Level',
                    mainLabelStyle: TextStyle(
                        color: Color(0xff54826D),
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600),
                    //     modifier: (double value) {
                    //       return '${widget.temperature} ˚C';
                    //     }),
                    // startAngle: 90,
                    // angleRange: 360,
                    // size: 200.0,
                    //animationEnabled: true),
                    //   min: 0,
                    //   max: 100,
                    //   initialValue: widget.temperature,
                    // ),
                    // SizedBox(
                    //   height: 50,
                    // ),
                  ),
                ),
                initialValue: 50,
                onChange: (double value) {
                  print(value);
                }),
          ],
        )));
  }
}
