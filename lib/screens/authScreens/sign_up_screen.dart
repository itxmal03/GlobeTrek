import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants/constants.dart';
import 'package:globe_trek/screens/authScreens/sign_in_screen.dart';
import 'package:globe_trek/screens/homescreen.dart';
import 'package:globe_trek/viewModels/auth_view_model.dart';
import 'package:globe_trek/widgets/customized.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  customWidgets.customTextField(
                    tController: _name,
                    hint: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    tController: _email,
                    hint: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    tController: _password,
                    isPassword: true,
                    hint: 'Password',
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 15),
                  customWidgets.customTextField(
                    tController: _confirmPassword,
                    isPassword: true,
                    hint: 'Confirm Password',
                    icon: Icons.lock,
                  ),
                  SizedBox(height: 15),
                  Consumer<AuthViewModel>(
                    builder: (ctx, val, child) => ElevatedButton(
                      onPressed: () async {
                        final result = await val.signUp(
                          _email.text.trim(),
                          _password.text.trim(),
                        );

                        if (result) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(val.errorMessage!)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(17),
                        ),
                      ),
                      child: val.isLoading
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Text(
                              'Create Account',
                              style: TextStyle(fontSize: 18),
                            ),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
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
