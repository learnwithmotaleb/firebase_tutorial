import 'package:flutter/material.dart';

class LiveReactionWidget extends StatefulWidget {
  @override
  _LiveReactionWidgetState createState() => _LiveReactionWidgetState();
}

class _LiveReactionWidgetState extends State<LiveReactionWidget>
    with TickerProviderStateMixin {
  bool isLongPressed = false;
  List<AnimationController> animationControllers = [];
  List<Animation<double>> scaleAnimations = [];

  final List<IconData> reactions = [
    Icons.thumb_up,
    Icons.favorite,
    Icons.emoji_emotions,
    Icons.emoji_objects,
    Icons.emoji_people,
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < reactions.length; i++) {
      AnimationController controller = AnimationController(
        duration: Duration(milliseconds: 300),
        vsync: this,
      );
      animationControllers.add(controller);
      scaleAnimations.add(Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      ));
    }
  }

  void onLongPress() {
    setState(() {
      isLongPressed = true;
      for (var controller in animationControllers) {
        controller.forward();
      }
    });
  }

  void onLongPressEnd() {
    setState(() {
      isLongPressed = false;
      for (var controller in animationControllers) {
        controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onLongPressEnd: (_) => onLongPressEnd(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hold to see reactions'),
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < reactions.length; i++)
                ScaleTransition(
                  scale: scaleAnimations[i],
                  child: Transform.translate(
                    offset: Offset((i - (reactions.length / 2)) * 60.0, 0),
                    child: Icon(
                      reactions[i],
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ),
              Icon(
                Icons.thumb_up_alt_outlined,
                color: Colors.grey,
                size: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
