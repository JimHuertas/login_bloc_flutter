part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class ChangeUserNumber extends UserEvent{
  final int age;
  const ChangeUserNumber(this.age );
}

class SingInRequest extends UserEvent{
  final String email;
  final String password;

  const SingInRequest(this.email, this.password);
}

class SingUpRequest extends UserEvent{
  final String email;
  final String name;
  final String password;
  final String number;

  const SingUpRequest(this.email, this.password, this.number, this.name);
}

class LogOutRequest extends UserEvent{}