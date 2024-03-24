// import 'package:aavinposfro/models/app_state.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:redux/redux.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../actions/actions.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   String id;
//   String password;
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, _ViewModel>(
//         converter: _ViewModel.fromStore,
//         builder: (context, vm) {
//           return Scaffold(
//               backgroundColor: Colors.blue[400],
//               body: Theme(
//                 data: ThemeData(
//                     textTheme: TextTheme(
//                         subtitle1: GoogleFonts.lato(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.grey[100]),
//                         subtitle2: GoogleFonts.lato(
//                             color: Colors.grey[200],
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                         headline5: GoogleFonts.openSans(
//                             color: Colors.grey[200],
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16),
//                         bodyText1:
//                         GoogleFonts.lato(color: Colors.grey[100], fontSize: 14),
//                         bodyText2:
//                         GoogleFonts.lato(color: Colors.grey[100], fontSize: 14)),
//                     brightness: Brightness.light,
//                     primarySwatch: Colors.blue,
//                     buttonTheme: ButtonThemeData(
//                         buttonColor: Colors.green, textTheme: ButtonTextTheme.primary)),
//                 child: Builder(
//                   builder: (BuildContext context) {
//                     return Center(
//                       child: Wrap(children: <Widget>[
//                         Form(
//                           key: _formKey,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 32),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Container(
//                                     width: 160,
//                                     child: Image.asset(
//                                       "assets/aavin_logo_xl.png",
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 32,
//                                 ),
//                                 AnimatedTextKit(
//                                   animatedTexts: [
//                                     TypewriterAnimatedText('Welcome!',
//                                         textStyle: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 30,
//                                           fontStyle: FontStyle.italic,
//                                           fontFamily: 'Times New Roman',
//                                           fontWeight: FontWeight.w800,
//                                         ),
//                                         speed: const Duration(
//                                           milliseconds: 650,
//                                         )),
//                                   ],
//                                   isRepeatingAnimation: true,
//                                   totalRepeatCount: 2,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.center,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 12.0,
//                                         right: 12,
//                                         bottom: 12,
//                                         top: 4),
//                                     child: Text(
//                                       'Login'.toUpperCase(),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .subtitle1
//                                           .copyWith(
//                                               color: Colors.white,
//                                               fontSize: 36),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 16,
//                                     horizontal: 32,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       TextFormField(
//                                         decoration: const InputDecoration(
//                                             icon: Icon(
//                                               Icons.cabin,
//                                               color: Colors.white,
//                                             ),
//                                             hintStyle: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.white),
//                                             hintText: 'Enter Your Parlour ID',
//                                             labelText: 'Parlour ID',
//                                             labelStyle: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.white)),
//                                         onChanged: (value) {
//                                           id = value;
//                                           setState(() {});
//                                         },
//                                       ),
//                                       TextFormField(
//                                         obscureText: true,
//                                         decoration: const InputDecoration(
//                                           icon: Icon(
//                                             Icons.lock,
//                                             color: Colors.white,
//                                           ),
//                                           hintStyle: TextStyle(
//                                               fontSize: 16.0,
//                                               color: Colors.white),
//                                           labelStyle: TextStyle(
//                                               fontSize: 16.0,
//                                               color: Colors.white),
//                                           hintText: 'Enter Your Password',
//                                           labelText: 'Password',
//                                         ),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             password = value;
//                                           });
//                                         },
//                                       ),
//                                       SizedBox(height: 16.0),
//                                       ElevatedButton(
//                                         onPressed: (() async {
//                                           try {
//                                             print("id - $id - $password");
//                                             print(id + "_PM@aavin.local");
//                                             await FirebaseAuth.instance
//                                                 .signInWithEmailAndPassword(
//                                                     email: id + "@aavin.local",
//                                                     password: password);
//                                             print("LoginfghjId");
//                                           } on FirebaseAuthException catch (e) {
//                                             if (e.code == 'user-not-found') {
//                                               print(
//                                                   'No user found for that email.');
//                                             } else if (e.code ==
//                                                 'wrong-password') {
//                                               //print(
//                                               //     'Wrong password provided for that user.');
//                                             } else {
//                                               print("waesrdtfyguhij");
//                                             }
//                                           }
//                                           print("qwertyuiop234567890-");
//
//                                           // Notifying id token listeners about user ( A0qtGRs1h8SVZ9w6Lr3UnHfLAXg2 ).
//                                           // Notifying auth state listeners about user ( nR59LLqyP0ZibLXSX3KfkzlaXlp1 ).
//                                         }),
//                                         style: ButtonStyle(
//                                             backgroundColor:
//                                                 MaterialStateProperty.all<
//                                                     Color>(Colors.green),
//                                             minimumSize:
//                                                 MaterialStateProperty.all<Size>(
//                                                     Size(250, 50))),
//                                         child: const Text(
//                                           'Sign In',
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ]),
//                     );
//                   },
//                 ),
//               ));
//         });
//   }
// }
//
// class _ViewModel {
//   _ViewModel();
//
//   static _ViewModel fromStore(Store<AppState> store) {
//     return _ViewModel();
//   }
// }
