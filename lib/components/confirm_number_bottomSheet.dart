import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class ConfirmNumberBottomSheet extends StatefulWidget {
  const ConfirmNumberBottomSheet({Key? key}) : super(key: key);

  @override
  State<ConfirmNumberBottomSheet> createState() => _ConfirmNumberBottomSheetState();
}

class _ConfirmNumberBottomSheetState extends State<ConfirmNumberBottomSheet> {
  
  int time = 0;
  bool wait = false;

  _setTimer(){
    if(wait == false){
      setState(() {
        wait = true;
        time = 10;
      });
      _setTimer();
    }else{
      if(time != 0){
        Future.delayed(Duration(seconds: 1), (){
          setState(() {
            time--;
          });
        });
        log('$time');
        _setTimer();
      }else{
        setState(() {
          wait = false;
        });
      }
    }
    // Future.delayed(const Duration(seconds: 1), (){
    //   setState(() {
    //     time--;
    //   });
    //   log("$time");
    //   _setTimer();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        )
      ),
      child: Column(
        children: [
          Text('$time'),
          Text('current status: ${(wait ? "waiting" : "not waiting")}'),
          ElevatedButton(
            onPressed: wait ? null : (){
              _setTimer();
            },
            child: const Text("test")
          )
        ],
      ),
    );
  }
}