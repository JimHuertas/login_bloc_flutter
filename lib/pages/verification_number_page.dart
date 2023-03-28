import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/logo.dart';

class CodeNumberPhone{
  String name;
  String dialCode;
  String emoji;
  String code;

  CodeNumberPhone({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.emoji
  });

  factory CodeNumberPhone.fromJson(Map<String, dynamic> json){
    return CodeNumberPhone(
      name: json['name'] ?? json['name'],
      code: json['code'] ?? json['code'],
      dialCode: json['dial_code'] ?? json['dial_code'],
      emoji: json['emoji'] ?? json['emoji'],
    );
  }
}

Future<List<dynamic>> _readJsonNumberCode() async {
  final String response = await rootBundle.loadString('data/code_numbers.json');
  final data = await json.decode(response);
  final listUsers = data.map((data)
        => CodeNumberPhone.fromJson(data)).toList();
  return data;
}

class VerificationNumber extends StatefulWidget {
  const VerificationNumber({super.key});

  @override
  State<VerificationNumber> createState() => _VerificationNumberState();
}

class _VerificationNumberState extends State<VerificationNumber> {
  bool numero_enviado = false;
  TextEditingController? numberCtrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Logo(
                titulo: 'Verificación de Número',
              ),
              const SizedBox(height: 40),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: _numberField(),
              )
            ]
            
          ),
        ),
      ),
    );
  }

  _numberField() {
    String _actualCode = '+93';
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: FutureBuilder(
            future: _readJsonNumberCode(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                var data = snapshot.data!;
                return DropdownButton(
                  value: _actualCode,
                  items: data.map((value) {
                      return DropdownMenuItem(
                        value: value['dial_code'],
                        child: Text('${value['emoji']} ${value['code']} ${value['dial_code']} '),
                      );
                    },).toList(),
                  onChanged: (value) =>
                    setState(() {
                      print(value.toString());
                      _actualCode = value.toString();
                    }),
                  
                  hint: const Text('+51'),
                  icon: const Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                  iconSize: 0.0,
                  menuMaxHeight: 300,
                );
              } else {
                  return const CircularProgressIndicator();
              }
            }
          )
        ),
        const Text("|",
          style: TextStyle(fontSize: 33, color: Colors.grey),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: (MediaQuery.of(context).size.width < 400) 
              ? 180
              : MediaQuery.of(context).size.width - 500,
          child: TextField(
            controller: numberCtrl,
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}