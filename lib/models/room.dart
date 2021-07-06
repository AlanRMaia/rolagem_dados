import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:rolagem_dados/models/user.dart';

class RoomModel {
  String id;
  String name;
  String imgUrl;
  String admUserId;
  UserModel admin;
  List<UserModel> usuarios;

  RoomModel({
    this.id,
    this.name,
    this.imgUrl,
    this.admUserId,
    this.admin,
    this.usuarios,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'admUserId': admUserId,
      'admin': admin.toMap(),
      'usuarios': usuarios?.map((x) => x.toMap())?.toList(),
    };
  }

  RoomModel.fromDocumentSnapsho(DocumentSnapshot doc) {
    id = doc['id'].toString() ?? '';
    name = doc['name'].toString() ?? '';
    imgUrl = doc['imgUrl'].toString() ?? '';
    admUserId = doc['admUserId'].toString() ?? '';
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      imgUrl: map['imgUrl'].toString(),
      admUserId: map['admUserId'].toString(),
      admin: UserModel?.fromMap(map['admin'] as Map<String, dynamic>),
      usuarios: List<UserModel>.from(
          (map['usuarios'] as List<Map<String, dynamic>>)
              .map((x) => UserModel.fromMap(x))).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source));

  RoomModel copyWith({
    String id,
    String name,
    String imgUrl,
    String admUserId,
    UserModel admin,
    List<UserModel> usuarios,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      admUserId: admUserId ?? this.admUserId,
      admin: admin ?? this.admin,
      usuarios: usuarios ?? this.usuarios,
    );
  }

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, imgUrl: $imgUrl, admUserId: $admUserId, admin: $admin, usuarios: $usuarios)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.admUserId == admUserId &&
        other.admin == admin &&
        listEquals(other.usuarios, usuarios);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        imgUrl.hashCode ^
        admUserId.hashCode ^
        admin.hashCode ^
        usuarios.hashCode;
  }

  // factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source));
}
