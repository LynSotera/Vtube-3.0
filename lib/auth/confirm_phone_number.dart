import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtube3/components/confirm_number_bottomSheet.dart';
import 'package:vtube3/config/palette.dart';

class ConfirmPhoneNumber extends StatefulWidget {
  ConfirmPhoneNumber({
    Key? key,
    required this.phoneNumber
  }) : super(key: key);

  final dynamic phoneNumber;

  @override
  State<ConfirmPhoneNumber> createState() => _ConfirmPhoneNumberState();
}

class _ConfirmPhoneNumberState extends State<ConfirmPhoneNumber> {

  final phoneNumberController = TextEditingController();
  final otpNumberController = TextEditingController();

  bool sendOTP = true;
  int timeOTP = 30;

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: Palette.backgroundColor,
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon:  const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: const Text(
                      "Kami akan mengirimkan kode verifikasi ke nomor ini",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                      height: 60.0,
                      child: TextField(
                        enabled: false,
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
                ],
              ),
              Container(
                height: 60.0,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: (){
                    showModalBottomSheet(
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      elevation: 1,
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmNumberBottomSheet();
                      }
                    );
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
        ),
      ),
    );
  }
}