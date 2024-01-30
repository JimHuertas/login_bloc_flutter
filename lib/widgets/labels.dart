import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String text;
  final String textLinked;

  const Labels({
    Key? key, 
    required this.route,
    required this.text,
    required this.textLinked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(text, 
          style: const TextStyle(
            color: Colors.black54, 
            fontSize: 15, 
            fontWeight: FontWeight.w300)
        ),
        const SizedBox(height: 10),
        GestureDetector(
          child: Text(textLinked, 
            style: const TextStyle(
              color: Color.fromRGBO(122, 189, 84, 1),//Colors.blue[600],
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          ),
          onTap: (){
            Navigator.pushReplacementNamed(context, route);
            print('tap');
          },
        )
      ],
    );
  }
}