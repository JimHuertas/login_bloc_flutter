import 'dart:async';

import 'package:bloc_flutter_login/models/user_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_flutter_login/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as FBAuth;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final AuthRepository _authRepository;

  UserBloc({required AuthRepository authRepository}) 
    : _authRepository = authRepository, 
    super( (authRepository.currentUser.isNotEmpty)
      ? Authenticated.authenticated(authRepository.currentUser)
      : const UnAuthenticated.unAuthenticated()){


    on<SingInRequest>((event, emit) async {
      emit(const Loading.loading());
      try {
        await authRepository.logIn(email: event.email, password: event.password);
        // emit(Authenticated.authenticated(state.user));
        emit(Authenticated.authenticated(authRepository.currentUser));
        FBAuth.FirebaseAuth.instance
          .authStateChanges()
          .listen((FBAuth.User? user) {
            if (user != null) {
              print(user.isAnonymous);
            }
          });
        
        print(state.status.toString());
      } catch (e) {
        const UnAuthenticated.unAuthenticated();
        print(state.status.toString());
      }
      
    });

    on<SingUpRequest>((event, emit) async {
      emit(const Loading.loading());
      try {
        await authRepository.singUp(email: event.email, password: event.password, name: event.name, number: event.number); 
        emit(Authenticated.authenticated(authRepository.currentUser));
      } catch (e) {
        const UnAuthenticated.unAuthenticated();
        print(state.status.toString());
      }
    }); 

    on<LogOutRequest>((event, emit){
      unawaited(_authRepository.logOut());
      print(state.status.toString());
    });

    // on<ChangeUserNumber>((event, emit){
    //   if(!state.existUser) return;
    //   emit(UserSetState(state.user!.copyWith(number: event.age)));
    // });

    // on<AddNewProfession>((event, emit){
    //   if(!state.existUser) return;
    //   final List<String>newListProfessions = [...state.user!.profesiones, event.newProfesion];
    //   emit(UserSetState(state.user!.copyWith(profesiones: newListProfessions)));
    // });

    // on<ValidLogin>((event, emit) async {
    //   print("${event.email} y ${event.passowrd}");
    //   final String response = await rootBundle.loadString('data/users.json');
    //   final data = jsonDecode(response);
    //   final listUsers = data['users'].map((data)
    //     => User.fromJson(data)).toList();

    //   bool existUser = false;
    //   int idxUser;
    //   for (idxUser = 0; idxUser < 2; idxUser++) {
    //     if(event.email == listUsers[idxUser].getEmail() && event.passowrd == listUsers[idxUser].getPassword()) {
    //         existUser = true;
    //         break;
    //       }
    //   }

    //   Future.delayed(const Duration(seconds: 3));

    //   if(!existUser) return;
    //   else if (existUser) {
    //     emit(UserSetState(listUsers[idxUser]));
    //   }
    // });
  }
}