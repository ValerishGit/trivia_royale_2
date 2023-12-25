import 'package:get/get.dart';
import 'package:trivia_royale_2/utils/firebase_services.dart';

import '../modals/player_modal.dart';

class LeaderboardController extends GetxController {
  RxList<Player> players = <Player>[].obs;

  Future<List<Player>> getTop100() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    List<Player>? p = await FirebaseServices.getTop100();
    if (p == null) return [];
    players(p);
    return p;
  }
}
