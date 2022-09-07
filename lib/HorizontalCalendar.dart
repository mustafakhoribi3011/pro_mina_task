
import 'package:animated_horizontal_calendar/utils/calender_utils.dart';
import 'package:animated_horizontal_calendar/utils/color.dart';
import 'package:flutter/material.dart';


typedef OnDateSelected(date);

class CustomHorizontalCalendar extends StatefulWidget {
  final DateTime date;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final Color? textColor;
  final Color? colorOfWeek;
  final Color? colorOfMonth;
  final double? fontSizeOfWeek;
  final FontWeight? fontWeightWeek;
  final double? fontSizeOfMonth;
  final FontWeight? fontWeightMonth;
  final Color? backgroundColor;
  final Color? selectedColor;
  final int? duration;
  final Curve? curve;
  final BoxShadow? selectedBoxShadow;
  final BoxShadow? unSelectedBoxShadow;
  final OnDateSelected? onDateSelected;
  final Widget tableCalenderIcon;
  final Color? tableCalenderButtonColor;
  final ThemeData? tableCalenderThemeData;



  CustomHorizontalCalendar({
    Key? key,
    required this.date,
    required this.tableCalenderIcon,
    this.initialDate,
    this.lastDate,
    this.textColor,
    this.curve,
    this.tableCalenderThemeData,
    this.selectedBoxShadow,
    this.unSelectedBoxShadow,
    this.duration,
    this.tableCalenderButtonColor,
    this.colorOfMonth,
    this.colorOfWeek,
    this.fontSizeOfWeek,
    this.fontWeightWeek,
    this.fontSizeOfMonth,
    this.fontWeightMonth,
    this.backgroundColor,
    this.selectedColor,
    @required this.onDateSelected,

  }) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<CustomHorizontalCalendar> {
  DateTime? _startDate;
  var selectedCalenderDate;
  ScrollController _scrollController = new ScrollController();

  calenderAnimation () {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(seconds: widget.duration ?? 1),
      curve: widget.curve ?? Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    selectedCalenderDate = widget.date;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    DateTime findFirstDateOfTheWeek(DateTime dateTime) {
      if (dateTime.weekday == 7) {
        if(_scrollController.hasClients) {
          calenderAnimation();
        }
        return  dateTime;
      } else {
        if(dateTime.weekday == 1 || dateTime.weekday == 2) {
          if(_scrollController.hasClients) {
            calenderAnimation();
          }
        }
        return dateTime.subtract(Duration(days: dateTime.weekday));
      }
    }
    _startDate = findFirstDateOfTheWeek(selectedCalenderDate);

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Container(
        child: Row(
          children: <Widget>[
            ListView.builder(
              itemCount: 7,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DateTime? _date = _startDate?.add(Duration(days: index));
                int? diffDays = _date?.difference(selectedCalenderDate).inDays;
                return Container(
                  padding: EdgeInsets.only(bottom: 40, left: 0.0),
                  child: Container(
                    width: (width - 10) * 0.1428,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: diffDays != 0
                            ? widget.backgroundColor ??
                            Colors.white
                            : widget.tableCalenderButtonColor ?? Colors.blue,
                        border: diffDays == 0 ? Border.all(width:1,color: Colors.blueGrey.shade200): Border.all(color:Colors.blueGrey.shade200, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin: EdgeInsets.only(left: index==0?0:8,right: 8, top: 8),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      onPressed: () {
                        widget.onDateSelected!(Utils.getDate(_date!));
                        setState(() {
                          selectedCalenderDate = _startDate?.add(Duration(days: index));
                          _startDate = _startDate?.add(Duration(days: index));
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            Utils.getDayOfMonth(_date!),
                            style: TextStyle(
                              color: diffDays != 0
                                  ? widget.colorOfMonth ?? primaryTextColor
                                  : Colors.white,
                              fontSize: widget.fontSizeOfMonth ?? 20.0,
                              fontWeight: widget.fontWeightMonth ?? FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            Utils.getDayOfWeek(_date),
                            style: TextStyle(
                                color: diffDays != 0
                                    ? widget.colorOfWeek ?? Colors.blueGrey.shade200
                                    : Colors.white,
                                fontSize: widget.fontSizeOfWeek ?? 12.0,
                                fontWeight: widget.fontWeightWeek ?? FontWeight.w600
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}