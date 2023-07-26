import 'package:codeway_case/views/story_view.dart';
import 'package:flutter/material.dart';

class StoryBars extends StatelessWidget {
  const StoryBars({
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
    return Row(
      children: List.generate(widget.stories.length, (index) {
        if (index != _currentIndex) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color:
                      (index >= _currentIndex) ? Colors.white12 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: LinearProgressIndicator(
                value: barAnimationController.value,
                color: Colors.white,
                backgroundColor: Colors.white12,
                minHeight: 8,
              ),
            ),
          );
        }
      }),
    );
  }
}
