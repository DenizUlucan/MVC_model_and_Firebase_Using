import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double radius;
  final double? height;
  final Widget? buttonIcon;
  final VoidCallback? onPressed;
  const SocialLoginButton(
      {Key? key,
      this.buttonText,
      this.buttonColor,
      this.buttonIcon,
      this.height,
      this.onPressed,
      this.radius = 12,
      this.textColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
            backgroundColor: MaterialStateProperty.all(buttonColor)),
        child: Text(
          buttonText ?? "Text Gir",
          style: TextStyle(color: textColor),
        ));
  }
}
