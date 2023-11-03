import 'package:flutter/material.dart';
import 'package:minchat_app/components/my_button.dart';
import 'package:minchat_app/components/text_field.dart';
import 'package:minchat_app/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("passwords do match"),
        ),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Success')),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
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
                      "let's create an account for you",
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
                    MyTextField(
                        controller: confirmPasswordController,
                        hintText: "confirm password",
                        obscureText: true),
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(onTap: signUp, text: 'Sign up'),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already a member?",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Sign In.",
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
