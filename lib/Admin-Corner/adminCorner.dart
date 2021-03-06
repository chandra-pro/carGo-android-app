import 'package:cargo/Admin-Corner/add_car.dart';
import 'package:cargo/Login-page/login_screen.dart';
import 'package:cargo/reusable/card.dart';
import 'package:cargo/reusable/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cargo/model/admin_model.dart';

import '../reusable/drawer.dart';

class adminCorner extends StatefulWidget {
  const adminCorner({Key? key}) : super(key: key);

  @override
  State<adminCorner> createState() => _adminCornerState();
}

class _adminCornerState extends State<adminCorner> {
  String? uid = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin's Corner")),
      drawer: MyDarwer(
        curr_page: "Admin's Corner",
      ),
      body: (FirebaseAuth.instance.currentUser != null)
          ? Container(
              decoration: BoxDecoration(color: white),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('admins')
                        .doc(FirebaseAuth.instance.currentUser
                            ?.uid) //FirebaseAuth.instance.currentUser?.uid)
                        .collection('cars')
                        .snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text("Fetch something"),
                          );
                        case ConnectionState.active:
                          //return Container();
                          break;
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Some Error occured"),
                            );
                          }
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("kkfh"),
                              );
                            },
                          );
                      }
                      return (Container());
                    }),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => LoginScreen())));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.login),
                      SizedBox(width: 5),
                      Text("Login to continue"),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AddCar())));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
