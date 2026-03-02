import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants/constants.dart';
import 'package:globe_trek/core/constants/size_config.dart';
import 'package:globe_trek/screens/authScreens/sign_in_screen.dart';
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

  final _formKey = GlobalKey<FormState>();

  Customized customWidgets = Customized();
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
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
        body: SafeArea(
          child: Center(
            child: Card(
              color: Colors.white.withValues(alpha: 0.2),
              elevation: 15,
              child: Container(
                width: SizeConfig.wp(95),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      customWidgets.customTextField(
                        tController: _email,
                        hint: 'Email',
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      customWidgets.customTextField(
                        tController: _password,
                        isPassword: true,
                        hint: 'Password',
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      customWidgets.customTextField(
                        tController: _confirmPassword,
                        isPassword: true,
                        hint: 'Confirm Password',
                        icon: Icons.lock,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm your password";
                          }
                          if (value != _password.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      Consumer<AuthViewModel>(
                        builder: (ctx, val, child) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff005bea).withValues(alpha: 0.9),
                                  Color(0xff00c6fb).withValues(alpha: 0.9),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.20),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                splashColor: Colors.white24,
                                onTap: val.isLoading
                                    ? null
                                    : () async {
                                        if (!_formKey.currentState!
                                            .validate()) {
                                          return;
                                        }
                                        final navigator = Navigator.of(context);
                                        final result = await val.signUp(
                                          userName: _name.text.trim(),
                                          email: _email.text.trim(),
                                          password: _password.text.trim(),
                                        );
                                        if (result) {
                                          if (!context.mounted) return;
                                          AppSnackBar.show(
                                            context,
                                            'Verification email sent. Check your inbox.',
                                          );
                                          navigator.push(
                                            MaterialPageRoute(
                                              builder: (_) => SignInScreen(),
                                            ),
                                          );
                                        } else {
                                          if (!context.mounted) return;
                                          AppSnackBar.show(
                                            context,
                                            "Unexpected error occured. Try again!",
                                          );
                                        }
                                      },
                                child: Center(
                                  child: val.isLoading
                                      ? SizedBox(
                                          height: 28,
                                          width: 28,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : Text(
                                          'Create Account',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                ),
                              ),
                            ),
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

                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.lg),
                        child: Row(
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
                                    color: Color.fromARGB(255, 1, 97, 251),
                                    fontWeight: FontWeight.w600,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
