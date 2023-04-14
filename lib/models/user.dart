import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String? nombre;
  final String? photo;
  final String? email;
  final String? number;

  const User({ 
    required this.id,
    this.nombre,
    this.email,
    this.photo, 
    this.number, 
  });

  static const empty = User(id: '');

  User copyWith({
    String? id,
    String? nombre,
    String? photo,
    String? email,
    String? number,
  }) => User(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    email: email ?? this.email,
    photo: photo ?? this.photo,
    number: number ?? this.number,
  );

  // factory User.fromJson(Map<String, dynamic> json){
  //   return User(
  //     nombre: json['name'],
  //     number: json['number'],
  //     password: json['password'],
  //     email: json['email'],
  //     profesiones: []
  //   );
  // }

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
  

  @override
  List<Object?> get props => [id, nombre, email, photo, number];

}