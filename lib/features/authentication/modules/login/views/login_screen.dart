import 'package:book_pedia/data/repositories/auth_repository_impl.dart';
import 'package:book_pedia/features/authentication/bloc/authentication_bloc.dart';
import 'package:book_pedia/features/authentication/bloc/authentication_event.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/view/forgot_password.dart';
import 'package:book_pedia/features/authentication/modules/login/bloc/login_bloc.dart';
import 'package:book_pedia/features/authentication/modules/login/bloc/login_event.dart';
import 'package:book_pedia/features/authentication/modules/login/bloc/login_state.dart';
import 'package:book_pedia/config/theme/colors.dart';
import 'package:book_pedia/config/theme/text_field_style.dart';
import 'package:book_pedia/reusables/button.dart';
import 'package:book_pedia/reusables/loading_indicator.dart';
import 'package:book_pedia/features/authentication/modules/signup/views/sign_up_screen.dart';
import 'package:book_pedia/utilities/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  final _authService = AuthRepositoryImpl();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(authService: _authService);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (context) => _loginBloc,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
              }

              if (state is LoginSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
              }
            },
            builder: (context, state) {
              if (state is LoginLoading) {
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
                                      AppLocalizations.of(context)!
                                          .emailAddress),
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
                                    AppLocalizations.of(context)!.password,
                                  ).copyWith(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() => _obscurePassword =
                                            !_obscurePassword);
                                      },
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: _obscurePassword
                                            ? kHintColor
                                            : kAccentColor,
                                      ),
                                    ),
                                  ),
                                  autocorrect: true,
                                  obscureText: _obscurePassword,
                                  validator: (value) {
                                    if (value == "" || value == null) {
                                      return "Password is required";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 28.0,
                                ),

                                /// Login button
                                Button(
                                  child: Text(
                                    AppLocalizations.of(context)!.logIn,
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _loginBloc.add(
                                        LoginInWithEmailPressed(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const ForgotPassword(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.forgotPassword,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 24.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            const SignUpScreen(),
                                      ),
                                    );
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      text:
                                          "${AppLocalizations.of(context)!.dontHaveAnAccount} ",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .signUp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.copyWith(color: kAccentColor),
                                        ),
                                      ],
                                    ),
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
                                        "Sign in with Google",
                                        style:
                                            Theme.of(context).textTheme.button,
                                      ),
                                    ],
                                  ),
                                  buttonColor: kBaseColor,
                                  onPressed: () {
                                    _loginBloc.add(
                                      LoginInWithGoogle(),
                                    );
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
