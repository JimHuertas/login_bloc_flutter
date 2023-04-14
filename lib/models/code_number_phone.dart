///Created to read data: code_number.json and convert it to a class, just calling the method .from_json
class CodeNumberPhone{
  String name;
  String dialCode;
  String emoji;
  String code;

  CodeNumberPhone({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.emoji
  });

  factory CodeNumberPhone.fromJson(Map<String, dynamic> json){
    return CodeNumberPhone(
      name: json['name'] ?? json['name'],
      code: json['code'] ?? json['code'],
      dialCode: json['dial_code'] ?? json['dial_code'],
      emoji: json['emoji'] ?? json['emoji'],
    );
  }
}