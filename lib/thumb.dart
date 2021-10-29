import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikart_flutter_app/common/color_palette.dart';
import 'package:trikart_flutter_app/common/font_style.dart';
import 'package:trikart_flutter_app/generated/l10n.dart';
import 'package:trikart_flutter_app/utilities/hex_color.dart';

class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final RangeValues rangeValues;
  final Function onChange;
  const CustomSlider(
      {Key? key,
      required this.maxValue,
      required this.rangeValues,
      required this.minValue,
      required this.onChange})
      : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    _currentRangeValues = widget.rangeValues;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${S.of(context).min}.',
              style: FontStyle.black12Normal,
            ),
            const Spacer(),
            Text(
              '${S.of(context).max}.',
              style: FontStyle.black12Normal,
            ),
          ],
        ),
        SizedBox(
          height: 11.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ColorPalette.primaryColor,
              inactiveTrackColor: HexColor('#E5E5E5'),
              trackHeight: 2.h,
              thumbColor: ColorPalette.primaryColor,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
              rangeThumbShape: CircleThumbShape(thumbRadius: 12.w),
            ),
            child: RangeSlider(
              values: _currentRangeValues,
              min: widget.minValue,
              max: widget.maxValue,
              divisions: 10,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
                widget.onChange(values.start, values.end);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CircleThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      bool? isDiscrete,
      bool? isEnabled,
      bool? isOnTop,
      bool? isPressed,
      required SliderThemeData sliderTheme,
      TextDirection? textDirection,
      Thumb? thumb}) {
    final Canvas canvas = context.canvas;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = sliderTheme.thumbColor!
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, thumbRadius, fillPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}
