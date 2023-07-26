import 'package:codeway_case/views/story_view.dart';
import 'package:codeway_case/views/story_view/story_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryOverlay extends StatelessWidget {
  const StoryOverlay({
    required this.widget,
    required int currentIndex,
    required this.barAnimationController,
    super.key,
  }) : _currentIndex = currentIndex;

  final StoryScreen widget;
  final int _currentIndex;
  final AnimationController barAnimationController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StoryBars(
            widget: widget,
            currentIndex: _currentIndex,
            barAnimationController: barAnimationController,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.storyUser.profilePhotoUrl),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.storyUser.name,
                  style: const TextStyle(
                    fontSize: 31,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: Get.height * 0.075,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(width: 2),
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Expanded(
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                      size: 64,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
