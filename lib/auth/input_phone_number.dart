import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtube3/auth/confirm_phone_number.dart';
import 'package:vtube3/config/palette.dart';

class InputPhoneNumber extends StatefulWidget {
  const InputPhoneNumber({Key? key}) : super(key: key);

  @override
  State<InputPhoneNumber> createState() => _InputPhoneNumberState();
}

class _InputPhoneNumberState extends State<InputPhoneNumber> {

  final phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // phone_number_controller.addListener(() {
    //   log(phone_number_controller.text);
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    MediaQueryData query = MediaQuery.of(context);

    // Dialog
    _confirmDialog(){
      return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Container(
              padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
              child: Column(
                children: const [
                  Icon(
                    Icons.warning_rounded,
                    color: Colors.red,
                    size: 96.0,
                  ),
                  Text("Nomor yang dimasukan kurang dari 12 angka")
                ],
              ),
            ),
          );
        }
      );
    }

    // Confirm in Continue Button
    confirm(){
      if(phoneNumberController.text != null && phoneNumberController.text.length >= 11){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (
              (context, animation, secondaryAnimation) => ConfirmPhoneNumber(
                phoneNumber: phoneNumberController.text
              )
            ),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder: (context, animation, secondaryAnimation, child){
              animation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut
              );
              return Align(
                child: SlideTransition(
                  position: Tween(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0)
                  ).animate(animation),
                  child: child,
                ),
              );
            }
          )
        );
      }else{
        _confirmDialog();
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: query.size.width,
          height: query.size.height,
          padding: const EdgeInsets.fromLTRB(24.0, 72.0, 24.0, 24.0),
          color: Palette.backgroundColor,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Palette.primary,
                          Palette.secondary
                        ]
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(72.0, 24.0, 72.0, 24.0),
                    decoration: BoxDecoration(
                      color: Palette.backgroundColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 72.0,
                      height: 72.0,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/vtubeLogo.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: query.size.width * 2 / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: const DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          child: Text(
                            "Nonton iklan dapat uang",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: const DefaultTextStyle(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          child: Text(
                            "Hasilkan penghasilan sampingan dari rumah hanya dengan menonton iklan",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: const Text(
                        "Masukan nomor telepon untuk melanjutkan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      child: TextField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12)
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "811-1234-5678",
                          prefixIcon: Padding(padding: EdgeInsets.only(left: 24, right: 24), child: Text("+62"),),
                          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        ),
                      ),
                    ),
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8.0),
                      // decoration: BoxDecoration(
                      //   color: Palette.buttonColor,
                      //   borderRadius: BorderRadius.circular(4.0)
                      // ),
                      child: ElevatedButton(
                        onPressed: (){
                          confirm();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Palette.buttonColor
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            backgroundColor: Colors.transparent,
                            fontSize: 18.0
                          ),
                        )
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}