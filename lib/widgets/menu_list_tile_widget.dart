import 'package:beammart_merchants/screens/all_chats_screen.dart';
import 'package:beammart_merchants/screens/analytics_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/profile.dart';
import '../providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../screens/profile.dart';

class MenuListTileWidget extends StatelessWidget {
  final _url =
      'https://play.google.com/store/apps/details?id=com.beammart.beammart';

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'customer.success@beammart.app',
      queryParameters: {'subject': 'Feedback'});

  void _lauchEmail() async => await canLaunch(_emailLaunchUri.toString())
      ? await launch(_emailLaunchUri.toString())
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    final currentUser = authProvider.user;
    final Profile? currentProfile =
        Provider.of<ProfileProvider>(context).profile;
    return Column(
      children: [
        (currentUser != null)
            ? Container(
                margin: EdgeInsets.all(20),
                child: Text("${currentUser.email}"),
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
            Icons.chat_bubble_outline_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Chats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AllChatsScreen(),
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
            Icons.analytics_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Analytics',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AnalyticsScreen(),
              ),
            );
          },
        ),
        // Divider(
        //   color: Colors.pink,
        //   indent: 10.0,
        //   endIndent: 10.0,
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.payments_outlined,
        //     color: Colors.pink,
        //   ),
        //   title: Text(
        //     'Payments & Subscriptions',
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 18.0,
        //     ),
        //   ),
        //   onTap: () {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (_) => PaymentsSubscriptionsScreen(),
        //       ),
        //     );
        //   },
        // ),
        Divider(
          color: Colors.pink,
          indent: 10.0,
          endIndent: 10.0,
        ),
        ListTile(
          leading: Icon(
            Icons.share_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Share Merchant App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            Share.share(
              'Get the Beammart Merchant App and let potential customers find your products for free: https://bit.ly/forMerchants',
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
            Icons.get_app_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Get Consumer App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            _launchURL();
          },
        ),
        Divider(
          color: Colors.pink,
          indent: 10.0,
          endIndent: 10.0,
        ),
        ListTile(
          leading: Icon(
            Icons.contact_support_outlined,
            color: Colors.pink,
          ),
          title: Text(
            'Help & Feedback',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          onTap: () {
            _lauchEmail();
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
