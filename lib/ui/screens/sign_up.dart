import 'package:book_pedia/components/button.dart';
import 'package:book_pedia/components/custom_text_field.dart';
import 'package:book_pedia/ui/screens/sign_in.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() { });
  }

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
                AppLocalizations.of(context)!.createAnAccount,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextField(
                hintText: AppLocalizations.of(context)!.password,
                controller: _passwordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 28.0,
              ),
              Button(
                buttonText: AppLocalizations.of(context)!.createAnAccount,
                onPressed: () {},
              ),
              const SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () {
                  //Handle tap gesture
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const SignIn(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.alreadyHaveAnAccount,
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
