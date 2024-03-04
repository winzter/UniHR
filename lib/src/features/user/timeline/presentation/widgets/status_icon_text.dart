import 'package:flutter/material.dart';
import '../../domain/entities/timeline_entity.dart';
import 'day_detail/day_detail_widgets.dart';

class StatusIconText extends StatelessWidget {
  final TimeLineEntity data;
  const StatusIconText({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        children: [
          if (data.leave!.isNotEmpty) ...[
            Column(
              children: data.leave!
                  .map((e)=>LeaveRequestDetail(leaveData: e))
                  .toList(),
            )
          ],
          if (data.ot!.isNotEmpty) ...[
            const SizedBox(
              height: 5,
            ),
            Column(
              children: data.ot!
                  .map((element) => OtRequestDetail(e: element))
                  .toList(),
            )
          ],
          if (data.requestCompensate!.isNotEmpty) ...[
            const SizedBox(
              height: 5,
            ),
            Column(
              children: data.requestCompensate!
                  .map((element) => RequestTimeCompensate(e: element))
                  .toList(),
            ),
          ],
          if (data.requestTime != null && data.requestTime!.isNotEmpty) ...[
            const SizedBox(
              height: 5,
            ),
            Column(
              children: data.requestTime!
                  .map((element) => RequestTimeDetail(e: element))
                  .toList(),
            ),
          ],
          if (data.requestTime == null &&
              data.ot!.isEmpty &&
              data.requestCompensate!.isEmpty &&
              data.leave == null) ...[Text("-", style: TextStyle())]
        ],
      ),
    );
  }
}
