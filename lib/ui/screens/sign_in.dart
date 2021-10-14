import 'package:book_pedia/components/button.dart';
import 'package:book_pedia/components/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.logIn,
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
                buttonText: AppLocalizations.of(context)!.logIn,
                onPressed: () {},
              ),
              const SizedBox(
                height: 24.0,
              ),
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: TextSpan(
                    text: "${AppLocalizations.of(context)!.dontHaveAnAccount} ",
                    style: Theme.of(context).textTheme.bodyText2,
                    children: [
                      TextSpan(
                        text: AppLocalizations.of(context)!.signUp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
