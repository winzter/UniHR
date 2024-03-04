import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final Widget? page;
  const MenuCard({super.key, required this.svgPath, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).devicePixelRatio*7,vertical: MediaQuery.of(context).devicePixelRatio*2),
      child: InkWell(
        onTap: (){
          if(page != null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => page!,));
          }
        },
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image:
              AssetImage('assets/images/rec_full_overview.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: Color(0xffE793B8),
                            fontWeight: FontWeight.w900,
                            fontSize: 22)),
                    SvgPicture.asset(
                      svgPath,
                      width: 70,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 10,
                  child: IconButton(
                    onPressed: (){

                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xffE793B8),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
