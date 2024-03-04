import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabBarMenu extends StatefulWidget {
  final List<Widget> childrenWidget;
  final List<String> svgPaths;
  final List<String> title;
  final double? width;
  const TabBarMenu(
      {super.key,
        required this.childrenWidget,
        required this.svgPaths,
        required this.title,
        this.width});

  @override
  State<TabBarMenu> createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget tabs(int index, double? width) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            gradient:  _tabController.index == index ?const LinearGradient(colors: [
              Color(0xff5C468A),
              Color(0xffE793B8),
              Color(0xffFDC793),
            ]):const LinearGradient(colors: [Colors.transparent,Colors.transparent]),
            border: Border.all(color: Colors.white),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                _tabController.index == index
                    ? Colors.white
                    : const Color(0xffD9D9D9),
                BlendMode.srcIn,
              ),
              child: index == 1
                  ? SvgPicture.asset(
                widget.svgPaths[index],
                width: widget.width,
              )
                  : SvgPicture.asset(
                widget.svgPaths[index],
                width: widget.width,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.title[index],
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          if(widget.width != null)...[
                            const Color(0xff6FC9E4),
                            const Color(0xffE793B8)
                          ]
                          else...[
                            const Color(0xff69EAC6),
                            const Color(0xff6FC9E4),
                            const Color(0xff5B4589),
                          ]
                        ])),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          if(widget.width != null)...[
                            Colors.white.withOpacity(0),
                            Colors.white.withOpacity(0.4)
                          ]
                          else...[
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.5)
                          ]
                        ])
                ),
              ),
            ]
          ),
          primary: false,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).devicePixelRatio
            ),
            child: TabBar(
                overlayColor:MaterialStateProperty.all<Color>(Colors.transparent),
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    _tabController.index = index;
                  });
                },
                splashBorderRadius: const BorderRadius.all(Radius.circular(15)),
                indicator: const BoxDecoration(),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xffD9D9D9),
                tabs: [
                  tabs(0, widget.width),
                  tabs(1, widget.width),
                ]),
          ),
        ),
        body: Stack(
          children:[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        if(widget.width != null)...[
                          const Color(0xff6FC9E4),
                          const Color(0xffE793B8)
                        ]
                        else...[
                          const Color(0xff69EAC6),
                          const Color(0xff6FC9E4),
                          const Color(0xff5B4589),
                        ]
                      ])),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        if(widget.width != null)...[
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(1)
                        ]
                        else...[
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(1)
                        ]
                      ])
              ),
            ),
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: widget.childrenWidget),
          ]
        ),
      ),
    );
  }
}
