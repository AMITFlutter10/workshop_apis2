import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cubit/main_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var email = TextEditingController();
  var pass = TextEditingController();
  var name = TextEditingController();
  var mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
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
              controller: name,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextFormField(
              controller: mobile,
              decoration: const InputDecoration(labelText: "Mobile"),
            ),
            TextFormField(
              controller: pass,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {
                if (state is SuccessRegisterState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is LoadingRegisterState
                    ? const Center(child: CircularProgressIndicator())
                    : MaterialButton(
                        onPressed: () {
                          MainCubit.get(context).register(
                              email.text, name.text, mobile.text, pass.text);
                        },
                        color: Colors.deepOrange,
                        child: const Text("Create Account"),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
