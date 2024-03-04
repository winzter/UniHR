import 'package:avatar_stack/avatar_stack.dart';
import 'package:flutter/material.dart';

class AvatarImgStack extends StatelessWidget {
  const AvatarImgStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Text(
                "People",
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: AvatarStack(
            height: 50,
            avatars: [
              for (var n = 0; n < 15; n++)
                NetworkImage('https://i.pravatar.cc/150?img=$n'),
            ],
          ),
        ),
      ],
    );
  }
}
