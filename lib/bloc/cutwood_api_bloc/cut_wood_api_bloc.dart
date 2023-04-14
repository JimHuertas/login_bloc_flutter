import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_login/models/code_number_phone.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'cut_wood_api_event.dart';
part 'cut_wood_api_state.dart';

class CodeNumberBloc extends Bloc<CodeNumberEvent, CodeNumberState>{
  CodeNumberBloc() : super((const Loading.loading())){
    on<DecodeDataFromJsonEvent>((event, emit) async {
      final jsonStr = await rootBundle.loadString('data/code_numbers.json');
      final optionsJson = json.decode(jsonStr);
      final optionsList = (optionsJson as List).map((o) 
      => CodeNumberPhone(
        name: o['name'],
        dialCode: o['dial_code'],
        code: o['code'],
        emoji: o['emoji']
      )).toList();

      if(optionsList != []) {
        emit(DataCompleted.dataCompleted(optionsList, '${optionsList[0].emoji} ${optionsList[0].dialCode}'));
      }
    });

    on<ChangeActualValue>((event, emit){
      emit(const Loading.loading());
      emit(DataCompleted.dataCompleted(event.newList, event.newValue));
    });
  }

  
}
