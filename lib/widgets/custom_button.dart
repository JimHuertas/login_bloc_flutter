import 'package:flutter/material.dart';


class CustomButtom extends StatelessWidget {
  
  final TextEditingController? emailCtrl;
  final TextEditingController? passwordCtrl;
  final TextEditingController? nameCtrl;
  final TextEditingController? numberCtrl;
  final String text;
  final Color? backgroundColor;
  final Color? colorText;
  final Function()? onPressed;

  const CustomButtom({super.key, 
    this.colorText = Colors.black54,
    this.emailCtrl,
    this.passwordCtrl,
    this.nameCtrl,
    this.numberCtrl,
    this.backgroundColor = Colors.blue,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: backgroundColor,
        shape: const StadiumBorder()
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: 300,
        height: 55,
        child: Center(
          child: Text(text, style: TextStyle(
            color: colorText,
            fontSize: 17,
          ))
        )
      )
    );
  }
}