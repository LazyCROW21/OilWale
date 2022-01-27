import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oilmart/screens/customer/createaccount.dart';
import 'package:oilmart/screens/customer/home.dart';
import 'package:oilmart/screens/customer/home/garagepage.dart';
import 'package:oilmart/screens/customer/home/offerdetails.dart';
import 'package:oilmart/screens/customer/home/productpage.dart';
import 'package:oilmart/components/addvehicleform.dart';
import 'package:oilmart/screens/login.dart';
import 'package:oilmart/screens/logout.dart';
import 'package:oilmart/theme/themedata.dart';
import 'package:workmanager/workmanager.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // systemNavigationBarColor: AppColorSwatche.white,
      statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(

      // The top level function, aka callbackDispatcher
      callbackDispatcher,

      // If enabled it will post a notification whenever
      // the task is running. Handy for debugging tasks
      isInDebugMode: true);
  // Periodic task registration
  Workmanager().registerPeriodicTask(
    "2",

    //This is the value that will be
    // returned in the callbackDispatcher
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
  );

  var initSettingsAndroid = AndroidInitializationSettings('notification_icon');
  var initSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initSettings = InitializationSettings(
      android: initSettingsAndroid, iOS: initSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('Notification payload: ' + payload);
    }
  });

  runApp(MaterialApp(
    theme: ThemeData(
      splashColor: AppColorSwatche.primary,
      colorScheme: ThemeData().colorScheme.copyWith(
            primary: AppColorSwatche.primary,
            secondary: AppColorSwatche.primaryAccent,
            brightness: Brightness.light,
          ),
      // accentColor: AppColorSwatche.primary,
      highlightColor: AppColorSwatche.primary,
    ),
    initialRoute: '/login',
    home: LoginScreen(),
    routes: {
      '/login': (context) => LoginScreen(),
      '/logout': (context) => LogoutScreen(),
      '/cust_home': (context) => HomeScreen(),
      // '/cust_vehicle': (context) => VehicleDetails(),
      '/cust_offer': (context) => CustomerOfferDetails(),
      '/cust_product': (context) => ProductPage(),
      '/cust_garage': (context) => GaragePage(),
      '/cust_createAccount': (context) => CreateAccountScreen(),
      '/cust_addvehicle': (context) => AddVehicleForm(),
    },
  ));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    showNotification();
    return Future.value(true);
  });
}

void showNotification() async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'oilmart', 'oilmart', 'channel for oilmart notification',
      icon: 'notification_icon');

  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true);
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, 'OilMart', 'Buy Oil from us', platformChannelSpecifics);
}
