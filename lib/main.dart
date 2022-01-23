import 'package:book_pedia/features/authentication/bloc/authentication_bloc.dart';
import 'package:book_pedia/features/authentication/bloc/authentication_event.dart';
import 'package:book_pedia/features/authentication/bloc/authentication_state.dart';
import 'package:book_pedia/l10n/l10n.dart';
import 'package:book_pedia/features/authentication/services/auth_service.dart';
import 'package:book_pedia/config/theme/light_theme.dart';
import 'package:book_pedia/features/home/views/home_screen.dart';
import 'package:book_pedia/features/authentication/modules/login/views/login_screen.dart';
import 'package:book_pedia/common/views/splash_screen.dart';
import 'package:book_pedia/locator_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
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

            if (state is Unauthenticated) {
              return const LoginScreen();
            }

            return const HomeScreen();
          },
        ),
      ),
    );
  }
}
