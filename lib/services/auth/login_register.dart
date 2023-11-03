import 'package:flutter/material.dart';
import 'package:minchat_app/pages/login_page.dart';
import 'package:minchat_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({required Key key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        final rotate = Tween<double>(
          begin: 0,
          end: 2 * 45, // Two full rotations (360 degrees)
        ).animate(animation);
        return RotationTransition(
          turns: rotate,
          child: child,
        );
      },
      child: showLoginPage
          ? LoginPage(onTap: togglePages, key: UniqueKey())
          : RegisterPage(onTap: togglePages, key: UniqueKey()),
    );
  }
}
