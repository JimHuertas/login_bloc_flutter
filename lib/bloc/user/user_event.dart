part of 'user_bloc.dart';

@immutable
abstract class UserEvent{}

class ActiveUser extends UserEvent {
  final User user;
  ActiveUser(this.user);
}

class ChangeUserNumber extends UserEvent{
  final int age;
  ChangeUserNumber(this.age );
}

class AddNewProfession extends UserEvent{
  final String newProfesion;
  AddNewProfession(this.newProfesion);
}

class ValidLogin extends UserEvent{
  final String email;
  final String passowrd;
  ValidLogin(this.email, this.passowrd);
}