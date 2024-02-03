import 'package:flutter/material.dart';
import 'package:toolbox_frontend/services/http.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Raina's Cool Toolbox"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => print("menu pressed"),
          icon: const Icon(Icons.menu_open),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(123123123);
            },
            child: Text("pop"),
          )
        ],
      ),
      body: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isCreating = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Card(
          elevation: 8,
          child: SizedBox(
            width: 400,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.lock,
                    size: 80,
                  ),
                  const SizedBox(height: 20),
                  LoginField(
                      password: false,
                      controller: _username,
                      label: "Username"),
                  const SizedBox(height: 20),
                  LoginField(
                      password: true,
                      controller: _password,
                      validator: validatePassword,
                      label: "Password"),
                  const SizedBox(height: 20),
                  if (_isCreating)
                    LoginField(
                        password: true,
                        controller: _confirm,
                        validator: _passwordChecker,
                        label: "Confirm Password"),
                  TextButton(
                    child: Text(
                      _isCreating ? "use existing account" : "create account",
                    ),
                    onPressed: () {
                      setState(() {
                        _isCreating = !_isCreating;
                      });
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      _isCreating ? "Create" : "Login",
                      style: const TextStyle(
                          fontSize: 18, letterSpacing: 2, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final formState = _formKey.currentState!;
    final valid = formState.validate();
    if (valid) {
      if (_isCreating) {
        print("SENDING CREATE REQUEST");
        final token =
            await HttpService().createUser(_username.text, _password.text);
        print("got a token: $token");
      } else {
        print("SENDING LOGIN REQUEST");
        final token = await HttpService().login(_username.text, _password.text);
        print("got a token: $token");
      }
    } else {
      print("the form had errors");
    }
  }

  String? _passwordChecker(String? text) {
    if (text == null) return null;
    if (text != _password.text) return "Password must be identical";
    return null;
  }
}

class LoginField extends StatelessWidget {
  final bool password;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;

  const LoginField({
    super.key,
    required this.password,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: password,
      keyboardType: password ? TextInputType.text : TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

String? validatePassword(String? text) {
  if (text == null) return null;
  if (text.length < 8) return "Password must be at least 8 characters";
  return null;
}
