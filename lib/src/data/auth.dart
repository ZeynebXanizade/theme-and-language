import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reservation/src/presentation/views/tapcontroller/tapcontroller.dart';
import 'package:reservation/src/utils/constants/fluttertoast.dart';

class Users {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String password;
  

  Users( {
   
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });
}

class AuthServices {
  final userCollection = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //////////////////////////SIGN UP/////////////////////////////////////
  Future<void> signUpWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String phone,
      }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // firestoreye kocurmek
        await userCollection.doc(userCredential.user!.uid).set({
          "id": userCredential.user!.uid,
          "email": email,
          "name": name,
          "phone": phone,
          "password": password,
          "timestamp": Timestamp.now()
        });
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      FlutterToast.showToasts(
          // ignore: use_build_context_synchronously
          msg: AppLocalizations.of(context)!.error.toString(),
          context: context);
      // ignore: avoid_print
      print("Firebase Auth Hatası: ${e.code}, ${e.message}");
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  /////////////////////////////READ//////////////////////////////////////////////
  Future<Users?> getUserData(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await userCollection.doc(userId).get();

      if (userSnapshot.exists) {
        return Users(
          id: userSnapshot['id'],
          email: userSnapshot['email'],
          name: userSnapshot['name'],
          phone: userSnapshot['phone'],
          password: userSnapshot['password'],
          
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("getUserData error: $e");
    }

    return null;
  }


//////////////////////////////user////////
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //////////////////////////////////UPDATE/////////////////////////////////////
  Future<void> updateUsers(String userId, String newName, String newEmail,
      String newPhone, String newPasw) async {
    try {
      Map<String, dynamic> updateData = {};

      if (newName.isNotEmpty) {
        updateData["name"] = newName;
      }
      if (newPasw.isNotEmpty) {
        updateData["password"] = newPasw;
      }
      if (newEmail.isNotEmpty) {
        updateData["email"] = newEmail;
      }

      if (newPhone.isNotEmpty) {
        updateData["phone"] = newPhone;
      }

      if (updateData.isNotEmpty) {
        updateData["timestamp"] = FieldValue.serverTimestamp();

        await userCollection.doc(userId).update(updateData);
      } else {
        // ignore: avoid_print
        print("No valid data to update.");
      }
    } catch (e) {
      // ignore: avoid_print
      print("updateUsers error: $e");
    }
  }

  ////////////////////////////////////////DELETE/////////////////////////////////////////
  Future<void> deleteUsers(String userId, BuildContext context) async {
    try {
      // Firestore'dan kullanıcıyı sil
      await userCollection.doc(userId).delete();

      // Firebase Authentication'tan kullanıcıyı sil
      await _auth.currentUser!.delete();
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      // Firebase Authentication'tan kullanıcıyı silme hatası
      // ignore: use_build_context_synchronously
      FlutterToast.showToasts(
        context: context,
        // ignore: use_build_context_synchronously
        msg: AppLocalizations.of(context)!.error.toString(),
      );
    }
  }

/////////////////////////////////SIGN IN///////////////////////////////////////
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        // ignore: use_build_context_synchronously
        if (_auth.currentUser!.emailVerified) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const TabControllers()),
          );
          // ignore: use_build_context_synchronously
          FlutterToast.showToasts(
              // ignore: use_build_context_synchronously
              msg: AppLocalizations.of(context)!.succesful.toString(),
              context: context);
        } else {
          // ignore: use_build_context_synchronously
          FlutterToast.showToasts(
              // ignore: use_build_context_synchronously
              msg: AppLocalizations.of(context)!.error.toString(),
              context: context);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                // ignore: use_build_context_synchronously
                content: Text(
              // ignore: use_build_context_synchronously
              AppLocalizations.of(context)!.emailverifed.toString(),
              // ignore: use_build_context_synchronously
              style: Theme.of(context).snackBarTheme.contentTextStyle,
            )),
          );
        }
      }
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print("FirebaseAuthException hatasi: ${e.code}");
      // ignore: avoid_print
      print("Hata Mesajı: ${e.message}");
      // ignore: use_build_context_synchronously
      FlutterToast.showToasts(
          // ignore: use_build_context_synchronously
          msg: AppLocalizations.of(context)!.error.toString(),
          context: context);
    }
    return null;
  }

//////////////////////////SIGN IN WITH GOOGLE AND SAVE TO FIRESTORE//////////////////////////////////////////
  Future<User?> signInWithGoogleAndSaveToFirestore() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      await userCollection.doc(userCredential.user!.uid).set({
        "id": userCredential.user!.uid,
        "email": userCredential.user!.email,
        "name": userCredential.user!.displayName ?? "",
        "photoUrl": userCredential.user!.photoURL,
        "phone": '',
        "password": '',
        "timestamp": Timestamp.now()
      });

      return userCredential.user;
    } catch (e) {
      // ignore: avoid_print
      print("error $e");
    }
    return null;
  }

  ////////////////////////////////////// RESET PASSWORD /////////////////////
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print("Error during password reset: $e");
    }
  }
}
// /////////////////////////////////////////OTP/////////////////////////////////////////////////
//   String verificationCode = "";
//   Future<void> verifyOtpAndNavigateToRegisterPage({
//     required String phoneNumber,
//     required Function errorStep,
//   }) async {
//     try {
//       //Telefon numarası doğrulama kodu gönderme
//       await _auth
//           .verifyPhoneNumber(
//             timeout: const Duration(seconds: 60),
//             phoneNumber: phoneNumber,
//             verificationCompleted: (PhoneAuthCredential credential) async {
//               await _auth.signInWithCredential(credential);
//             },
//             verificationFailed: (FirebaseAuthException e) {
//               if (e.code == "Invalid-phone-number") {
//                 Get.snackbar("Error", "The provided phone number is not valid");
//               } else {
//                 Get.snackbar("Error", "Something went wrong.Try again");
//               }
//             },
//             codeSent: (String verificationId, int? resendToken) async{
//               String smsCode = 'xxxxxx'; // Code input by the user
//               PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                 verificationId: verificationId,
//                 smsCode: smsCode,
//               );
//                await _auth.signInWithCredential(credential);
//             },
//             codeAutoRetrievalTimeout: (String verificationId) {
//               verificationCode = verificationId;
//             },
//           )
//           .onError((error, stackTrace) => errorStep());
//     } catch (e) {
//       // Hata durumlarıyla ilgili işlemler...
//     }
//   }

// ////////////////////////////////////////
//   Future<String?> loginwithOtp(
//       {required String otp, required BuildContext context}) async {
//     final cred = PhoneAuthProvider.credential(
//         verificationId: verificationCode, smsCode: otp);
//     try {
//       final user = await _auth.signInWithCredential(cred);
//       if (user.user != null) {
//         return AppLocalizations.of(context)!.succesful.toString();
//       } else {
//         AppLocalizations.of(context)!.error.toString();
//       }
//     } on FirebaseAuthException catch (e) {
//       return e.message.toString();
//     }
//     return null;
//   }