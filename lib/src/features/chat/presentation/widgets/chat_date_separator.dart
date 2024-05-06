import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSeparator extends StatelessWidget {
  const DateSeparator({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            height: 7,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.7),
                  borderRadius: BorderRadius.circular(10)),
              child: DateTime(dateTime.year, dateTime.month, dateTime.day) ==
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day)
                  ? const Text(
                      'Today',
                      style: TextStyle(
                          color: Color.fromRGBO(5, 208, 0, 0.9), fontSize: 12),
                    )
                  : Text(
                      DateFormat().add_d().add_MMMM().add_y().format(dateTime),
                      style: const TextStyle(
                          color: Color.fromRGBO(5, 208, 0, 0.9), fontSize: 12),
                    )),
          const SizedBox(
            height: 7,
          ),
        ],
      ),
    );
  }
}
