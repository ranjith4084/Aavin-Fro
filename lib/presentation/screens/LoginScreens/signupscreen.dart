// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../../../middleware/app_middleware.dart';
// import 'login_screen.dart';
//
// class SignUp extends StatefulWidget {
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   @override
//   String name;
//   String id;
//   String password;
//   int number;
//
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.blue[400],
//         body: Column(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 width: 160,
//                 child: Image.asset(
//                   "assets/aavin_logo_xl.png",
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//               width: 20,
//             ),
//             const Text(
//               'Create Account',
//               style: TextStyle(
//                 fontSize: 30,
//                 fontFamily: 'Courier',
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 16,
//                 horizontal: 32,
//               ),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       icon: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                       hintText: 'Enter Your Full Name',
//                       labelText: 'Full Name',
//                       hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                       labelStyle:
//                           TextStyle(fontSize: 16.0, color: Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         name = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                     width: 10,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                       icon: Icon(
//                         Icons.cabin,
//                         color: Colors.white,
//                       ),
//                       hintText: 'Enter Your ParlourId',
//                       labelText: 'Parlour Id',
//                       hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                       labelStyle:
//                           TextStyle(fontSize: 16.0, color: Colors.black),
//                     ),
//                     onChanged: (value) {
//                       id = value;
//                       setState(() {});
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                     width: 10,
//                   ),
//                   TextFormField(
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       icon: Icon(
//                         Icons.lock,
//                         color: Colors.white,
//                       ),
//                       hintText: 'Enter Your Password',
//                       labelText: 'Password',
//                       hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                       labelStyle:
//                           TextStyle(fontSize: 16.0, color: Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         password = value;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                     width: 10,
//                   ),
//                   TextFormField(
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       icon: Icon(
//                         Icons.phone_android,
//                         color: Colors.white,
//                       ),
//                       hintText: 'Enter Your Number',
//                       labelText: 'Number',
//                       hintStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//                       labelStyle:
//                           TextStyle(fontSize: 16.0, color: Colors.black),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         number = value as int;
//                       });
//                     },
//                   ),
//                   const SizedBox(
//                     height: 10,
//                     width: 10,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       await FirebaseFirestore.instance
//                           .collection("Pos_login").add({
//
//
//
//                         "PhoneNumber": Issue_Description,
//                         "StoreContactPerson": Completed,
//                         "Password ": Work_Proof,
//                         "Issue_Attachement": Issue_Attachement,
//                       }).then((value) async {
//                         await FirebaseFirestore.instance
//                             .collection('Pos_login')
//                             .doc(value.id)
//                             .update({"Document_Id": value.id});
//                         //print(value.id);
//                         docu = "${value.id}";
//                         //print("+++++++++++++${docu}");
//                         // ignore: unnecessary_statements
//
//                         return docu;
//                       },
//                         //     .catchError((e) {
//                         //   return false;
//                         // }
//                       );
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       width: 150,
//                       height: 35,
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       const Text('Already have an account?'),
//                       TextButton(
//                         onPressed: (() {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginScreen()));
//                           // Navigator.pushNamed(
//                           //   context,
//                           //   MyRoutes.loginScreen,
//                           // );
//                         }),
//                         child: const Text(
//                           'Sign In',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                     mainAxisAlignment: MainAxisAlignment.center,
//                   ),
//                   const Text(
//                     'By signing up you agree to our terms, conditions and privacy Policy.',
//                     style: TextStyle(
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
