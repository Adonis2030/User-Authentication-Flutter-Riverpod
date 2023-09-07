import 'package:flutter/material.dart';
import 'package:user_authentication/components/indicator.dart';
import 'package:user_authentication/constants/constants.dart';
import 'package:user_authentication/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_authentication/screens/welcome_screen.dart';
import 'package:user_authentication/provider/auth_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider).status;
  return authState == AuthStatus.authenticated;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const String welcomeRoute = '/welcome';
  static const String loginRoute = '/login';

  Route<dynamic> _generateRoute(RouteSettings settings, bool isAuthenticated) {
    Widget screen;
    switch (settings.name) {
      case welcomeRoute:
        screen = const WelcomeScreen();
        break;
      case loginRoute:
        if (isAuthenticated) {
          screen = const WelcomeScreen();
        } else {
          screen = const LoginScreen();
        }
        break;
      default:
        if (!isAuthenticated) {
          screen = const LoginScreen();
        } else {
          screen = const WelcomeScreen();
        }
        break;
    }

    return MaterialPageRoute(builder: (context) {
      return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 2)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Indicator(text: 'Loading...');
          } else {
            return screen;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Authentication',
      theme: ThemeData(
          primaryColor: Constants.kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Constants.kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Constants.kPrimaryLightColor,
            iconColor: Constants.kPrimaryColor,
            prefixIconColor: Constants.kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: Constants.defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      initialRoute: isAuthenticated ? welcomeRoute : loginRoute,
      onGenerateRoute: (settings) =>
          _generateRoute(settings, ref.watch(isAuthenticatedProvider)),
    );
  }
}
