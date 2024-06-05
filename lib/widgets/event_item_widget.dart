import 'package:flutter/material.dart';
import 'package:main/constants/types.dart';
import 'package:main/datas/event.dart';

class EventWidget extends StatelessWidget {
  const EventWidget(
      {super.key, required this.curEventList, required this.index});

  final List<Event> curEventList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: (curEventList[index].gender == Gender.man)
                  ? Colors.blueAccent
                  : Colors.redAccent,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  curEventList[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  curEventList[index].location,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            )),
            Text(
              curEventList[index].startTime,
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
