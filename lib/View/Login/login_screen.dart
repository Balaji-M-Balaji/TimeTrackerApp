import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

import '../../Config/colours.dart';
import 'login_screen_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenController controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(color: MyColors.lightPurple, shape: BoxShape.circle),
              ),
            ),
            Column(
              children: [
                 SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Expanded(
                  child: Stack(clipBehavior: Clip.none, children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -25,
                      left: (MediaQuery.of(context).size.width / 2) - 70,
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: MyColors.skyBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: controller.phoneNumberController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                filled: true,
                                fillColor: MyColors.kPrimaryColor,
                                hintStyle: TextStyle(color: Colors.white10, fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              ),
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            if (controller.isOtpSend)
                              TextField(
                                controller: controller.otpController,
                                keyboardType: TextInputType.number,
                                maxLength: 4,
                                decoration: InputDecoration(
                                  hintText: 'OTP',
                                  filled: true,
                                  fillColor: MyColors.kPrimaryColor,
                                  hintStyle: TextStyle(color: Colors.white10, fontWeight: FontWeight.bold),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                ),
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            SizedBox(height: 10),
                            if (!controller.isOtpSend)
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (controller.phoneNumberController.text.isNotEmpty) {
                                        controller.generateOtp(context);
                                      } else {
                                        MotionToast.warning(
                                          title: Text(
                                            'Warning',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          description: Text(
                                            'Please Enter Your Phone Number',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          animationType: AnimationType.fromTop,
                                          position: MotionToastPosition.top,
                                        ).show(context);
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Send OTP',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            if (controller.isOtpSend)
                              SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.verifyOtp(context);
                                    });
                                  },
                                  child: Text('Login', style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade700,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
