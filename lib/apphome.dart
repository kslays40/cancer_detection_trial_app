import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trial_app/coloncancerpage.dart';
import 'package:trial_app/lungcancerpage.dart';
import 'package:trial_app/skincancerpage.dart';
import 'breastcancerpage.dart';

class apphome extends StatefulWidget {
  const apphome({Key? key}) : super(key: key);

  @override
  State<apphome> createState() => _apphomeState();
}

class _apphomeState extends State<apphome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homepage(),
    );
  }
}


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  static const inactivecardcolor = Color(0xFF111f4e);
  static const activecardcolor = Color(0xff21a2dd);

  Color card1 = inactivecardcolor;
  Color card2 = inactivecardcolor;
  Color card3 = inactivecardcolor;
  Color card4 = inactivecardcolor;

  void colorchanger(int cvalue) {
    if (cvalue == 1) {
      if (card1 == inactivecardcolor) {
        card1 = activecardcolor;
        card2 = inactivecardcolor;
        card3 = inactivecardcolor;
        card4 = inactivecardcolor;
      } else {
        card1 = inactivecardcolor;
      }
    }
    if (cvalue == 2) {
      if (card2 == inactivecardcolor) {
        card2 = activecardcolor;
        card1 = inactivecardcolor;
        card3 = inactivecardcolor;
        card4 = inactivecardcolor;
      } else {
        card2 = inactivecardcolor;
      }
    }
    if (cvalue == 3) {
      if (card3 == inactivecardcolor) {
        card3 = activecardcolor;
        card1 = inactivecardcolor;
        card2 = inactivecardcolor;
        card4 = inactivecardcolor;
      } else {
        card3 = inactivecardcolor;
      }
    }
    if (cvalue == 4) {
      if (card4 == inactivecardcolor) {
        card4 = activecardcolor;
        card1 = inactivecardcolor;
        card3 = inactivecardcolor;
        card2 = inactivecardcolor;
      } else {
        card4 = inactivecardcolor;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000628),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            Row(
              children: [
                SizedBox(width: 10.0,),
                Lottie.asset(
                  'images/112563-home.json',
                  width: 70.0,
                  height: 70.0,
                )
              ],
            ),
            SizedBox(height: 50.0,),
            Row(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () {
                    setState(() {
                      colorchanger(1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => breastcanchomepage()),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: card1,
                      borderRadius: BorderRadius.all(Radius.circular(50),),
                    ),
                    height: 150.0,
                    child: Center(child: Text('Breast Cancer', style: TextStyle(color: Colors.white),)),
                  ),
                ),
                ),
                SizedBox(width: 30.0,),
                Expanded(child: GestureDetector(
                  onTap: () {
                    setState(() {
                      colorchanger(2);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => lungcanchomepage()),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: card2,
                      borderRadius: BorderRadius.all(Radius.circular(50),),
                    ),
                    height: 150.0,
                    child: Center(child: Text('Lung Cancer', style: TextStyle(color: Colors.white),)),
                  ),
                ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                Expanded(child: GestureDetector(
                  onTap: () {
                    setState(() {
                      colorchanger(3);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => coloncanchomepage()),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: card3,
                      borderRadius: BorderRadius.all(Radius.circular(50),),
                    ),
                    height: 150.0,
                    child: Center(child: Text('Colon Cancer', style: TextStyle(color: Colors.white),)),
                  ),
                ),
                ),
                SizedBox(width: 30.0,),
                Expanded(child: GestureDetector(
                  onTap: () {
                    setState(() {
                      colorchanger(4);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => skincanchomepage()),
                      );
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: card4,
                      borderRadius: BorderRadius.all(Radius.circular(50),),
                    ),
                    height: 150.0,
                    child: Center(child: Text('Skin Cancer', style: TextStyle(color: Colors.white),)),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF111f4e),
        child: const Icon(Icons.info_outline_rounded),
      ),
    );
  }
}
