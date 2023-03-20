import 'package:flutter/material.dart';

class CustomImput extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final TextEditingController? textController;
  final TextInputType keyboardType;

  const CustomImput({
    Key? key, 
    required this.hintText,
    required this.textController,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5
          )
        ]
      ),
      child: TextField(
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: textController,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: hintText
        )
      ),
    );
  }
}