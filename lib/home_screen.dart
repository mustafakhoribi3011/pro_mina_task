import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_mina_task/HorizontalCalendar.dart';
import 'package:pro_mina_task/tasks_screen.dart';
import 'package:animated_horizontal_calendar/animated_horizontal_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Monday", "2" : "Tuesday", "3" : "Wednesday", "4" : "Thursday", "5" : "Friday", "6" : "Saturday", "7" : "Sunday" }';

    dynamic monthData =
        '{ "1" : "January", "2" : "February", "3" : "March", "4" : "April", "5" : "May", "6" : "June", "7" : "July", "8" : "August", "9" : "September", "10" : "October", "11" : "November", "12" : "December" }';

    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] ;}
  var selectedDate;
  var formattedDate;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
    ));
    double height = MediaQuery.of(context).size.height;
    print(height);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width*0.725,
                  height: height*0.137,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(top:10,left: 25),
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.grey.shade700,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.notifications_outlined,
                          color: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          width:width*0.27,
                          height: height*0.137,
                          color: Colors.white,
                        ),
                        Container(
                          height: height*0.137,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50))),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10),
                            child: Center(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: width,
                  height: height*0.285,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left: width*0.06, right: width*0.06, top: height*0.02),
                        child: Row(
                          children: [
                            Text(
                              'My Task',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder:(context)=>TasksScreen()));
                              },
                              child: Container(
                                height: height*0.055,
                                width: width*0.11,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height*0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width*0.06,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              formattedDate==null?dateFormatter(DateTime.now()):formattedDate,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.blueGrey.shade300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:height*0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left:width*0.01,
                        ),
                        child: Container(
                          height: height*0.13,
                          child: CustomHorizontalCalendar(
                              tableCalenderIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              date: DateTime.now(),
                              textColor: Colors.black45,
                              backgroundColor: Colors.white,
                              tableCalenderThemeData:
                              ThemeData.light().copyWith(
                                primaryColor: Colors.green,
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary),
                                colorScheme:
                                ColorScheme.light(primary: Colors.green)
                                    .copyWith(secondary: Colors.red),
                              ),
                              selectedColor: Colors.redAccent,
                              onDateSelected: (date) {
                                setState(() {
                                  selectedDate = date;
                                  final parsedDate = DateTime.parse(selectedDate);
                                  formattedDate=dateFormatter(parsedDate);
                                  print(formattedDate);
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      width: width,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius:
                          BorderRadius.only(topRight: Radius.circular(35))),
                    ),
                    Align(alignment: Alignment.centerLeft,child:Padding(
                      padding:  EdgeInsets.only(left:width*0.04),
                      child: Padding(
                        padding:  EdgeInsets.only(top:height*0.04,),
                        child: Scrollbar(isAlwaysShown: true,thickness: 3,radius: Radius.circular(10),scrollbarOrientation: ScrollbarOrientation.left,child: Padding(
                          padding:EdgeInsets.only(left:width*0.07,),
                          child: Container(height:height*0.6,width:width*0.87,child: ListView.separated(itemBuilder:(context,index)=>
                          index==0?
                          Container(
                            height:height*0.225,
                            child: Stack(
                              children: [
                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),height:height*0.2,width:width*0.842,
                                  child:Padding(
                                    padding:EdgeInsets.symmetric(horizontal:width*0.06),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height:height*0.047,
                                                  width:width*0.093,
                                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),border: Border.all(width: 1.5,color:Colors.red)),
                                                ),
                                                SizedBox(width:8,),
                                                Container(
                                                  height:height*0.047,
                                                  width:width*0.093,
                                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),border: Border.all(width: 1.5,color:Colors.red)),
                                                ),                                              ],
                                            ),
                                            SizedBox(height:8,),
                                            Row(
                                              children: [
                                                Container(
                                                  height:height*0.047,
                                                  width:width*0.093,
                                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),border: Border.all(width: 1.5,color:Colors.red)),
                                                ),
                                                SizedBox(width:8,),
                                                Container(
                                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(7)),border: Border.all(width: 1.5,color:Colors.blue.shade300)),
                                                  height:height*0.047,
                                                  width:width*0.093,
                                                  child:Icon(Icons.add,color:Colors.blue.shade300,size:20,),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Team Meeting',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                                            SizedBox(height:5,),
                                            Row(
                                              children: [
                                                SizedBox(width:width*0.015,),
                                                Container(width:width*0.32,child: Text('Discuss all questions about new projects',textAlign: TextAlign.end,style: TextStyle(fontSize:12,color: Colors.blue.shade200),)),
                                              ],
                                            ),
                                          ],)
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(top:height*0.17,left:width*0.65,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomRight:Radius.circular(10)),color: Colors.black),height:height*0.043,width:width*0.205,
                                  child:Center(child: Text('10:00 Am',style:TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.bold),)),
                                )),
                              ],
                            ),
                          ):
                          Container(
                            height:height*0.225,
                            child: Stack(
                              children: [
                                Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),height:height*0.2,width:width*0.842,
                                  child:Padding(
                                    padding:EdgeInsets.symmetric(horizontal:width*0.06),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(Icons.call,size:70,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Call the stylist',style: TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
                                            SizedBox(height:height*0.01,),
                                            Row(
                                              children: [
                                                SizedBox(width:width*0.015,),
                                                Container(width:width*0.32,child: Text('Agree on an evening look',textAlign: TextAlign.end,style: TextStyle(fontSize:12,color: Colors.blue.shade200),)),
                                              ],
                                            ),
                                          ],)
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(top:height*0.17,left:width*0.65,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(10),bottomRight:Radius.circular(10)),color: Colors.black),
                                  height:height*0.043,width:width*0.205,
                                  child:Center(child: Text('11:00 Am',style:TextStyle(fontSize:13,color: Colors.white,fontWeight: FontWeight.bold),)),
                                )),
                              ],
                            ),
                          ), separatorBuilder:(context,index)=>SizedBox(height:height*0.03,), itemCount: 5)),
                        )),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
