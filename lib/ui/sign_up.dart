import 'package:book_pedia/components/custom_text_field.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create an account",
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(hintText: "Email Address", controller: _emailController,),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(hintText: "Password", controller: _passwordController, isObscure: true,),
              const SizedBox(
                height: 28.0,
              ),
              TextButton(
                child: Text(
                  "Create an Account",
                  style: Theme.of(context).textTheme.button,
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(
                    const Size.fromHeight(56.0),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kActionColor),
                ),
                onPressed: () {
                  // Handle sign up logic here
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () {
                  //Handle tap gesture
                },
                child: Text(
                  "Already have an account?",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
