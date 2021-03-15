import 'package:flutter/material.dart';
import '../widgets/menu_list_tile_widget.dart';

class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(  
        children: [
          MenuListTileWidget()
        ],
      ),
    );
  }
}