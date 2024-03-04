import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:video_player/video_player.dart';
import '../widgets/course_code.dart';
import '../widgets/online_course_page/widgets.dart';


class CourseOnlinePage extends StatefulWidget {
  const CourseOnlinePage({super.key});

  @override
  State<CourseOnlinePage> createState() => _CourseOnlinePageState();
}

class _CourseOnlinePageState extends State<CourseOnlinePage> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;

  Duration previousPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video End');
      }
    });
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"));
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: false,
      looping: false,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 1),
    );
  }

  // int currPlayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CourseAppbar(context, "คอร์สออนไลน์"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _chewieController!
                        .videoPlayerController.value.aspectRatio,
                    child: Chewie(
                      controller: _chewieController!,
                    ),
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('กำลังโหลด'),
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).devicePixelRatio * 3,
                horizontal: MediaQuery.of(context).devicePixelRatio * 3,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        GradientText("Bussiness", colors: const [
                          Color(0xff68D5E8),
                          Color(0xffF394BC),
                        ])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Flexible(
                            child: Text(
                          "Designing AR Experience for Non-Developers",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ))
                      ],
                    ),
                  ),
                  CourseDescription(),
                  CourseOutline(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text(
                          "หมายเหตุ",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        SvgPicture.asset(
                          "assets/icons/learning_user/warning.svg",
                          width: 20,
                        ),
                        Text(
                          " A Mac or Windows Computer",
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  CourseCode(),
                  Ads(),
                ],
              ),
            ),
            const Divider(
              thickness: 3,
              indent: 15,
              endIndent: 15,
            ),
            CourseCompany(),
            CompanyDetail(),
            const Divider(
              thickness: 3,
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController1.dispose();
    _chewieController!.dispose();
  }
}

class DelaySlider extends StatefulWidget {
  const DelaySlider({Key? key, required this.delay, required this.onSave})
      : super(key: key);

  final int? delay;
  final void Function(int?) onSave;

  @override
  State<DelaySlider> createState() => _DelaySliderState();
}

class _DelaySliderState extends State<DelaySlider> {
  int? delay;
  bool saved = false;

  @override
  void initState() {
    super.initState();
    delay = widget.delay;
  }

  @override
  Widget build(BuildContext context) {
    const int max = 1000;
    return ListTile(
      title: Text(
        "Progress indicator delay ${delay != null ? "${delay.toString()} MS" : ""}",
      ),
      subtitle: Slider(
        value: delay != null ? (delay! / max) : 0,
        onChanged: (value) async {
          delay = (value * max).toInt();
          setState(() {
            saved = false;
          });
        },
      ),
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: saved
            ? null
            : () {
                widget.onSave(delay);
                setState(() {
                  saved = true;
                });
              },
      ),
    );
  }
}
