import 'package:flutter/material.dart';

class ItemDetailPhotos extends StatelessWidget {
  const ItemDetailPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(  
              minHeight: 50,
              minWidth: 300
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 30,
                primary: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
              child: Text("Add Photos"),
              onPressed: () {},
            ),
          ),
        )
      ],
      body: ListView(  
        children: [
          Text("Photos")
        ],
      ),
    );
  }
}
