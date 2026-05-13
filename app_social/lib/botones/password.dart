import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _ocultar = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _ocultar,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: const Icon(
          Icons.lock,
          color: Color(0xFFF0B429),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _ocultar ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFFF0B429),
          ),
          onPressed: () {
            setState(() {
              _ocultar = !_ocultar;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}