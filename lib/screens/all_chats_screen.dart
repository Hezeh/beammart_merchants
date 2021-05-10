import 'package:flutter/material.dart';
import 'package:beammart_merchants/widgets/all_chats_widget.dart';

class AllChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        title: Text("Your Chats"),
        centerTitle: true,
      ),
      body: AllChatsWidget()
    );
  }
}