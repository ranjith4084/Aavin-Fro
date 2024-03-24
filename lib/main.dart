import 'dart:io';
import 'package:aavinposfro/Settings/Profile.dart';
import 'package:aavinposfro/actions/actions.dart';
import 'package:aavinposfro/middleware/navigation_middleware.dart';
import 'package:aavinposfro/models/reactive_repository.dart';
import 'package:aavinposfro/presentation/BillCancel/viewdetails.dart';
import 'package:aavinposfro/presentation/screens/LoginScreens/login_screen.dart';
import 'package:aavinposfro/presentation/screens/checkout/checkout_screen.dart';
import 'package:aavinposfro/presentation/screens/editorder/EditOrder.dart';
import 'package:aavinposfro/presentation/screens/home/Home.dart';
import 'package:aavinposfro/presentation/screens/home/home_screen.dart';
import 'package:aavinposfro/presentation/screens/home/indent/products_list.dart';
import 'package:aavinposfro/presentation/screens/orderdetail/Orderetail.dart';
import 'package:aavinposfro/presentation/screens/orderhistory/orderHistory.dart';
import 'package:aavinposfro/reducers/app_state_reducer.dart';
import 'package:aavinposfro/routes.dart';
import 'package:aavinposfro/sharedpreference.dart';
import 'package:aavinposfro/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'middleware/app_middleware.dart';
import 'models/app_state.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefService.init();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  HttpOverrides.global = MyHttpOverrides();


  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver observer =  FirebaseAnalyticsObserver(analytics: analytics);
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  final Store<AppState> store;
  static GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  MyApp({Key key})
      : store =
            Store<AppState>(appReducer, initialState: AppState(selectedFilterProduct: ""), middleware: [
          appMiddleware,
          new NavigationMiddleware(navigatorKey).create(),
          new LoggingMiddleware.printer()
        ]),
        super(key: key) {
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aavin POS',
        themeMode: ThemeMode.light,
        navigatorKey: navigatorKey,
        theme: ThemeData(
            textTheme: TextTheme(
                subtitle1: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.grey[700]),
                subtitle2: GoogleFonts.lato(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                headline5: GoogleFonts.openSans(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                bodyText1:
                    GoogleFonts.lato(color: Colors.grey[700], fontSize: 14),
                bodyText2:
                    GoogleFonts.lato(color: Colors.grey[700], fontSize: 14)),
            brightness: Brightness.light,
            platform: defaultTargetPlatform,
            primarySwatch: Colors.blue,
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.green, textTheme: ButtonTextTheme.primary)),
        routes: {
          // AppRoutes.home: (context) => HomePage(),
          // AppRoutes.login: (context) => LoginScreen(),
          AppRoutes.checkout: (context) => CheckoutScreen(),

          AppRoutes.orderdetail: (context) => OrderDetailScreen(),
          AppRoutes.BillDetailScreen: (context) => BillDetailScreen(),
          AppRoutes.profile:(context)=>Profile(),
          AppRoutes.editorder: (context) => EditOrderScreen(),
          AppRoutes.splash: (context) => SplashScreen(),

        },
        initialRoute: "/splash"//store.state.currentRoute,//'home',
      ),
    );
  }

}
