import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String image;
  String phone;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
  });

  UserModel.fromDocumentSnapsho(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String ?? '';
    email = doc['email'] as String ?? '';
    image = doc['image'] as String ?? '';
    phone = doc['phone'] as String ?? '';
  }

  // Map<String, dynamic> toJson(){
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['name'] = this.name;
  // return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String ?? '',
      name: map['name'] as String ?? '',
      email: map['email'] as String ?? '',
      image: map['image'] as String ?? '',
      phone: map['phone'] as String ?? '',
    );
  }

  UserModel copyWith({
    String id,
    String name,
    String email,
    String image,
    String phone,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      phone: phone ?? this.phone,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, image: $image, phone: $phone)';
  }
}
