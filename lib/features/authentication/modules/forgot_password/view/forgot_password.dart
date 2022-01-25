import 'package:book_pedia/config/theme/text_field_style.dart';
import 'package:book_pedia/data/repositories/auth_repository_impl.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/bloc/forgot_password_event.dart';
import 'package:book_pedia/features/authentication/modules/forgot_password/bloc/forgot_password_state.dart';
import 'package:book_pedia/reusables/button.dart';
import 'package:book_pedia/reusables/loading_indicator.dart';
import 'package:book_pedia/utilities/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final ForgotPasswordBloc _forgotPasswordBloc;
  final _authService = AuthRepositoryImpl();

  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _forgotPasswordBloc = ForgotPasswordBloc(_authService);
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocProvider(
                create: (context) => _forgotPasswordBloc,
                child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    // Handle listener here ->
                    if (state is ForgotPasswordFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                    }

                    if (state is ForgotPasswordSuccess) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text("Check your email address"),
                          ),
                        );
                      Navigator.pop(context);
                    }

                  },
                  builder: (context, state) {

                    if (state is ForgotPasswordLoading) {
                      return const LoadingIndicator();
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Forgot Password",
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
                                      "Enter account email address"),
                                  keyboardType: TextInputType.emailAddress,
                                  autocorrect: false,
                                  validator: (value) {
                                    return Validators.validateEmail(value);
                                  },
                                ),
                                const SizedBox(
                                  height: 48.0,
                                ),

                                /// Login button
                                Button(
                                  child: Text(
                                    "Reset Password",
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      // Add bloc event here
                                      _forgotPasswordBloc.add(
                                        SubmitEmailForReset(
                                          _emailController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
