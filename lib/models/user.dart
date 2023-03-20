

class User {
  
  String nombre;
  String password;
  String email;
  int number;
  List<String> profesiones;

  User({ 
    required this.nombre,
    required this.email,
    required this.password, 
    required this.number, 
    required this.profesiones 
  });

  User copyWith({
    String? nombre,
    String? password,
    String? email,
    int? number,
    List<String>? profesiones,
  }) => User(
    nombre: nombre ?? this.nombre,
    email: email ?? this.email,
    password: password ?? this.password,
    number: number ?? this.number,
    profesiones: profesiones ?? this.profesiones
  );

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      nombre: json['name'],
      number: json['number'],
      password: json['password'],
      email: json['email'],
      profesiones: []
    );
  }

  String getEmail() => email;
  String getPassword() => password; 

}