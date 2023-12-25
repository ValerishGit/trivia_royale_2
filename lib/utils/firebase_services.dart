import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:trivia_royale_2/modals/player_modal.dart';
import 'package:trivia_royale_2/screens/signin_screen.dart';

import '../widgets/global_widgets.dart';

class FirebaseServices {
  static Future<UserCredential?> firebaseFBLogin() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) return null;
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    try {
      UserCredential? userCred = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      // Once signed in, return the UserCredential
      return userCred;
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      Get.showSnackbar(
          GlobalWidgets.globalSnackBar("Something went wrong", e.message));
    } catch (ge) {
      logger.e(ge);
      Get.showSnackbar(GlobalWidgets.globalSnackBar(
          "Something went wrong", "Please try again later"));
    }
    return null;
  }

  static Future<UserCredential?> firebaseGGLogin() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: ['profile', 'email']).signIn();
    UserCredential? userCred;
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      userCred = await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      Get.showSnackbar(
          GlobalWidgets.globalSnackBar("Something went wrong", e.message));
    } on Exception catch (ge) {
      logger.e(ge);
      Get.showSnackbar(GlobalWidgets.globalSnackBar(
          "Something went wrong", "Please try again later"));
    }

    // Once signed in, return the UserCredential
    return userCred;
  }

  static Future<Player?> getUserByEmail(User user) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(user.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;
        await firestore
            .collection('users')
            .doc(user.uid)
            .update({'lastLogin': Timestamp.now()});
        return Player.fromJson(userMap);
      } else {
        Player newUser = Player().generateNewPlayer(user.email!);
        await firestore.collection('users').doc(user.uid).set(newUser.toJson());

        return newUser;
      }
    } catch (e) {
      Get.offAll(() => SignInScreen());
      return null;
    }
  }

  static Future<List<Player>?> getTop100() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await firestore
          .collection("leaderboard")
          .doc("zKdJgkedk41EtqcNBzxO")
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> userMap = snapshot.data() as Map<String, dynamic>;
        List<dynamic> _players = userMap['users'];
        List<Player> players = _players.map((e) => Player.fromJson(e)).toList();
        players.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));
        return players;
      } else {
        return null;
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  static updateUser({required Player user, required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update(user.toJson());
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}
