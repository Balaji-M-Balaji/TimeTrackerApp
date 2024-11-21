import 'package:flutter/material.dart';
import 'package:loginapp/Config/colours.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LastLoginCardList extends StatelessWidget {
  final int itemCount;
  final String? time;
  final String? ip;
  final String? qrId;



  LastLoginCardList({super.key, required this.itemCount,this.time,this.ip,this.qrId});

  @override
  Widget build(BuildContext context) {
    return Card(
          color: MyColors.lightBlack,
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            title: Text(
              time!,
              style: TextStyle(fontSize: 18, color:Colors.white,fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('IP: ${ip!}',style: TextStyle(color: Colors.white),),
                Text('Location: Chennai',style: TextStyle(color: Colors.white)),
              ],
            ),
            trailing: Container(
              width: 50,
              height: 50,
              color: Colors.white,
              child: QrImageView(
                data: qrId!,
                version: QrVersions.auto,
                size: 70,
              ),
            ),
          ),
        );

  }
}
