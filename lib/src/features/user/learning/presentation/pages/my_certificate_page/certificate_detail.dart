import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../widgets/learning_app_bar.dart';

class CertificateDetail extends StatelessWidget {
  const CertificateDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarLearning(context, "ใบประกาศของฉัน", null),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                          color: const Color(0xffEEEEEE),
                          border: Border.all(width: 10, color: Colors.white)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text(
                            "Building Hybrid Applications with Flutter",
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            // overflow: TextOverflow.ellipsis,
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color(0xff007AFE),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: Text("ดาวน์โหลด",style: TextStyle(fontSize: 15),),
                  ),
                ),
                Row(children: [
                  GradientText("Online Course", colors: const [
                    Color(0xff68D5E8),
                    Color(0xffF394BC),
                  ])
                ],),
                const SizedBox( height: 5,),
                Row(children: [
                  Flexible(child: Text("Building Hybrid Applications with Flutter",style: TextStyle(fontSize: 18),))
                ],),
                const SizedBox( height: 5,),
                Row(children: [
                  Flexible(child: Text("พัฒนาแอปพลิเคชันอย่างมีประสิทธิภาพด้วย React hook",style: TextStyle(color: const Color(0xff757575),fontSize: 12),))
                ],),
                const SizedBox( height: 20,),
                Row(children: [
                  Text("ผู้สอน",style: TextStyle(fontSize: 17),)
                ],),
                const SizedBox( height: 5,),
                ListTile(
                  isThreeLine: true,
                  leading: Icon(Icons.account_circle,size: 60,),
                  title: Text("ปัญจมพงศ์ เสริมสวัสดิ์ศรี"),
                  subtitle: Text("Google Developers Expert in Web Technologies"),
                ),
                const SizedBox( height: 5,),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffEDEDED)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("รายละเอียด",style: TextStyle(fontSize: 17),)
                        ],
                      ),
                      const SizedBox( height: 5,),
                      Row(
                        children: [
                          Flexible(
                            child: ReadMoreText(
                              "ทำงานกับ React มานาน แต่รู้สึกว่าการทำงานไม่มีประสิทธิภาพต้องแก้ อย่างไรดี?แก้ด้วยเครื่องมือเสริมทรงพลัง “React Hooks” ซึ่งเป็นเครื่องมือที่จะช่วยให้เราเขียน React ได้อย่างมีประสิทธิภาพยิ่งขึ้น Code Clean มากขึ้น และ Reuse Components ได้ง่ายขึ้น...",
                              trimLines: 4,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
