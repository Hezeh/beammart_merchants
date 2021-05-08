import 'package:beammart_merchants/providers/category_tokens_provider.dart';
import 'package:beammart_merchants/providers/subscriptions_provider.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:universal_platform/universal_platform.dart';
import './providers/add_business_profile_provider.dart';
import './providers/auth_provider.dart';
import './providers/image_upload_provider.dart';
import './providers/profile_provider.dart';
import './screens/home.dart';
import 'package:provider/provider.dart';
import './screens/login.dart';
import './screens/profile.dart';
import './widgets/add_location.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
List<CameraDescription> cameras = [];
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await Hive.initFlutter();
  try {
    if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
      cameras = await availableCameras();
      InAppPurchaseConnection.enablePendingPurchases();
    }
  } catch (e) {
    print(e);
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider<ImageUploadProvider>(
          create: (_) => ImageUploadProvider(),
        ),
        StreamProvider<User?>(
          initialData: null,
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
        ),
        ChangeNotifierProxyProvider<AuthenticationProvider,
            SubscriptionsProvider>(
          create: (BuildContext context) => SubscriptionsProvider(
            Provider.of<AuthenticationProvider>(context, listen: false).user,
          ),
          update: (BuildContext context, userProvider, subscriptionsProvider) =>
              SubscriptionsProvider(
            Provider.of<AuthenticationProvider>(context, listen: false).user,
          ),
        ),
        ChangeNotifierProvider<CategoryTokensProvider>(
          create: (context) => CategoryTokensProvider(),
        ),
      ],
      builder: (BuildContext context, app) {
        return App();
      },
    ),
  );
}

class App extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final profile = context.watch<ProfileProvider>().profile;
    final loading = context.watch<ProfileProvider>().loading;
    Provider.of<SubscriptionsProvider>(context, listen: false);
    Provider.of<CategoryTokensProvider>(context, listen: false)
        .fetchTokenValues();
    return MaterialApp(
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.pink,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.pink,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
          ),
        ),
      ),
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
        Login.routeName: (_) => Login(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
        AddLocationMap.routeName: (_) => AddLocationMap(),
      },
    );
  }
}
