// ignore_for_file: file_names

class UserModel {
  String firstName = '';
  String lastName = '';
  String age = '0';

  UserModel(
      {required this.firstName, required this.lastName, required this.age});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
    };
  }
}
