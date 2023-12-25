import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trivia_royale_2/utils/helpers.dart';

class Player {
  String? displayName;
  int totalPoints;
  String? emailAdd;
  int xp; // Experience points
  int level; // Player's level in the game
  String? avatarUrl; // URL to the player's avatar image
  Timestamp? lastLogin; // Date and time of the player's last login
  List<String>? achievements; // List of achievements the player has earned
  int gamesPlayed; // Number of games the player has played
  int gamesWon; // Number of games the player has won
  int totalQuestionsAnswered; // Total questions answered by the player
  double? averageScore;
  Timestamp? lastRewardClaimed; // Average score per game
  // Add more fields as needed

  // Constants for leveling up
  static const int xpPerLevel = 100; // Adjust as needed
  static const int initialLevel = 1;

  Player(
      {this.displayName,
      this.emailAdd,
      this.totalPoints = 0,
      this.xp = 0,
      this.level = initialLevel,
      this.avatarUrl = '',
      this.lastLogin,
      this.achievements = const [],
      this.gamesPlayed = 0,
      this.gamesWon = 0,
      this.totalQuestionsAnswered = 0,
      this.averageScore = 0.0,
      this.lastRewardClaimed});

  Player generateNewPlayer(String email) {
    String randomUsername = HelperFunctions.generateRandomName();
    randomUsername = randomUsername.replaceAll(' ', '');
    return Player(
        displayName: randomUsername,
        emailAdd: email,
        avatarUrl: "https://api.multiavatar.com/$randomUsername.png",
        totalPoints: 1000,
        lastLogin: Timestamp.now());
  }

  // Method to increase the player's score and XP

  // Method to handle leveling up
  void levelUp() {
    level++;
    // You can add additional logic or rewards here
  }

  void updateScore(int score) {
    totalPoints += score;
    // You can add additional logic or rewards here
  }

  // Method to reset the player's score and XP

  // Method to update player statistics after a game
  void updateStatistics(
      bool won, int questionsAnswered, int pointsScored, int xpEarned) {
    gamesPlayed++;
    totalQuestionsAnswered += questionsAnswered;
    averageScore = totalQuestionsAnswered == 0
        ? 0
        : (totalPoints / totalQuestionsAnswered);
    if (won) {
      gamesWon++;
    }
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        displayName: json['displayName'],
        emailAdd: json['emailAdd'],
        totalPoints: json['totalPoints'],
        xp: json['xp'] ?? 0,
        level: json['level'] ?? initialLevel,
        avatarUrl: json['avatarUrl'] ?? '',
        lastLogin: json['lastLogin'],
        achievements: List<String>.from(json['achievements'] ?? []),
        gamesPlayed: json['gamesPlayed'] ?? 0,
        gamesWon: json['gamesWon'] ?? 0,
        totalQuestionsAnswered: json['totalQuestionsAnswered'] ?? 0,
        averageScore: json['averageScore'] ?? 0.0,
        lastRewardClaimed: json['lastRewardClaimed']);
  }

  // Method to convert a Player object to a Map
  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'emailAdd': emailAdd,
      'totalPoints': totalPoints,
      'xp': xp,
      'level': level,
      'avatarUrl': avatarUrl,
      'lastLogin': lastLogin!,
      'achievements': achievements,
      'gamesPlayed': gamesPlayed,
      'gamesWon': gamesWon,
      'totalQuestionsAnswered': totalQuestionsAnswered,
      'averageScore': averageScore,
      'lastRewardClaimed': lastRewardClaimed
    };
  }

  // Method to display player information
}
