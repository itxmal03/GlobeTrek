import 'package:flutter/material.dart';

class Customized {
  Widget customTextField({
    required String hint,
    required IconData icon,
    required TextEditingController tController,
    bool isPassword = false,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return _CustomTextField(
      hint: hint,
      icon: icon,
      isPassword: isPassword,
      controller: tController,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}

class _CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const _CustomTextField({
    required this.hint,
    required this.icon,
    required this.isPassword,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<_CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<_CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _obscureText : false,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.3),
          prefixIcon: Icon(widget.icon, color: Colors.white),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
        ),
      ),
    );
  }
}

class AppSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1E293B),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
