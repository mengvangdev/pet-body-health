import 'package:flutter/material.dart';

class LogoScreen extends StatelessWidget {
  const LogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Body Pet Health",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(height: 50),
            Image.asset(
              "assets/images/PrimoM.png",
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
