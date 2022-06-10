import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final OTPNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneNumberController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {

    bool sendOTP = true;
    int timeOTP = 30;

    _enableOTP(){
      setState(() {
        sendOTP = false;
      });

      // code to resend OTP Code
      // end of that code

      while(sendOTP == false){
        Future.delayed(
          const Duration(seconds: 1), (){
            if(timeOTP != 0){
              setState(() {
                timeOTP = timeOTP - 1;
              });
            }else{
              setState(() {
                timeOTP = 30;
                sendOTP = true;
              });
            }
          }
        );
      }
    }

    _OTPBottomModal(){
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return Container(
            padding: const EdgeInsets.all(48.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(48.0),
                topLeft: Radius.circular(48.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: const Text(
                        "Masukan Nomor OTP yang dikirim ke nomor telepon anda",
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.0,
                      child: TextField(
                        controller: OTPNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6)
                        ],
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "123-456",
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextButton(
                          onPressed: null,
                          child: Text(
                            "Nomor hilang",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0
                            ),
                          )
                        ),
                        TextButton(
                          onPressed: sendOTP ? _enableOTP : null,
                          child: Text(
                            (sendOTP ? "Kirim kode" : "Kirim Kode ($timeOTP)"),
                            style: TextStyle(
                              color: (sendOTP ? Colors.black : Colors.grey),
                              fontSize: 18.0
                            ),
                          )
                        )
                      ],
                    ),
                    Container(
                      height: 60.0,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        onPressed: (){
                          null;
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
          );
        }
      );
    }

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
                    _OTPBottomModal();
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