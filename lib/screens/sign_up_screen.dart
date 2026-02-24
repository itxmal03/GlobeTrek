import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants.dart';
import 'package:globe_trek/widgets/customized.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Customized customWidgets = Customized();
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
                  customWidgets.customTextField(
                    hint: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    hint: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    hint: 'Password',
                    icon: Icons.visibility_off_sharp,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    hint: 'Confirm Password',
                    icon: Icons.visibility_off_sharp,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: AppSizes.sm),
                        child: InkWell(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 84, 52, 171),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
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
