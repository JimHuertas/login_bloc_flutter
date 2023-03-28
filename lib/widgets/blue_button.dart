import 'package:flutter/material.dart';


class BlueButton extends StatelessWidget {
  
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController? nameCtrl;
  final TextEditingController? numberCtrl;
  final String text;
  final Function()? onPressed;

  const BlueButton({
    required this.emailCtrl,
    required this.passwordCtrl,
    this.nameCtrl,
    this.numberCtrl,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: const Color.fromRGBO(187, 244, 155, 1),
        shape: const StadiumBorder()
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: 300,
        height: 55,
        child: Center(
          child: Text(text, style: const TextStyle(
            color: Colors.black54,
            fontSize: 17,
          ))
        )
      )
    );
  }
}