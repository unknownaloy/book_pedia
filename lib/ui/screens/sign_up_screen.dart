import 'package:book_pedia/bloc/authentication/authentication_bloc.dart';
import 'package:book_pedia/bloc/authentication/authentication_event.dart';
import 'package:book_pedia/bloc/sign_up/sign_up_bloc.dart';
import 'package:book_pedia/bloc/sign_up/sign_up_event.dart';
import 'package:book_pedia/bloc/sign_up/sign_up_state.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:book_pedia/styles/colors.dart';
import 'package:book_pedia/styles/text_field_style.dart';
import 'package:book_pedia/ui/components/button.dart';
import 'package:book_pedia/ui/components/loading_indicator.dart';
import 'package:book_pedia/utilities/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpBloc _signUpBloc;
  final _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    _signUpBloc = SignUpBloc(authService: _authService);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signUpBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _signUpBloc,
          child: BlocConsumer<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
              }

              if (state is SignUpSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const LoadingIndicator();
              }

              return Center(
                child: SingleChildScrollView(
                  child: Padding(
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
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /// Email address
                                TextFormField(
                                  controller: _emailController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: inputDecoration(
                                    AppLocalizations.of(context)!.emailAddress,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  validator: (value) {
                                    return Validators.validateEmail(value);
                                  },
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),

                                /// Password
                                TextFormField(
                                  controller: _passwordController,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: inputDecoration(
                                    AppLocalizations.of(context)!.password,
                                  ).copyWith(
                                      suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _obscurePassword = !_obscurePassword);
                                    },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _obscurePassword
                                          ? kHintColor
                                          : kAccentColor,
                                    ),
                                  )),
                                  autocorrect: true,
                                  obscureText: _obscurePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return Validators.validatePassword(value);
                                  },
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),

                                /// Confirm password
                                TextFormField(
                                  style: Theme.of(context).textTheme.bodyText1,
                                  decoration: inputDecoration(
                                    AppLocalizations.of(context)!.confirmPassword,
                                  ).copyWith(
                                      suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() =>
                                          _obscurePassword = !_obscurePassword);
                                    },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _obscurePassword
                                          ? kHintColor
                                          : kAccentColor,
                                    ),
                                  )),
                                  autocorrect: true,
                                  obscureText: _obscurePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Please enter password";
                                    }

                                    if (value != _passwordController.text) {
                                      return "Password don't match";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 28.0,
                                ),
                                Button(
                                  child: Text(
                                    AppLocalizations.of(context)!.signUp,
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _signUpBloc.add(
                                        SignUpWithEmailPressed(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 24.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .alreadyHaveAnAccount,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),
                                Button(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.google,
                                        color: kTextColor,
                                      ),
                                      const SizedBox(
                                        width: 24.0,
                                      ),
                                      Text(
                                        "Continue with Google",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ],
                                  ),
                                  buttonColor: kBaseColor,
                                  onPressed: () {
                                    _signUpBloc.add(SignUpWithGoogle());
                                  },
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
            },
          ),
        ),
      ),
    );
  }
}
