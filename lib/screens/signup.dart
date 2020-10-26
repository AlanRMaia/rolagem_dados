import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/bindings/auth_binding.dart';

class SignUp extends GetWidget<AuthController> {  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Center(        
        child: Padding(        
          padding: const EdgeInsets.all(20),
          child: Column(              
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[  
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    // hintText: 'Email',
                    labelText: 'Nome'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    // hintText: 'Email',
                    labelText: 'Email'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: FlatButton(
                  onPressed: () {
                    controller.createUser(nameController.text, emailController.text, passwordController.text);
                  },
                  child: const Text('Sign up'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
