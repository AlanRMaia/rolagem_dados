import 'package:cloud_firestore/cloud_firestore.dart';

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
      'name': name,
      'imgUrl': imgUrl,
      'admUserId': admUserId,
    };
  }

  RoomModel.fromDocumentSnapsho(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String ?? '';
    imgUrl = doc['imgUrl'] as String ?? '';
    admUserId = doc['admUserId'] as String ?? '';
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as String,
      name: map['name'] as String ?? '',
      imgUrl: map['imgUrl'] as String,
      admUserId: map['admUserId'] as String ?? '',
    );
  }

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

  // String toJson() => json.encode(toMap());

  // factory Room.fromJson(String source) => Room.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, imgUrl: $imgUrl, admUserId: $admUserId)';
  }
}
