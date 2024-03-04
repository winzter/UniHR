import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class CourseDescription extends StatelessWidget {
  const CourseDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Flexible(
            child: ReadMoreText(
              "การเปลี่ยนแปลงคือโอกาส แต่สิ่งที่ทำให้เกิดการเปลี่ยนแปลงนั่นคือวิกฤต และวิกฤตคือโอกาส แต่สังเกตไหมว่า ไม่มีใครกล่าวถึงวิธีการเปลี่ยนวิกฤตเป็นโอกาส ดังนั้นแล้วหลักสูตรนี้มีคำตอบให้คุณ ในคอร์สนี้เราจะมีเครื่องมือให้คุณเป็นนักฉวย โอกาสในทุกสถานการณ์ หลายองค์กรนั้นพยายามทำ Digital Transformation มามากกว่า 10 ปี แต่ไม่ว่าจะทำอย่างไรก็ไม่เกิดขึ้นเสียที...",
              trimLines: 5,
              colorClickableText: const Color(0xff275F77),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'อ่านเพิ่มเติม',
              trimExpandedText: 'อ่านน้อยลง',
              style: TextStyle(
                  color: const Color(0xff757575), fontSize: 14),
              lessStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff275F77)),
              moreStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff275F77)),
            ),
          ),
        ],
      ),
    );
  }
}
