import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_learning/config/router.dart';
import 'package:flutter_learning/features/auth/bloc/auth_bloc.dart';
import 'package:flutter_learning/utils/validators.dart';
import 'package:flutter_learning/widgets/password_field.dart';
import 'package:go_router/go_router.dart';

class InitialWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? message;

  const InitialWidget(
      {super.key, required this.formKey, required this.message});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _handleSubmit(BuildContext context) async {
    if (widget.formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLoginStarted(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Login',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        const SizedBox(
          height: 16,
        ),
        if (widget.message != null)
          Text(
            'Error: ${widget.message}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          controller: _emailController,
          validator: (value) {
            return Validators.email(value);
          },
          decoration: InputDecoration(
            labelText: 'Email',
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        PasswordField(
          controller: _passwordController,
          labelText: 'Password',
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: FilledButton(
            onPressed: () {
              _handleSubmit(context);
            },
            child: const Text('Continue'),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                context.go(RouteName.register);
              },
              child: const Text(
                'Reigster',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
