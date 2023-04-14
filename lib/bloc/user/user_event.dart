part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable{
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class _VerificationNumberPhone extends UserEvent{
  final String smsCode;
  final String numberPhone;
  const _VerificationNumberPhone(this.numberPhone, this.smsCode);
}

class SingInRequest extends UserEvent{
  final String email;
  final String password;

  const SingInRequest(this.email, this.password);
}

class SinupFormDates extends UserEvent{
  final String email;
  final String name;
  final String password;
  final String number;

  SinupFormDates(this.email, this.name, this.password, this.number);
}

class SingUpRequest extends UserEvent{
  final String email;
  final String name;
  final String password;
  final String number;

  const SingUpRequest(this.email, this.password, this.number, this.name);
}

class LogOutRequest extends UserEvent{}