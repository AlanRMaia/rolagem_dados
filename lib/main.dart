import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/bindings/auth_binding.dart';
import 'utils/root.dart';

void main() {
  runApp(MyApp());

  // Firestore.instance.collection('teste').add(
  //   {'teste': 'teste'},
  // ); //cria coleção(pasta) o add adiciona o map dentro do parênteses
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Root(),
    );
  }
}
