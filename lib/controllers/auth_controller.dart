import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:trivia_royale_2/modals/player_modal.dart';
import 'package:trivia_royale_2/utils/firebase_services.dart';

import '../screens/splash_screen.dart';

class AuthController extends GetxController {
  Rx<Player> activeUser = Player().obs;

  Future<void> claimDailyReward() async {
    Player temp = activeUser.value;
    activeUser.update((val) {
      val!.totalPoints += 100;
      val.lastRewardClaimed = Timestamp.now();
    });
    bool res = await FirebaseServices.updateUser(
        user: activeUser.value, uid: FirebaseAuth.instance.currentUser!.uid);

    if (!res) {
      activeUser.update((val) {
        val = temp;
      });
    }
    // Check if the player leveled up
  }

  Future<bool> isLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print(FirebaseAuth.instance.currentUser);
      Player? activePlayer = await FirebaseServices.getUserByEmail(
          FirebaseAuth.instance.currentUser!);
      activeUser(activePlayer);
      return true;
    } else {
      // signed out
      return false;
    }
  }

  Future<bool> signIn(int methodId) async {
    UserCredential? userCred;
    try {
      switch (methodId) {
        case 0:
          //Sign in with facebook
          userCred = await FirebaseServices.firebaseFBLogin();
          break;
        case 1:
          //Sign in with Google
          userCred = await FirebaseServices.firebaseGGLogin();
        default:
      }
      if (userCred == null) return false;
      if (userCred.user == null) return false;
      logger.i(userCred.user);
      Player? activePlayer =
          await FirebaseServices.getUserByEmail(userCred.user!);
      activeUser(activePlayer);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const SplashScreen());
  }
}
