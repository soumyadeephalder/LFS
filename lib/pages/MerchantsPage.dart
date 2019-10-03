import 'package:LFS/pages/ProductPage.dart';
import 'package:LFS/widget/HomeWidgets/Category.dart';
import 'package:LFS/state/merchants.dart';
import 'package:LFS/widget/HomeWidgets/FollowAt.dart';
import 'package:LFS/widget/atoms/Appbar.dart';
import 'package:LFS/widget/atoms/FancyText.dart';
// import 'package:LFS/widget/atoms/FText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:LFS/constants/colors.dart';

class MerchantsPage extends StatelessWidget {
  final String type;
  MerchantsPage({this.type});
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final merchants = Provider.of<MerchantsModel>(context).category(type);
    // print(type);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: FAppbar(
          leadingChoice: false,
        ),
      ),
      body: ListView(
        
          children: merchants.length != 0
              ? <Widget>[
                ////////////////////  TOP HORIZONTAL SCROLLER   ////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                        child: FancyText(
                          text: 'Recommendations',
                          textColor: textColor,
                          size: 20.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                        child: FancyText(
                          onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductsPage()));
                      },
                          text: 'View All',
                          textColor: textColor,
                          size: 10.0,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 120.0,
                    width: 150.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: merchants.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(merchants[index]['media']);
                        return Card(
                          elevation: 2.0,
                          shape: Border.all(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.grey[200]),
                          child: Category(
                            name: merchants[index]['name'],
                            id: merchants[index]['_id'],
                            width: 150.0,
                            height: 80.0,
                            network: merchants[index]['media'] != null
                                ? merchants[index]['media']['src'][0]
                                : null,
                          ),
                        );
                      }, //
                    ),
                  ),
/////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////  MID HORIZONTAL SCROLLER  ////////////////////////////////////////////
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 15.0),
                    child: FancyText(
                      text: 'Best $type Offers & Discounts',
                      textColor: textColor,
                      size: 20.0,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 15.0),
                    child: FancyText(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductsPage()));
                      },
                      text: 'View All Offers',
                      textColor: textColor,
                      size: 10.0,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    height: 200,
                    width: screenWidth,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: merchants.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(merchants[index]['media']);
                        return Card(
                          elevation: 2.0,
                          shape: Border.all(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: Colors.grey[200]),
                          child: Category(
                            name: merchants[index]['name'],
                            id: merchants[index]['_id'],
                            width: screenWidth,
                            height: 150.0,
                            network: merchants[index]['media'] != null
                                ? merchants[index]['media']['src'][0]
                                : null,
                          ),
                        );
                      }, //
                    ),
                  ),
///////////////////////////////////////////////////////////////////////////////////////////////////

                  Padding(padding: EdgeInsets.all(10.0),),
                  Follow(),
                  Padding(padding: EdgeInsets.all(10.0),),
                ]
 ////////////////////////////////  ERROR MESSAGE WHEN NOT CONNECTED TO THE INTERNET ////////////////////               
              : <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 15.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/images/error.png', width: screenWidth*0.80,),
                              FancyText(
                                text: 'Error ocurred! Try again later.',
                                textColor: errorColor,
                                size: 20.0,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      ])
                ]),
    );
  }
}
