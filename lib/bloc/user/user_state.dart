part of 'user_bloc.dart';

enum UserStatus{UnAuthenticated, Loading, Authenticated}

@immutable
abstract class UserState extends Equatable{
  
  final UserStatus status;
  final User user; 

  const UserState._({
    required this.status,
    this.user = User.empty
  }); 

  const UserState.authenticated(User user) : this._(
    status: UserStatus.Authenticated,
    user: user
  );
  const UserState.unAuthenticated() : this._(status: UserStatus.UnAuthenticated);
  const UserState.loading() : this._(status: UserStatus.Loading);

  @override
  List<Object?> get props => [status, user];
}

class Loading extends UserState{
  const Loading.loading() : super.loading();
 
}

class UnAuthenticated extends UserState{
  const UnAuthenticated.unAuthenticated() : super.unAuthenticated();
}

class Authenticated extends UserState{
  const Authenticated.authenticated(super.user) : super.authenticated();

}
