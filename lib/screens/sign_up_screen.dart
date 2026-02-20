import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff005bea), Color(0xff00c6fb)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Card(
            color: Colors.white.withValues(alpha: 0.2),
            elevation: 15,

            child: Container(
              width: 380,
              height: 550,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Colors.white.withValues(alpha: 0.2),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_sharp,
                          color: Colors.white,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.3),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_rounded,
                          color: Colors.white,
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.3),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(17),
                      ),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'or',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // SignInButton(Buttons.google, onPressed: () {}),
                      // SignInButton(Buttons.appleDark, onPressed: () {}),
                    ],
                  ),
                  Text(
                    'Already have an account? LogIn',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
