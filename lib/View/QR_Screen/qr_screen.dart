import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginapp/Config/colours.dart';
import 'package:loginapp/View/QR_Screen/qr_screen_controller.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:loginapp/Config/globals.dart' as globals;

import '../LastLogin/last_login_screen.dart';
import '../Login/login_screen.dart';
import '../Login/login_screen_controller.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  QrScreenController controller = Get.put(QrScreenController());
  LoginScreenController loginController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -30,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(color: MyColors.lightPurple, shape: BoxShape.circle),
                child: InkWell(
                  onTap: () {
                    loginController.clearData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                      "Logout",
                          style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
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
                            'PLUGIN',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                              child: QrImageView(
                                data: controller.randomNumber.toString(),
                                version: QrVersions.auto,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Generated Number", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        Text(controller.randomNumber.toString(), style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "Last login at Today, ${globals.time}",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 45,
                            child: TextButton(
                              style: ButtonStyle(shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))), backgroundColor: const WidgetStatePropertyAll(Color(0xff3e3e3e))),
                              onPressed: () {
                                setState(() {
                                  controller.saveData();
                                });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LastLoginScreen(),
                                    ));
                              },
                              child: const Text(
                                'SAVE',
                                style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
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
