import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController initialTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  List<String> categories=[
    'Development',
    'Research',
    'Design',
    'Backend',
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
    ));
     double height = MediaQuery.of(context).size.height;
     double width = MediaQuery.of(context).size.width;
     return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SafeArea(
        child: Column(
          children: [
            Padding(
              padding:EdgeInsets.only(left:width*0.05,right:width*0.05,top:height*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(onTap:(){Navigator.pop(context);},child: Icon(Icons.arrow_back_ios_new_outlined)),
                  Icon(Icons.menu_outlined),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.03,top:height*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Create New Task',style:TextStyle(fontSize:22,fontWeight: FontWeight.bold),),
                  Icon(Icons.task_outlined,size:40,color:Colors.blue.shade200,),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.05,top:height*0.04),
              child: TextFormField(
                style:TextStyle(fontSize:16,fontWeight: FontWeight.bold,height:2,),
                showCursor:false,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue.shade200),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue.shade200),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue.shade200,),
                  ),
                  label: Text('Task Name'),
                  floatingLabelStyle:TextStyle(color: Colors.blue.shade200,fontWeight: FontWeight.bold,fontSize:16),
                  labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:16),
                ),
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.05,top:height*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Category',style:TextStyle(fontSize:14,fontWeight: FontWeight.bold,color: Colors.blue.shade200),),
                  Text('See all',style:TextStyle(fontSize:11,color: Colors.blue.shade300),),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,top:height*0.03),
              child: Container(height:height*0.04,child: ListView.separated(itemBuilder:(context,index)=>
                  index==0?Container(width:width*0.3,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blue.shade300),child:Center(child: Text(categories[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:13),)),):index==3?
                  Row(
                    children: [
                      Container(width:width*0.3,decoration:BoxDecoration(border: Border.all(
                        color: Colors.blue.shade300,
                        width: 1.5,
                      ),borderRadius: BorderRadius.circular(10),color:Colors.white),child:Center(child: Text(categories[index],style:TextStyle(color: Colors.blue.shade300,fontWeight: FontWeight.bold,fontSize:13),)),),
                      SizedBox(width:10,),
                    ],
                  ):Container(width:width*0.3,decoration:BoxDecoration(border: Border.all(
                    color: Colors.blue.shade300,
                    width: 1.5,
                  ),borderRadius: BorderRadius.circular(10),color:Colors.white),child:Center(child: Text(categories[index],style:TextStyle(color: Colors.blue.shade300,fontWeight: FontWeight.bold,fontSize:13),)),), separatorBuilder:(context,index)=>SizedBox(width:15,), itemCount: 4,scrollDirection: Axis.horizontal,)),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.05,top:height*0.04),
              child: Row(
                children: [
                  Container(
                    width:width*0.6,
                    child: TextFormField(
                      controller:dateController,
                      onTap: (){
                        showDatePicker(context: context,initialDate:DateTime.now(), firstDate:DateTime.now(), lastDate:DateTime.parse('2023-01-01')).then((value){
                          dateController.text =DateFormat.yMMMd().format(value!);
                        });
                      },
                      readOnly: true,
                      style:TextStyle(fontSize:16,fontWeight: FontWeight.bold,height:2,),
                      showCursor:false,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200,),
                        ),
                        label: Text('Date'),
                        floatingLabelStyle:TextStyle(color: Colors.blue.shade200,fontWeight: FontWeight.bold,fontSize:16),
                        labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:16),
                      ),
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(backgroundColor: Colors.blue.shade200,radius:20,child: Icon(Icons.calendar_today_rounded,size:20,color:Colors.white,)),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.05,top:height*0.04),
              child: Row(
                children: [
                  Container(
                    width:width*0.35,
                    child: TextFormField(
                      controller:initialTimeController,
                      onTap: (){
                        showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value){
                          initialTimeController.text= value!.format(context).toString();
                        });
                      },
                      readOnly: true,
                      style:TextStyle(fontSize:16,fontWeight: FontWeight.bold,height:2,),
                      showCursor:false,
                      decoration: InputDecoration(
                        suffix:Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue.shade200,),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200,),
                        ),
                        label: Text('Start time'),
                        floatingLabelStyle:TextStyle(color: Colors.blue.shade200,fontWeight: FontWeight.bold,fontSize:16),
                        labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:16),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width:width*0.35,
                    child: TextFormField(
                      controller:endTimeController,
                      onTap: (){
                        showTimePicker(context: context, initialTime:TimeOfDay.now()).then((value){
                          endTimeController.text= value!.format(context).toString();
                        });
                      },
                      readOnly: true,
                      style:TextStyle(fontSize:16,fontWeight: FontWeight.bold,height:2,),
                      showCursor:false,
                      decoration: InputDecoration(
                        suffix:Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blue.shade200,),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color:Colors.blue.shade200,),
                        ),
                        label: Text('End time'),
                        floatingLabelStyle:TextStyle(color: Colors.blue.shade200,fontWeight: FontWeight.bold,fontSize:16),
                        labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(left:width*0.065,right:width*0.05,top:height*0.04),
              child: Container(
                width:width*0.9,
                child: TextFormField(
                  style:TextStyle(fontSize:14,fontWeight: FontWeight.bold,height:2,),
                  showCursor:false,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.blue.shade200),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.blue.shade200),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color:Colors.blue.shade200,),
                    ),
                    label: Text('Description'),
                    floatingLabelStyle:TextStyle(color: Colors.blue.shade200,fontWeight: FontWeight.bold,fontSize:16),
                    labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:16),
                  ),
                ),
              ),
            ),
            SizedBox(height:height*0.05,),
            Container(height:height*0.05,width:width*0.5,decoration:BoxDecoration(borderRadius: BorderRadius.circular(10),color:Colors.blue.shade300),child:Center(child: Text('Create Task',style:TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.bold),)),),
          ],
        ),
      ),
    );
  }
}
