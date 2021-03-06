import 'package:LFS/constants/colors.dart';
import 'package:LFS/constants/colors.dart' as colors;
import 'package:LFS/pages/EditProfilePage.dart';
import 'package:LFS/pages/FavouritesPage.dart';
import 'package:LFS/pages/UserPrompt.dart';
import 'package:LFS/widget/HomeWidgets/FollowAt.dart';
import 'package:LFS/widget/atoms/RateUs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:LFS/state/user.dart';

class AccountPage extends StatelessWidget {
  final image;
  AccountPage({this.image});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final userData = user.user;

    void userCleanup() {
      user.logOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => UserPrompt()),
          (Route<dynamic> route) => false);
    }

    return ListView(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                children: userData.length > 0
                    ? <Widget>[
                        CircleAvatar(
                          radius: 50.0,
                          child: userData['media'] != null
                              ? Image.network(userData['media'])
                              : Text(
                                  userData['name'].split(' ').reduce((a, b) {
                                    return '${a[0]} ${b[0]}';
                                  }),
                                  style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 24.0,
                                    letterSpacing: 4.0,
                                  ),
                                ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Text(
                              userData['name'],
                              style: TextStyle(
                                  color: colors.navColor,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                            child: Text(
                              userData['email'],
                              style: TextStyle(
                                  color: colors.navColor,
                                  fontFamily: "Helvetica",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        Container(
                          width: 130.0,
                          padding: EdgeInsets.only(top: 10.0),
                          alignment: Alignment.center,
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Icon(
                                  Icons.settings,
                                  size: 16.0,
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontFamily: "Helvetica",
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage()),
                              );
                            },
                          ),
                        ),
                      ]
                    : <Widget>[
                        Container(
                          height: 200.0,
                          alignment: Alignment.center,
                          child: Container(
                            height: 80,
                            width: 80.0,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      ],
              ),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: errorColor,
                ),
                title: Text(
                  'Favourites',
                  style: TextStyle(
                      color: textColor,
                      fontFamily: 'Helvetica',
                      fontSize: 15.0),
                ),
                trailing: Icon(
                  CupertinoIcons.right_chevron,
                  color: navColor,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavouritesPage()),
                  );
                },
              ),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  Icons.star_border,
                  color: buttonColor,
                ),
                title: Text(
                  'Rate us',
                  style: TextStyle(
                      color: textColor,
                      fontFamily: 'Helvetica',
                      fontSize: 15.0),
                ),
                trailing: Icon(
                  CupertinoIcons.right_chevron,
                  color: navColor,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            elevation: 2.0,
                            content: Container(
                              height: 100.0,
                              width: 200.0,
                              child: RateUs(),
                            ),
                          ));
                },
              ),
            ),
            Container(
              child: ListTile(
                  leading: Icon(
                    Icons.thumb_up,
                    color: deepBlue,
                  ),
                  title: Text(
                    'Like',
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'Helvetica',
                        fontSize: 15.0),
                  ),
                  trailing: Icon(
                    CupertinoIcons.right_chevron,
                    color: navColor,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        elevation: 2.0,
                        content: Container(
                          height: 150.0,
                          width: 200.0,
                          child: Follow(
                            fontFamily: 'Bree',
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.share_solid,
                  color: Colors.amber,
                ),
                title: Text(
                  'Share',
                  style: TextStyle(
                      color: textColor,
                      fontFamily: 'Helvetica',
                      fontSize: 15.0),
                ),
                trailing: Icon(
                  CupertinoIcons.right_chevron,
                  color: navColor,
                ),
                onTap: () {},
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.center,
          child: RaisedButton(
            color: Colors.white,
            child: Text(
              "Logout",
              style: TextStyle(
                  color: errorColor,
                  fontFamily: "Helvetica",
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: userCleanup,
          ),
        ),
      ],
    );
  }
}
