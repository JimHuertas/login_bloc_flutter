import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_flutter_login/bloc/cutwood_api_bloc/cut_wood_api_bloc.dart';

import '../models/code_number_phone.dart';
import '../widgets/custom_button.dart';
import '../widgets/logo.dart';

class VerificationNumber extends StatefulWidget {
  final String? email;
  final String? password;
  final String? name;
  const VerificationNumber({super.key,
    required this.email,
    required this.name,
    required this.password
  });

  @override
  State<VerificationNumber> createState() => _VerificationNumberState();
}

class _VerificationNumberState extends State<VerificationNumber> {
  bool numberSended = false;
  TextEditingController numberCtrl = TextEditingController(text: '');
  List<CodeNumberPhone>? listCodesNumber;
  

  @override
  Widget build(BuildContext context) {
    final codeBloc = BlocProvider.of<CodeNumberBloc>(context, listen: false);
    codeBloc.add(const DecodeDataFromJsonEvent());
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const Logo(
              titulo: 'Verificación de Número'
            ),
            const SizedBox(height: 40),
            const Text(
              "We need to register your phone without getting started!",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            _numberField(),
            const SizedBox(height: 40),

          ]
        ),
        ),
      ),
    );
  }

  _numberField() {
    return BlocBuilder<CodeNumberBloc, CodeNumberState>(
      builder: (_, state){
        return (!numberSended) 
        ? _rowWidgetForNumber(state)
        : _codeWriter(state);
    });
  }

  _codeWriter(CodeNumberState state){
    TextEditingController code1 = TextEditingController(text: '');
    TextEditingController code2 = TextEditingController(text: '');
    TextEditingController code3 = TextEditingController(text: '');
    TextEditingController code4 = TextEditingController(text: '');
    TextEditingController code5 = TextEditingController(text: '');
    TextEditingController code6 = TextEditingController(text: '');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(width: 20),
            _customContainer(
              controller: code1
            ),
            _customContainer(
              controller: code2
            ),
            _customContainer(
              controller: code3
            ),
            _customContainer(
              controller: code4
            ),
            _customContainer(
              controller: code5
            ),
            _customContainer(
              controller: code6
            ),
            const SizedBox(width: 30),
          ]
        ),
        const SizedBox(height: 40),
        CustomButtom(
          text: 'Confirmar Código',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          onPressed: (){
            String? code = '${code1.text}${code2.text}${code3.text}${code4.text}${code5.text}${code6.text}';
            print(code);
            numberSended = false;
            setState(() {});
          },
        )
      ]
    );
  }

  _customContainer({required TextEditingController? controller}){
    return Container(
      width: 30,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(2)
      ),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder( 
            borderSide: BorderSide(width: 0.0),   
          ), 
          hintText: "1",
          counterText: "",
        ),
        maxLength: 1,
        controller: controller,
      ),
    );
  }

  _rowWidgetForNumber(CodeNumberState state){
    String numberPhone = state.actualValue.substring(5);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
        ),
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(left: 5.0),
              width: 80,
              child: DropdownButton<String>(
                iconSize: 0.0,
                value: state.actualValue,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                onChanged: (String? newValue) {
                  if(newValue != state.actualValue){
                    final codeBloc = BlocProvider.of<CodeNumberBloc>(context, listen: false);
                    codeBloc.add(ChangeActualValue(state.codeNumber, newValue!));
                    numberPhone = state.actualValue.substring(5);
                    print('Actual value: ${state.actualValue}');
                  }
                },
                items: (state.status != CodeNumberStatus.dataCompleted)
                ? []
                : state.codeNumber.map((option) {
                  return DropdownMenuItem<String>(
                    value: '${option.emoji} ${option.dialCode}',
                    child: Text('${option.emoji} ${option.dialCode}'),
                  );
                }).toList(),
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
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder( 
                    borderSide: BorderSide(width: 0.0),   
                  ), 
                  hintText: "999444111",
                  counterText: "",
                ),
                maxLength: 9,
                autocorrect: false,
                autofocus: false,
                controller: numberCtrl,
                keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          CustomButtom(
            text: 'Enviar Código',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            numberCtrl: numberCtrl,
            onPressed: (){
              numberPhone += numberCtrl.text;
              print(numberPhone);
              numberSended = true;
              setState(() {});
            },
          )
        ]
      ),
    );
  }
}