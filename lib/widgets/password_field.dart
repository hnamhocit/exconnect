import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/validators.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;

  const PasswordField(
      {super.key, required this.controller, required this.labelText});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => Validators.password(value),
      autocorrect: false,
      obscureText: _isVisibility ? false : true,
      enableSuggestions: false,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isVisibility = !_isVisibility;
              });
            },
            icon:
                Icon(_isVisibility ? Icons.visibility : Icons.visibility_off)),
        labelText: widget.labelText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
