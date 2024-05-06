import 'dart:convert';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {super.id,
      required super.userName,
      required super.name,
      required super.email,
      super.password,
      super.profileImageUrl,
      required super.bio,
      required super.birthDate,
      super.userStatus});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    late final UserStatus getUserStatus;
    switch (map['user_status']) {
      case 'ONLINE':
        getUserStatus = UserStatus.online;
        break;
      case 'OFFLINE':
        getUserStatus = UserStatus.offline;
        break;
      case 'TYPING':
        getUserStatus = UserStatus.typing;
        break;
      default:
        getUserStatus = UserStatus.offline;
    }
    return UserModel(
      id: map['id'],
      userName: map['username'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      profileImageUrl: map['profile_pic'],
      bio: map['bio'],
      birthDate: DateTime.parse(map['date_of_birth']),
      userStatus: getUserStatus,
    );
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    late final String getUserStatus;
    switch (userStatus) {
      case UserStatus.online:
        getUserStatus = 'ONLINE';
        break;
      case UserStatus.offline:
        getUserStatus = 'OFFLINE';
        break;
      case UserStatus.typing:
        getUserStatus = 'TYPING';
        break;
      default:
        getUserStatus = 'OFFLINE';
    }
    return {
      'id': id,
      'username': userName,
      'name': name,
      'email': email,
      'password': password,
      'profile_pic': profileImageUrl,
      'bio': bio,
      'date_of_birth': birthDate.toIso8601String(),
      'user_status': getUserStatus,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.mapToModelFromEntity(UserEntity userEntity) => UserModel(
      id: userEntity.id,
      userName: userEntity.userName,
      name: userEntity.name,
      email: userEntity.email,
      password: userEntity.password,
      profileImageUrl: userEntity.profileImageUrl,
      bio: userEntity.bio,
      birthDate: userEntity.birthDate,
      userStatus: userEntity.userStatus);

  @override
  UserModel copyWith(
      {String? id,
      String? userName,
      String? name,
      String? email,
      String? password,
      String? profileImageUrl,
      String? bio,
      DateTime? birthDate,
      UserStatus? userStatus}) {
    return UserModel(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        email: email ?? this.email,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        password: password ?? this.password,
        bio: bio ?? this.bio,
        birthDate: birthDate ?? this.birthDate,
        userStatus: userStatus ?? this.userStatus);
  }

  @override
  String toString() => toJson();
}

class UserLogInCredModel extends UserLogInCredEntity {
  UserLogInCredModel({required super.email, required super.password});

  factory UserLogInCredModel.mapToModelFromEntity(
          UserLogInCredEntity userLogInCredEntity) =>
      UserLogInCredModel(
          email: userLogInCredEntity.email,
          password: userLogInCredEntity.password);

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };

  String toJson() => jsonEncode(toMap());
}
