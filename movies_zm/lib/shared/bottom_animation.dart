import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BottomAnimation extends StatelessWidget {
  const BottomAnimation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WaveWidget(
          duration: 1,
          config: CustomConfig(
            gradients: const [
             
              [Color(0xFF092c39), Color(0xFF092c39)],
              [Color(0xff224957), Color(0xff224957)],
              [Color(0xFF2bd17e), Color(0xFF2bd17e)],
              [Color(0xff224957), Color(0xff224957)],
            ],
            durations: [35000, 19440, 10800, 6000],
            heightPercentages: [0.20, 0.23, 0.25, 0.30],
            blur: const MaskFilter.blur(BlurStyle.inner, 50),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.bottomRight,
          ),
          waveAmplitude: 1.0,
          backgroundColor: const Color(0xff093545),
          size: const Size(double.infinity, 100.0),
        )
      ],
    );
  }
}
