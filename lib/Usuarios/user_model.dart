class UserModel {
  final String userName;
  final String email;
  final String phone;

  UserModel({required this.userName, required this.email, required this.phone});

  // Método para crear un usuario desde un mapa
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userName: map['userName'],
      email: map['email'],
      phone: map['phone'],
    );
  }

  // Método para convertir un usuario a un mapa
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
    };
  }
}
