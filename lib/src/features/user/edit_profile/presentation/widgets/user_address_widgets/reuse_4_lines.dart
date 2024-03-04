import 'package:flutter/material.dart';
import '../../pages/edit_page/edit_address/edit_address_page.dart';

class Reuse4LinesBox extends StatelessWidget {
  final String title;
  final String detail_1;
  final String detail_2;
  final String detail_3;
  final String detail_4;
  final String data_1;
  final String data_2;
  final String data_3;
  final String data_4;
  const Reuse4LinesBox({super.key, required this.title, required this.detail_1, required this.detail_2, required this.detail_3, required this.detail_4, required this.data_1, required this.data_2, required this.data_3, required this.data_4});

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
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder:
                          (context)=> EditAddressPage(
                        title: title,
                        labels: [detail_1,detail_2,detail_3,detail_4],
                        data: [data_1,data_2,data_3,data_4],
                      )));
                },
                child: Text(
                  "แก้ไข",
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xff007AFE),
                  ),
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
            children: [
              Text(
                detail_2,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Text(data_2, style: TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                detail_3,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Text(data_3, style: TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Text(
                detail_4,
                style: TextStyle(
                    fontSize: 15, color: const Color(0xff757575)),
              ),
              const SizedBox(width: 10,),
              Text(data_4, style: TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
