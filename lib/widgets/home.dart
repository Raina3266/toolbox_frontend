import 'package:flutter/material.dart';
import 'package:toolbox_frontend/widgets/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () async {
            final result = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: Icon(Icons.alarm),
                title: Text("are you sure????"),
                content: Text("are you really really sure???"),
                actions: [
                  TextButton(onPressed: () {}, child: Text("Yes")),
                  TextButton(onPressed: () {}, child: Text("No")),
                ],
              ),
            );
            // final result = await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => const LoginPage(),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
