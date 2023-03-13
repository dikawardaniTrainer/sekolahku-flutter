import 'package:flutter/material.dart';
import 'package:sekolah_ku/widgets/input.dart';

class SampleTextFormFieldPage extends StatelessWidget {
  const SampleTextFormFieldPage({super.key});

  String? _validateEmail(String? email) {
    if (email != null) {
      if (email.isEmpty) {
        return "email cannot be empty";
      }
      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (!emailValid) {
        return "Invalid email address";
      }
    }
    return null;
  }


  String? _validatePassword(String? password) {
    if (password != null) {
      if (password.isEmpty) {
        return "Password cannot be empty";
      }
      if (password.length < 6) {
        return "Password must be 6 character or more";
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample TextFormField"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(label: Text("Email in here")),
                    validator: (x) { return _validateEmail(x); },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      keyboardType: TextInputType.text,
                      validator: (x) { return _validatePassword(x); },
                      decoration: const InputDecoration(
                        label: Text(
                          "Password",
                          style: TextStyle(color: Colors.red),
                        ),
                        border: OutlineInputBorder(),
                      )
                  ),
                  InputField(
                    textInputType: TextInputType.text,
                    label: "Password on custom widget",
                    marginTop: 16,
                    validator: (x) {
                      return _validatePassword(x);
                    },
                  ),
                  InputField(
                    textInputType: TextInputType.text,
                    label: "Password on custom widget",
                    marginTop: 16,
                    validator: (x) {
                      return _validatePassword(x);
                    },
                  ),
                ],
              ),
            )
        ),
      )
    );
  }
}
