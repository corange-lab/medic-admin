import 'package:flutter/material.dart';
import 'package:medic_admin/constans/app_constants.dart';
import 'package:medic_admin/shared_components/card_task.dart';

class TaskInProgress extends StatelessWidget {
  final List<CardTaskData> data;

  const TaskInProgress({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(kBorderRadius * 2),
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
            child: CardTask(
              data: data[index],
              primary: _getSequenceColor(index),
              onPrimary: Colors.white,
              index: index,
            ),
          ),
        ),
      ),
    );
  }

  Color _getSequenceColor(int index) {
    int val = index % 4;
    if (val == 3) {
      return Colors.indigo;
    } else if (val == 2) {
      return Colors.grey;
    } else if (val == 1) {
      return Colors.redAccent;
    } else {
      return Colors.lightBlue;
    }
  }
}
