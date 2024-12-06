import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/config/router.dart';
import 'package:flutter_learning/features/auth/bloc/auth_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/in_progress_widget.dart';
import 'widgets/initial_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo,
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state) {
              case AuthLoginSuccess():
                context.read<AuthBloc>().add(AuthAuthenticateStarted());
                break;
              case AuthAuthenticateSuccess():
                context.go(RouteName.home);
                break;
              case AuthLoginFailure(message: final msg):
                setState(() {
                  _errorMessage = msg;
                });
                break;
              default:
                setState(() {
                  _errorMessage = null;
                });
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                      return switch (state) {
                        AuthInitial() => InitialWidget(
                            formKey: _formKey,
                            message: _errorMessage,
                          ),
                        AuthLoginInProgress() => const InProgressWidget(),
                        _ => InitialWidget(
                            formKey: _formKey,
                            message: _errorMessage,
                          ),
                      };
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
