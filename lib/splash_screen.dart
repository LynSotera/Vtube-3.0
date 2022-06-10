import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vtube3/auth/input_phone_number.dart';
import 'package:vtube3/config/palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (context) => const InputPhoneNumber()
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.backgroundColor,
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/vtubeLogo.png"),
            )
          )
        )
      ),
    );
  }
}