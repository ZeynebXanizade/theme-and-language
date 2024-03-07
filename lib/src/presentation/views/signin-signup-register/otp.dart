// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:reservation/src/data/auth.dart';
// import 'package:reservation/src/presentation/views/register_page.dart';
// import 'package:reservation/src/presentation/widgets/button/button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class Otp extends StatefulWidget {
//   const Otp({super.key});

//   @override
//   State<Otp> createState() => _OtpState();
// }

// class _OtpState extends State<Otp> {
//   final AuthServices _authServices = AuthServices();
//   GlobalKey<FormState> pinputkey = GlobalKey<FormState>();
//   final TextEditingController _otpController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: Theme.of(context).iconTheme,
//         backgroundColor: Colors.transparent,
//         title: Text(
//           style: Theme.of(context).textTheme.headlineLarge,
//           AppLocalizations.of(context)!.userparametrs.toString(),
//         ),
//       ),
//       body: Container(
//         margin: const EdgeInsets.only(left: 10, right: 10),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Text(
//                 "OTP Verification",
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(12.0),
//                 child: Text(
//                   "Enter the OTP sen to number",
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//               Pinput(
//                 controller: _otpController,
//                 length: 6,
//                 pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                 showCursor: true,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 // ignore: sized_box_for_whitespace
//                 child: MyButton(
//                     onPressed: () async {
//                       _authServices
//                           .loginwithOtp(
//                               otp: _otpController.text, context: context)
//                           .then((value) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => RegisterPage(
//                                     phoneNumber: _otpController.text)));
//                       });
//                     },
//                     text: const Text("Verify & Continue")),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
