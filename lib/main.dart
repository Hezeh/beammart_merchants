import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './providers/add_business_profile_provider.dart';
import './providers/auth_provider.dart';
import './providers/image_upload_provider.dart';
import './providers/profile_provider.dart';
import './screens/home.dart';
import 'package:provider/provider.dart';
import './screens/item_detail.dart';
import './screens/login.dart';
import './screens/profile.dart';
import './widgets/add_location.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<ImageUploadProvider>(
          create: (_) => ImageUploadProvider(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationProvider>().authState,
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider, ProfileProvider>(
          create: (BuildContext context) => ProfileProvider(
            Provider.of<AuthenticationProvider>(context, listen: false).user,
          ),
          update: (BuildContext context, userProvider, profileProvider) =>
              ProfileProvider(
            Provider.of<AuthenticationProvider>(context, listen: false).user,
          ),
        ),
        ChangeNotifierProvider<AddBusinessProfileProvider>(
          create: (context) => AddBusinessProfileProvider(),
        )
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final profile = context.watch<ProfileProvider>().profile;
    final loading = context.watch<ProfileProvider>().loading;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, accentColor: Colors.pink),
      title: 'Beammart Merchants',
      home: (firebaseUser != null)
          ? (loading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (profile != null)
                  ? Home()
                  : ProfileScreen()
          : Login(),
      routes: {
        Home.routeName: (_) => Home(),
        ItemDetail.routeName: (_) => ItemDetail(),
        Login.routeName: (_) => Login(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        AddLocationMap.routeName: (_) => AddLocationMap(),
      },
    );
  }
}
