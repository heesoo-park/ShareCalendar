import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main/constants/days.dart';
import 'package:main/constants/types.dart';
import 'package:main/datas/event.dart';
import 'package:main/widgets/add_event_widget.dart';
import 'package:main/widgets/event_item_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = Supabase.instance.client;

  List<Event> _selectedEvents = [];
  Map<DateTime, List<Event>> _events = {};
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final response = await db.from('events').select();

    if (response.isNotEmpty) {
      final events = response;
      final Map<DateTime, List<Event>> eventMap = {};

      for (var event in events) {
        final eventData = DateTime.parse(event['start_date']);
        if (!eventMap.containsKey(eventData)) {
          eventMap[eventData] = [];
        }
        eventMap[eventData]!.add(_mappingEventData(event));
      }

      setState(() {
        _events = eventMap;
        _selectedEvents = _getEventsForDay(_selectedDay!);
      });
    } else {
      _showSnackBar('failed fetching data...');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime.parse(DateFormat('yyyy-MM-dd').format(day))] ?? [];
  }

  Event _mappingEventData(Map<String, dynamic> event) {
    return Event(
      title: event['title'],
      location: event['location'],
      gender: Gender.values[event['gender']],
      startDate: event['start_date'],
      startTime: event['start_time'],
    );
  }

  @override
  void dispose() {
    _selectedEvents.clear();
    _events.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> days = ['_', '월', '화', '수', '목', '금', '토', '일'];

    return Scaffold(
      body: SafeArea(
        child: Column(
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
              eventLoader: _getEventsForDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _onDaySelected,
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
                  selectedBuilder: (context, selectedDay, focusedDay) {}),
            ),
            addSchedule(),
            Expanded(
              child: (_selectedEvents.isNotEmpty)
                  ? ListView.builder(
                      itemCount: _selectedEvents.length,
                      itemBuilder: (context, index) {
                        return EventWidget(
                            curEventList: _selectedEvents, index: index);
                      })
                  : const Center(
                      child: Text("일정이 없습니다."),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(selectedDay, focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents = _getEventsForDay(selectedDay);
    });
    if (!isSameDay(_selectedDay, selectedDay)) {}
  }

  Padding addSchedule() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: OutlinedButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) => AddEventDialog(selectedDate: _selectedDay!),
          );

          if (result == true) {
            _fetchEvents();
          }
        },
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
