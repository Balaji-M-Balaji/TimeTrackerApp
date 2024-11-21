
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loginapp/Config/colours.dart';

import 'package:loginapp/Config/globals.dart' as globals;
import 'package:motion_toast/motion_toast.dart';

import '../QR_Screen/qr_screen.dart';

class LoginScreenController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool isOtpSend = false;

  String generatedOtp = '';
  int randomNumber = 0;
  String? city = '';
  String? ipAddress = '';
  String? date = '';
  String? time = '';
  DateTime now = DateTime.now();
  int remainingTime = 0;
  bool isResendButtonVisible = false;

  void generateOtp(context) async {
    final random = Random();
    generatedOtp = (1000 + random.nextInt(9999)).toString();
    isOtpSend = true;

    showOtpDialog(context);

  }

  void showOtpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Your OTP',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            generatedOtp,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () {
                otpController.text = generatedOtp;

                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: MyColors.skyBlue,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }


  verifyOtp(context) async {
    if (otpController.text == generatedOtp) {
      await generateRandomNumber();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QrGeneratorScreen(),
          ));
    } else {
        MotionToast.warning(
          description: Text(
              'Invalid OTP',
              style:
              TextStyle(fontSize: 15,fontWeight: FontWeight.bold)

          ),
          animationCurve: Curves.bounceIn,
          borderRadius: 0,
          animationDuration: const Duration(milliseconds: 1000),
          opacity: .9,
          position: MotionToastPosition.top,
        ).show(context);
      }
  }

  generateRandomNumber() async {
    final random = Random();
    randomNumber = (10000 + random.nextInt(99999));


      try {
        for (var interface in await NetworkInterface.list()) {
          for (var addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4) {
                ipAddress = addr.address;
              break;
            }
          }
          if (ipAddress != null) break;
        }
      } catch (e) {
          ipAddress = 'Failed to get IP address';
      }

    date = '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    time = '${now.hour == 0 ? 12 : now.hour}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}';

    print("date$date");
    print("date$time");
    print("date$city");
    globals.code = randomNumber.toString().isNotEmpty ? randomNumber.toString() : '';
    globals.time = time.toString().isNotEmpty ? time.toString() : '';
    globals.date = date.toString().isNotEmpty ? date.toString() : '';
    globals.location = city.toString().isNotEmpty ? city.toString() : '';
    globals.ipAddress = ipAddress.toString().isNotEmpty ? ipAddress.toString() : '';
  }

  clearData(){
    isOtpSend = false;
    otpController.clear();
    phoneNumberController.clear();

  }
}
