import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/main.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'orders', // id
    'Orders', // title
    description:
        'This channel is used for orders notifications.', // description
    importance: Importance.max,
  );

  Future<void> initNotifications() async {
    // await _firebaseMessaging.requestPermission();
    initPermissions();

    final fcmToken = await _firebaseMessaging.getToken();

    logger.f("FCM Token : $fcmToken");
    User.fCMToken = fcmToken;

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    initPushNotifications();
  }

  Future initPushNotifications() async {
    // when terminated
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (Get.context != null) {
        BlocProvider.of<BottomNavBarCubit>(Get.context!).navigate(index: 4);
      }
    });

    // when on background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (Get.context != null) {
        BlocProvider.of<BottomNavBarCubit>(Get.context!).navigate(index: 4);
      }
    });

    // when on foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        if (message.notification != null &&
            message.notification!.body != null &&
            Get.context != null) {
          showSnackBar(
              message.notification!.body!, SnackBarMessageType.notification,
              onTap: (snack) {
            BlocProvider.of<BottomNavBarCubit>(Get.context!).navigate(index: 4);
          });
        }
      },
    );
  }

  void initPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.d('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      logger.d('User granted provisional permission');
    } else {
      logger.d('User declined or has not accepted permission');
    }
  }
}
