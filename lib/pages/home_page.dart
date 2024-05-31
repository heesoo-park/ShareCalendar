import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main/constants/days.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: standardFirstDay,
            lastDay: standardLastDay,
            focusedDay: _focusedDay,
            rowHeight: 44,
            daysOfWeekHeight: 32,
            calendarFormat: _calendarFormat,
            // locale: 'ko_KR', ← 이걸 적용하면 날짜 뒤에 '일'이 붙음
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                return Center(child: Text(days[day.weekday]));
              },
              headerTitleBuilder: (context, day) {
                return Center(
                  child: Text(
                    '${day.year}년 ${day.month}월',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              selectedBuilder: (context, selectedDay, focusedDay) {

              }
            ),
          ),
          addSchedule(),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '일정 ${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '서울대공원',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                          Text(
                            '11:00',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Padding addSchedule() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(44),
        ),
        child: Text(
          "일정 추가",
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
