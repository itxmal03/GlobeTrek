import 'package:flutter/material.dart';

class Customized {
  Widget customTextField({required String hint, required IconData icon}) {
    return SizedBox(
      width: 350,
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: Colors.white),
          hintText: hint,
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
