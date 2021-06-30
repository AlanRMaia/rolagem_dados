import 'dart:convert';

import 'package:rolagem_dados/models/user.dart';

class RoomModel {
  String id;
  String name;
  String imgUrl;
  String admUserId;

  RoomModel({
    this.id,
    this.name,
    this.imgUrl,
    this.admUserId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'admUserId': admUserId,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      imgUrl: map['imgUrl'].toString(),
      admUserId: map['admUserId'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  // factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source));

  RoomModel copyWith({
    String id,
    String name,
    String imgUrl,
    String admUserId,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      admUserId: admUserId ?? this.admUserId,
    );
  }

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, imgUrl: $imgUrl, admUserId: $admUserId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.name == name &&
        other.imgUrl == imgUrl &&
        other.admUserId == admUserId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ imgUrl.hashCode ^ admUserId.hashCode;
  }
}
