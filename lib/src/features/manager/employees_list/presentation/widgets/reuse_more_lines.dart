import 'package:flutter/material.dart';


class ReuseMoreLinesBox extends StatelessWidget {
  final String title;
  final String detail_1;
  final String detail_2;
  final String detail_3;
  final String detail_4;
  final String detail_5;
  final String detail_6;
  final String detail_7;
  final String detail_8;
  final String detail_9;
  final String data_1;
  final String data_2;
  final String data_3;
  final String data_4;
  final String data_5;
  final String data_6;
  final String data_7;
  final String data_8;
  final String data_9;
  const ReuseMoreLinesBox({super.key, required this.title, required this.detail_1, required this.detail_2, required this.detail_3, required this.detail_4, required this.data_1, required this.data_2, required this.data_3, required this.data_4, required this.detail_5, required this.detail_6, required this.detail_7, required this.detail_8, required this.detail_9, required this.data_5, required this.data_6, required this.data_7, required this.data_8, required this.data_9});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(2, 3),
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_1,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                    data_1,
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_2,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_2, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_3,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_3, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_4,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_4, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_5,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                    data_5,
                    style: TextStyle(fontSize: 15),
                  ))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_6,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_6, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_7,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_7, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_8,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_8, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail_9,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Flexible(child: Text(data_9, style: TextStyle(fontSize: 15)))
            ],
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
