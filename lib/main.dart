import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/config/http_client.dart';
import 'package:flutter_learning/config/router.dart';
import 'package:flutter_learning/config/theme.dart';
import 'package:flutter_learning/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_learning/features/auth/data/auth_api_client.dart';
import 'package:flutter_learning/features/auth/data/auth_local_data_source.dart';
import 'package:flutter_learning/features/auth/data/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sf = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sf,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(
          authApiClient: AuthApiClient(dio: dio),
          authLocalDataSource: AuthLocalDataSource(sf: sharedPreferences)),
      child: BlocProvider(
        create: (context) => AuthBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthBloc>().state;

    if (authState is AuthInitial) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: router,
    );
  }
}
