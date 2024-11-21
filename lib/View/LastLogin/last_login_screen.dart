import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginapp/Config/colours.dart';

import '../../Model/model.dart';
import '../Login/login_screen.dart';
import '../Login/login_screen_controller.dart';
import 'last_login_card.dart';
import 'last_login_controller.dart';

class LastLoginScreen extends StatefulWidget {
  const LastLoginScreen({super.key});

  @override
  State<LastLoginScreen> createState() => _LastLoginScreenState();
}

class _LastLoginScreenState extends State<LastLoginScreen> {
  LastLoginController controller = LastLoginController();
  LoginScreenController loginController = Get.put(LoginScreenController());

  final PageController _pageController = PageController();
  final List<String> _tabs = ['TODAY', 'Yesterday', 'Other'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
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
                  decoration: const BoxDecoration(color: MyColors.lightPurple, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: InkWell(
                      onTap: () {
                        loginController.clearData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
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
                              'Last Login',
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TabBar(
                              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                              indicatorColor: Colors.white,
                              dividerColor: Colors.transparent,
                              onTap: (index) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              tabs: _tabs
                                  .map((tab) => Tab(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              tab,
                                              style: const TextStyle(fontSize: 15, color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              children: [
                                FutureBuilder<List<SavedDataEntry>>(
                                    future: controller.getSavedData(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                        return Center(
                                            child: Text(
                                          'No data saved',
                                          style: TextStyle(color: Colors.white),
                                        ));
                                      } else {
                                        List<SavedDataEntry> savedEntries = snapshot.data!.reversed.toList();
                                        return ListView.builder(
                                            padding: const EdgeInsets.all(8.0),
                                            itemCount: savedEntries.length,
                                            itemBuilder: (context, index) {
                                              SavedDataEntry entry = savedEntries[index];
                                              return LastLoginCardList(
                                                itemCount: savedEntries.length,
                                                time: entry.time,
                                                ip: entry.ipData,
                                                qrId: entry.qrData,
                                              );
                                            });
                                      }
                                    }),
                                Center(
                                    child: Text(
                                  'No data',
                                  style: TextStyle(color: Colors.white),
                                )),
                                Center(
                                    child: Text(
                                  'No data',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
