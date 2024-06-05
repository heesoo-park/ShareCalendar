import 'package:hive/hive.dart';
import 'package:main/constants/types.dart';

// data class를 Hive에서 사용하려고 할 때 필요한 터미널 명령어
// flutter packages pub run build_runner build

// part 'event.g.dart';

@HiveType(typeId: 1)
class Event {
  Event({
    required this.title,
    required this.location,
    required this.gender,
    required this.startDate,
    required this.startTime,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  String location;
  @HiveField(2)
  Gender gender;
  @HiveField(3)
  String startDate;
  String startTime;
}
