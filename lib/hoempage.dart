import 'dart:async';

import 'package:flappybird/barriers.dart';
import 'package:flappybird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool gameHasStarted = false;
  static double barrierXOne = 1;
  double barrierXTwo = barrierXOne + 1.25 ;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.5 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });

   setState(() {
     if (barrierXOne < -2){
       barrierXOne += 3;
     } else{
       barrierXOne -= 0.05;
     }

   });

   setState(() {
     if (barrierXTwo < -2){
       barrierXTwo += 3;
     } else{
       barrierXTwo -= 0.05;
     }
   });

      if (birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                        alignment: Alignment(0, birdYaxis),
                        duration: const Duration(microseconds: 0),
                        color: Colors.blue,
                        child: MyBird()),
                    Container(
                      alignment: Alignment(0, -0.5),
                      child: gameHasStarted
                          ? Text("")
                          : const Text(
                              " TAP TO PLAY",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                    ),
                    AnimatedContainer(
                        alignment: Alignment(barrierXOne, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 200.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXOne, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 300.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXTwo, 1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 150.0)),
                    AnimatedContainer(
                        alignment: Alignment(barrierXTwo, -1.1),
                        duration: Duration(milliseconds: 0),
                        child: MyBarrier(size: 250.0))
                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text("0",
                          style: TextStyle(color: Colors.white, fontSize: 35))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Best",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(height: 20),
                      Text("10",
                          style: TextStyle(color: Colors.white, fontSize: 35))
                    ],
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
