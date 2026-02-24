import 'package:flutter/material.dart';

class Customized {
  Widget CustomTextField() {
    return SizedBox(
      width: 350,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.email, color: Colors.white),
          hintText: 'Email',
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          filled: true,

          fillColor: Colors.white.withValues(alpha: 0.3),
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
