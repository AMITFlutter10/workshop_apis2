import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop_apis2/cubits/cubit/main_cubit.dart';
import 'package:workshop_apis2/screens/home_screen.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var email = TextEditingController();
  var pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextFormField(
              controller: pass,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {
                if (state is SuccessLoginState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return state is LoadingLoginState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MaterialButton(
                        onPressed: () {
                          MainCubit.get(context).login(email.text, pass.text);
                        },
                        color: Colors.deepOrange,
                        child: const Text("Login"),
                      );
              },
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
              child: const Text("Create Account"),
            )
          ],
        ),
      ),
    );
  }
}
