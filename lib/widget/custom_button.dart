import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function()? onTap;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final String title;
  final TextStyle titleStyle;

  const CustomButton(
      {Key? key,
      required this.onTap,
      this.buttonColor,
      this.width,
      this.height,
      required this.title,
      required this.titleStyle})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 56,
        child: ElevatedButton(
          child: Text(
            widget.title,
            style: widget.titleStyle,
          ),
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.buttonColor ?? const Color.fromRGBO(255, 18, 101, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
        ));
  }
}
