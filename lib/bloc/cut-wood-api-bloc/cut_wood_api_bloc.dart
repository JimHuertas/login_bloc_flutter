import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_login/models/rectangles.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'cut_wood_api_event.dart';
part 'cut_wood_api_state.dart';

class CutWoodApiBloc extends Bloc<CutWoodApiEvent, CutWoodApiState> {
  CutWoodApiBloc() : super(const Offline.offline()) {
    on<SendDataToAPI>((event, emit) async {
      final response = http.post(
        Uri.parse('localhost:3000/api/cutwood/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(event.cutsToSend.toJson()),
      );
      // print(response);
      response;
    });

    on<UpdateListCuts>((event, emit){
      emit(const Loading.loading());
      emit(DataReaded.dataReaded(event.newCut));
    });

  }
}
