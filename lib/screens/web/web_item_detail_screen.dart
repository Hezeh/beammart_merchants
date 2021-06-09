import 'package:beammart_merchants/widgets/web/item_detail_photos.dart';
import 'package:flutter/material.dart';

class WebItemDetailScreen extends StatelessWidget {
  const WebItemDetailScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Item Detail"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Row(  
        children: [
          Expanded(
            // child: Container(
            //   // width: 500,
            //   child: ListView(  
            //     children: [
            //       Text("Images"),
                  
            //     ],
            //   ),
            //   color: Colors.pink,
            // ),
            child: ItemDetailPhotos(),
          ),
          const VerticalDivider(width: 2),
          Expanded(
            child: Container(
              child: ListView(  
                children: [
                  Text("Edit")
                ],
              ),
              color: Colors.pink,
            ),
          ),
          const VerticalDivider(width: 2),
            Expanded(
              child: Container(
                child: ListView(  
                  children: [
                    Text("Analytics")
                  ],
                ),
                color: Colors.pink,
              ),
            )
        ],
      )
    );
  }
}