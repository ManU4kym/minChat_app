import 'package:flutter/material.dart';
import 'package:minchat_app/components/my_button.dart';
import 'package:minchat_app/components/text_field.dart';
import 'package:minchat_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Icon(
                      Icons.message,
                      color: const Color(0xFF4F4A45).withOpacity(0.8),
                      size: 88,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Welcome  Back!',
                      style:
                          TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                        controller: passwordController,
                        hintText: "password",
                        obscureText: true),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(onTap: signIn, text: 'Sign In'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Register here.",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
