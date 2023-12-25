const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

const firestore = admin.firestore();

exports.updateLeaderboard = functions.firestore
  .document('users/{userId}')
  .onUpdate((change, context) => {
    const userId = context.params.userId;

    const afterData = change.after.data();
    const beforeData = change.before.data();

    // Check if the totalPoints field has changed
    if (afterData.totalPoints !== beforeData.totalPoints) {
      const playerData = {
        uid: userId,
        displayName: afterData.displayName, // Assuming 'displayname' is a field in your user document
        totalPoints: afterData.totalPoints,
        avatarUrl :afterData.avatarUrl
      };

      // Get the current leaderboard document
      const leaderboardDocRef = firestore.collection('leaderboard').doc('zKdJgkedk41EtqcNBzxO');
      
      return firestore.runTransaction(async (transaction) => {
        const leaderboardDoc = await transaction.get(leaderboardDocRef);

        if (!leaderboardDoc.exists) {
          // If the leaderboard document doesn't exist, create it with the user's data
          transaction.set(leaderboardDocRef, { users: [playerData] });
        } else {
          // If the leaderboard document exists, update the user's totalPoints or add if doesn't exist
          const leaderboardData = leaderboardDoc.data();
          const users = leaderboardData.users || [];

          const userIndex = users.findIndex(user => user.uid === userId);

          if (userIndex !== -1) {
            // User already exists in the leaderboard, update the totalPoints
            users[userIndex].totalPoints = afterData.totalPoints;
            users[userIndex].displayName = afterData.displayName;
            users[userIndex].avatarUrl = afterData.avatarUrl;
          } else {
            // User doesn't exist in the leaderboard, add the user
            users.push(playerData);
          }

          transaction.update(leaderboardDocRef, { users });
        }
      });
    }

    return null;
  });