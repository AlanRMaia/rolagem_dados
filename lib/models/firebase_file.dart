import 'dart:convert';

import 'package:flutter/cupertino.dart';

class FirebaseFile {
  int byteTotal;
  String name;
  String url;

  FirebaseFile({
    this.byteTotal,
    this.name,
    this.url,
  });

  FirebaseFile copyWith({
    int byteTotal,
    String name,
    String url,
  }) {
    return FirebaseFile(
      byteTotal: byteTotal ?? this.byteTotal,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'byteTotal': byteTotal,
      'name': name,
      'url': url,
    };
  }

  factory FirebaseFile.fromMap(Map<String, dynamic> map) {
    return FirebaseFile(
      byteTotal: map['byteTotal'] as int,
      name: map['name'].toString(),
      url: map['url'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseFile.fromJson(String source) =>
      FirebaseFile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FirebaseFile(byteTotal: $byteTotal, name: $name, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FirebaseFile &&
        other.byteTotal == byteTotal &&
        other.name == name &&
        other.url == url;
  }

  @override
  int get hashCode => byteTotal.hashCode ^ name.hashCode ^ url.hashCode;
}
