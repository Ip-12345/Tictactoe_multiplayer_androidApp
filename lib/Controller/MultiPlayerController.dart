import 'package:basico/Configs/AssestsPath.dart';
import 'package:basico/Models/RoomModel.dart';
import 'package:basico/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MultiPlayerController extends GetxController {
  ConfettiController confettiController =
      ConfettiController(duration: Duration(seconds: 2));
  final db = FirebaseFirestore.instance;

  Stream<RoomModel> getRoomDetails(String roomId) {
    return db
        .collection("rooms")
        .doc(roomId)
        .snapshots()
        .map((event) => RoomModel.fromJson(event.data()!));
  }

  Future<void> updateData(String roomId, List<String> gameValue, int index,
      bool isXTurn, RoomModel roomData) async {
    List<String> oldValue = gameValue;
    if (isXTurn) {
      if (oldValue[index] == '') {
        oldValue[index] = "X";
        print(oldValue);
        await db
            .collection("rooms")
            .doc(roomId)
            .update({"gameValue": oldValue, "isXTurn": false});
      }
    } else if (!isXTurn) {
      if (oldValue[index] == '') {
        oldValue[index] = "O";
        print(oldValue);
        await db
            .collection("rooms")
            .doc(roomId)
            .update({"gameValue": oldValue, "isXTurn": true});
      }
    }

    checkWinner(oldValue, roomData);
  }

  Future<dynamic> WinnerDialog(String winner, RoomModel roomData) {
    //scoreCalculate(winner);
    confettiController.play();
    return Get.bottomSheet(
        isDismissible: false,
        Container(
            height: 280,
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: winner == "noone"
                  ? Column(
                      children: [
                        Text('Match Draw', style: TextStyle(fontSize: 18)),
                        Text('You Both Played Well',
                            style: TextStyle(fontSize: 12)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  resetPlayValue(roomData);
                                },
                                child: Text('Play Again')),
                            ElevatedButton(
                                onPressed: () {
                                  Get.offAllNamed('/home');
                                },
                                child: Text('Exit'))
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        SvgPicture.asset(IconsPath.winIcon, width: 100),
                        SizedBox(height: 20),
                        Text('Congratulations', style: TextStyle(fontSize: 18)),
                        Text('$winner won the match',
                            style: TextStyle(fontSize: 12)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  playAgain(winner, roomData);
                                  Get.back();
                                },
                                child: Text('Play Again')),
                            ElevatedButton(
                                onPressed: () {
                                  Get.offAllNamed('/home');
                                },
                                child: Text('Exit'))
                          ],
                        )
                      ],
                    ),
            )));
  }

  void checkWinner(List<String> playValue, RoomModel roomData) {
    if (playValue[0] == playValue[1] &&
        playValue[0] == playValue[2] &&
        playValue[0] != "") {
      print("Winner is ${playValue[0]}");
      WinnerDialog(playValue[0], roomData);
    } else if (playValue[3] == playValue[4] &&
        playValue[3] == playValue[5] &&
        playValue[3] != "") {
      print("Winner is ${playValue[3]}");
      WinnerDialog(playValue[3], roomData);
    } else if (playValue[6] == playValue[7] &&
        playValue[6] == playValue[8] &&
        playValue[6] != "") {
      print("Winner is ${playValue[6]}");
      WinnerDialog(playValue[6], roomData);
    } else if (playValue[0] == playValue[3] &&
        playValue[0] == playValue[6] &&
        playValue[0] != "") {
      print("Winner is ${playValue[0]}");
      WinnerDialog(playValue[0], roomData);
    } else if (playValue[1] == playValue[4] &&
        playValue[1] == playValue[7] &&
        playValue[1] != "") {
      print("Winner is ${playValue[1]}");
      WinnerDialog(playValue[1], roomData);
    } else if (playValue[2] == playValue[5] &&
        playValue[2] == playValue[8] &&
        playValue[2] != "") {
      print("Winner is ${playValue[2]}");
      WinnerDialog(playValue[2], roomData);
    } else if (playValue[0] == playValue[4] &&
        playValue[0] == playValue[8] &&
        playValue[0] != "") {
      print("Winner is ${playValue[0]}");
      WinnerDialog(playValue[0], roomData);
    } else if (playValue[2] == playValue[4] &&
        playValue[2] == playValue[6] &&
        playValue[2] != "") {
      print("Winner is ${playValue[2]}");
      WinnerDialog(playValue[2], roomData);
    } else {
      if (!playValue.contains("")) {
        WinnerDialog("noone", roomData);
      }
    }
  }

  Future<void> playAgain(String wonTeam, RoomModel roomData) async {
    if (wonTeam == 'X') {
      String totalWins = roomData.player1!.totalWins!;
      int totalWin = int.parse(totalWins);
      totalWin = totalWin + 1;
      UserModel newPlayer1 = UserModel(
        id: roomData.player1!.id,
        email: roomData.player1!.email,
        image: roomData.player1!.image,
        name: roomData.player1!.name,
        role: roomData.player1!.role,
        totalCoins: roomData.player1!.totalCoins,
        totalWins: totalWin.toString(),
        yourTurn: roomData.player1!.yourTurn,
      );

      await db.collection("rooms").doc(roomData.id).update({
        "gameValue": ["", "", "", "", "", "", "", "", ""],
        "player1": newPlayer1.toJson()
      });
    } else if (wonTeam == 'O') {
      String totalWins = roomData.player2!.totalWins!;
      int totalWin = int.parse(totalWins);
      totalWin = totalWin + 1;
      UserModel newPlayer2 = UserModel(
        id: roomData.player2!.id,
        email: roomData.player2!.email,
        image: roomData.player2!.image,
        name: roomData.player2!.name,
        role: roomData.player2!.role,
        totalCoins: roomData.player2!.totalCoins,
        totalWins: totalWin.toString(),
        yourTurn: roomData.player2!.yourTurn,
      );

      await db.collection("rooms").doc(roomData.id).update({
        "gameValue": ["", "", "", "", "", "", "", "", ""],
        "player2": newPlayer2.toJson()
      });
    }
  }

  Future<void> resetPlayValue(RoomModel roomData) async {
    await db.collection("rooms").doc(roomData.id).update({
      "gameValue": ["", "", "", "", "", "", "", "", ""]
    });
    Get.back();
  }
}
