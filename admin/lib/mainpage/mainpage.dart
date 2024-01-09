import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ahnduino/Auto.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timer_builder/timer_builder.dart';
import '../singin/signin.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff161619),
            title: Text(
              '끝내시겠습니까?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    Navigator.pop(context, true);
                  },
                  child: Text('끝내기')),
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.pop(context, false);
                  },
                  child: Text('아니요')),
            ],
          );
        });
  }

  Widget buildqwe(Timestamp day) {
    DateTime mutime = day.toDate();
    DateTime theseday = DateTime.now().toUtc().add(Duration(hours: 9));
    return TimerBuilder.periodic(const Duration(seconds: 1),
        builder: (context) {
      return Text(
        '계약 만료일     ' +
            'D-'
                '${mutime.difference(DateTime(theseday.year, theseday.month, theseday.day, mutime.hour, mutime.minute)).inDays}',
        style: TextStyle(
            fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
      );
    });
  }

  Future UserDel(Timestamp day) async {
    DateTime mutime = day.toDate();
    DateTime theseday = DateTime.now().toUtc().add(Duration(hours: 9));
    if (mutime
            .difference(DateTime(theseday.year, theseday.month, theseday.day,
                mutime.hour, mutime.minute))
            .inDays >=
        0) {
      print('안녕하세요');
    }
  }

  @override
  Widget build(BuildContext context) {
    KowananasLayoutInfo layoutInfo =
        KowananasLayoutInfo(MediaQuery.of(context));
    return KowanasLayout(
      data: layoutInfo,
      child: WillPopScope(
          onWillPop: () {
            return _onBackKey();
          },
          child: Scaffold(
              backgroundColor: Color.fromARGB(255, 224, 224, 224),
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Color.fromARGB(255, 230, 235, 238),
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/homegr.png',
                        width: layoutInfo.getWidth(6),
                        height: layoutInfo.getHeight(5),
                      ),
                      Text(
                        'Ahnduino',
                        style: TextStyle(
                            fontSize: 23.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                actions: [
                  IconButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.signOut().whenComplete(
                              () => //Navigator.push(
                                  // context, MaterialPageRoute(builder: (context) => SingIn())));
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SingIn()),
                                      (route) => false));
                        } catch (e) {}
                      },
                      icon: Icon(
                        Icons.person,
                        color: Colors.green,
                        size: 35,
                      )),
                ],
              ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: layoutInfo.getWidth(13),
                      top: layoutInfo.getHeight(5),
                    ),
                    child: Column(children: <Widget>[]),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                child: Row(children: <Widget>[
                  SizedBox(
                    width: layoutInfo.getWidth(13),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/chat.png',
                      ),
                      iconSize: 50,
                    ),
                  ),
                  SizedBox(
                    width: layoutInfo.getWidth(14),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Mainpage()),
                            (route) => false);
                      },
                      icon: Image.asset(
                        'assets/house.png',
                      ),
                      iconSize: 40,
                    ),
                  ),
                  SizedBox(
                    width: layoutInfo.getHeight(7),
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/noti.png',
                      ),
                      iconSize: 40,
                    ),
                  )
                ]),
              ))),
    );
  }
}
