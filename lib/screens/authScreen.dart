import 'package:chat/viewModel/AuthViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<AuthViewModel>.reactive(
        viewModelBuilder: () => AuthViewModel(),
        builder: (context, AuthViewModel viewModel, child) => Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: "Enter Email"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: password,
                    decoration: InputDecoration(hintText: "Enter Password"),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  if (viewModel.err != null) ...[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      viewModel.err!,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                  viewModel.isLoading
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  viewModel.signInWithEmailAndPassword(
                                      email.text, password.text);
                                },
                                child: Text("Sign In")),
                            SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  viewModel.signUpWithEmailAndPassword(
                                      email.text, password.text);
                                },
                                child: Text("Sing Up"))
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
