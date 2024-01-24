import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class CalenderWidget extends StatefulWidget {
  final List<DateTime> unavailableDays;
  final void Function(DateTime? start, DateTime? end) onRangeSelect;

  const CalenderWidget({Key? key, required this.unavailableDays, required this.onRangeSelect}) : super(key: key);

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null;
            _rangeEnd = null;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
            widget.onRangeSelect(_selectedDay, null);

          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
          widget.onRangeSelect(_rangeStart, _rangeEnd);
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      enabledDayPredicate: (date) {
        for (DateTime unavailableDate in widget.unavailableDays) {
          if (date.day == unavailableDate.day && date.month == unavailableDate.month && unavailableDate.year == date.year) {
            return false;
          }
        }
        return true;
      },
      calendarBuilders: CalendarBuilders(
        disabledBuilder: (context, day, _) {
          return Center(
            child: Text(
              '${day.day}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
      ),
    );
  }
}
