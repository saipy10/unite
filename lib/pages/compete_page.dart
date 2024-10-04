import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OpponentSearchPage extends StatefulWidget {
  @override
  _OpponentSearchPageState createState() => _OpponentSearchPageState();
}

class _OpponentSearchPageState extends State<OpponentSearchPage> {
  String? opponentId;
  String? currentUserId; // Example: Replace with actual current user ID
  String? matchId;
  bool isInMatch = false;
  int playerMistakes = 0;
  int opponentMistakes = 0;

  @override
  void initState() {
    super.initState();
    // Listen to match updates in case of an ongoing match
    if (matchId != null) {
      listenToMatchUpdates();
    }
    fetchCurrentUserId();
  }

  void fetchCurrentUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid; // Set the current user ID
      });
    } else {
      // Handle the case where the user is not logged in
      print("No user is currently logged in.");
    }
  }

  // Fetch list of available opponents from Firestore
  Stream<QuerySnapshot> getAvailableOpponents() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  // Create or join a match
  Future<void> startMatch(String opponentId) async {
    final matchDoc = await FirebaseFirestore.instance.collection('matches').add({
      'player1': currentUserId,
      'player2': opponentId,
      'player1Mistakes': 0,
      'player2Mistakes': 0,
      'gameStatus': 'ongoing',
    });

    setState(() {
      matchId = matchDoc.id;
      isInMatch = true;
      this.opponentId = opponentId;
    });

    listenToMatchUpdates(); // Listen to match updates
  }

  // Listen for match updates from Firestore
  void listenToMatchUpdates() {
    FirebaseFirestore.instance
        .collection('matches')
        .doc(matchId)
        .snapshots()
        .listen((DocumentSnapshot matchSnapshot) {
      if (matchSnapshot.exists) {
        var matchData = matchSnapshot.data() as Map<String, dynamic>;
        setState(() {
          playerMistakes = currentUserId == matchData['player1']
              ? matchData['player1Mistakes']
              : matchData['player2Mistakes'];
          opponentMistakes = currentUserId == matchData['player1']
              ? matchData['player2Mistakes']
              : matchData['player1Mistakes'];
        });

        // Check if someone has won
        if (matchData['gameStatus'] != 'ongoing') {
          showGameResult(matchData['gameStatus']);
        }
      }
    });
  }

  // Function to increment mistakes when a player makes a mistake
  void makeMistake() async {
    if (!isInMatch || matchId == null) return;

    final matchRef = FirebaseFirestore.instance.collection('matches').doc(matchId);
    final matchSnapshot = await matchRef.get();

    if (matchSnapshot.exists) {
      var matchData = matchSnapshot.data() as Map<String, dynamic>;

      // Determine which player is making the mistake
      String playerField = currentUserId == matchData['player1'] ? 'player1Mistakes' : 'player2Mistakes';
      await matchRef.update({
        playerField: FieldValue.increment(1),
      });

      // Check for a win condition
      if (matchData[playerField] + 1 >= 3) {
        await matchRef.update({
          'gameStatus': currentUserId == matchData['player1'] ? 'player2Won' : 'player1Won',
        });
      }
    }
  }

  // Show result of the game
  void showGameResult(String gameStatus) {
    String message;
    if ((gameStatus == 'player1Won' && currentUserId == 'user1') ||
        (gameStatus == 'player2Won' && currentUserId == 'user2')) {
      message = 'You Won!';
    } else {
      message = 'You Lost!';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      isInMatch = false;
      matchId = null;
      playerMistakes = 0;
      opponentMistakes = 0;
      opponentId = null; // Reset opponent ID
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Opponent'),
      ),
      body: isInMatch
          ? buildGameScreen()
          : buildOpponentSearchScreen(),
    );
  }

  // Widget to search for opponents
  Widget buildOpponentSearchScreen() {
    return StreamBuilder<QuerySnapshot>(
      stream: getAvailableOpponents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            var userId = user.id;

            // Skip displaying current user in the list
            if (userId == currentUserId) return Container();

            return ListTile(
              title: Text('Opponent ${index + 1}'),
              subtitle: Text('User ID: $userId'),
              trailing: ElevatedButton(
                child: Text('Challenge'),
                onPressed: () => startMatch(userId),
              ),
            );
          },
        );
      },
    );
  }

  // Widget to show ongoing game screen
  Widget buildGameScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Your Mistakes: $playerMistakes'),
        Text('Opponent Mistakes: $opponentMistakes'),
        ElevatedButton(
          child: Text('Make Mistake'),
          onPressed: makeMistake,
        ),
      ],
    );
  }
}
