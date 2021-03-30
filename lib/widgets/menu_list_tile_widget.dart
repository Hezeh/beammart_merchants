import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/profile.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../screens/profile.dart';

class MenuListTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final currentUser = authProvider.user;
    final Profile currentProfile =
        Provider.of<ProfileProvider>(context).profile;
    return Column(
      children: [
        (currentUser != null)
            ? UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  radius: 60.0,
                  child: Image.network('${currentUser.photoURL}'),
                ),
                accountName: Text('${currentUser.displayName}'),
                accountEmail: Text('${currentUser.email}'),
              )
            : Container(),
        ListTile(
          leading: Icon(
            Icons.storefront_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Store Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  profile: currentProfile,
                ),
              ),
            );
          },
        ),
        Divider(
          color: Colors.pink,
          indent: 10.0,
          endIndent: 10.0,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.pink,
          ),
          title: Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () => authProvider.signOut(),
        ),
      ],
    );
  }
}
