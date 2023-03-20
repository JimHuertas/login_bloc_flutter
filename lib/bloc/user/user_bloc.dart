import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:bloc_flutter_login/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{

  UserBloc() : super(const UserInitialState()){
    on<ActiveUser>((event, emit) {
      return emit(UserSetState(event.user)); 
    });

    on<ChangeUserAge>((event, emit){
      if(!state.existUser) return;
      emit(UserSetState(state.user!.copyWith(number: event.age)));
    });

    on<AddNewProfession>((event, emit){
      if(!state.existUser) return;
      final List<String>newListProfessions = [...state.user!.profesiones, event.newProfesion];
      emit(UserSetState(state.user!.copyWith(profesiones: newListProfessions)));
    });

    on<ValidLogin>((event, emit) async {
      print("${event.email} y ${event.passowrd}");
      final String response = await rootBundle.loadString('data/users.json');
      final data = jsonDecode(response);
      final listUsers = data['users'].map((data)
        => User.fromJson(data)).toList();

      bool existUser = false;
      int idxUser;
      for (idxUser = 0; idxUser < 2; idxUser++) {
        if(event.email == listUsers[idxUser].getEmail() && event.passowrd == listUsers[idxUser].getPassword()) {
            existUser = true;
            emit(const UserLogged(true));
            break;
          }
      }
      if(!existUser) return;

      else if (existUser) {
        emit(UserSetState(listUsers[idxUser]));
      }
    });
  }

}