import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/auth_controller.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/screens/signup.dart';

class Login extends GetWidget<AuthController> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(        
        child: Padding(          
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(            
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    // hintText: 'Email',
                    labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  controller.login(emailController.text, passwordController.text);
                },
                child: const Text('Log In'),
              ),
              FlatButton(
                onPressed: () {
                  Get.to(SignUp());
                },
                child: const Text('Sign up'), 
              )
            ],
          ),
        ),
      ),
    );
  }
}
