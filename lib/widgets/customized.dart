import 'package:flutter/material.dart';

class Customized {
  Widget customTextField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return _CustomTextField(
      hint: hint,
      icon: icon,
      isPassword: isPassword,
    );
  }
}

class _CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;

  const _CustomTextField({
    required this.hint,
    required this.icon,
    required this.isPassword,
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
      child: TextField(
        obscureText: widget.isPassword ? _obscureText : false,
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
                    _obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
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
            borderSide:
                BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
            borderSide:
                BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
        ),
      ),
    );
  }
}
