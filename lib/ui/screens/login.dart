import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/styles/text_field_style.dart';
import 'package:book_pedia/ui/components/button.dart';
import 'package:book_pedia/utilities/validators.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                AppLocalizations.of(context)!.logIn,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 24.0,
              ),

              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: inputDecoration(
                            AppLocalizations.of(context)!.emailAddress),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (value) {
                          return Validators.validateEmail(value);
                        },
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: inputDecoration(
                                AppLocalizations.of(context)!.password)
                            .copyWith(
                                suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                                () => _obscurePassword = !_obscurePassword);
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: _obscurePassword ? kHintColor : kAccentColor,
                          ),
                        )),
                        autocorrect: true,
                        obscureText: _obscurePassword,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return Validators.validatePassword(value);
                        },
                      ),
                      const SizedBox(
                        height: 28.0,
                      ),
                      Button(
                        buttonText: AppLocalizations.of(context)!.logIn,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("Form is valid proceed to create account");
                          }
                        },
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RichText(
                          text: TextSpan(
                            text:
                                "${AppLocalizations.of(context)!.dontHaveAnAccount} ",
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
            ],
          ),
        ),
      ),
    );
  }
}
