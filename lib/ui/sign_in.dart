import 'package:book_pedia/styles/colors.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

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
              const TextField(
                decoration: InputDecoration(
                  focusColor: kActionColor,
                  hintText: "Email Address",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kActionColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kActionColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
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
