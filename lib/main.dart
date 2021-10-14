import 'package:book_pedia/bloc/authentication/authentication_bloc.dart';
import 'package:book_pedia/bloc/authentication/authentication_event.dart';
import 'package:book_pedia/bloc/authentication/authentication_state.dart';
import 'package:book_pedia/l10n/l10n.dart';
import 'package:book_pedia/services/auth_service.dart';
import 'package:book_pedia/styles/light_theme.dart';
import 'package:book_pedia/ui/screens/home_screen.dart';
import 'package:book_pedia/ui/screens/login.dart';
import 'package:book_pedia/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();
  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();

    _authenticationBloc = AuthenticationBloc(authService: _authService);
    _authenticationBloc.add(AppStarted());
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: L10n.all,
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        title: 'Book Pedia',
        theme: lightTheme(),
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (context, state) {
            if (state is Uninitialized) {
              return const SplashScreen();
            }

            if (state is Authenticated) {
              return const HomeScreen();
            }

            return const Login();

            return Container(
              color: Colors.green,
            );
          },
        ),
      ),
    );
  }
}
