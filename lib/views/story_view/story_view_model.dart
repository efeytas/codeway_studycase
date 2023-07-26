import 'package:codeway_case/models/story.dart';
import 'package:codeway_case/models/user.dart';
import 'package:codeway_case/views/story_group_view.dart';
import 'package:codeway_case/widgets/swipe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:video_player/video_player.dart';

class StoryViewModel {
  static InstagramSwipeController instagramSwipeController =
      InstagramSwipeController(PageController());

  static PageController inStoryController = PageController();

  static const Duration fiveSec = Duration(seconds: 5);

  static PausableTimer timer = PausableTimer(fiveSec, () {});

  static late AnimationController barAnimationController;
  static late VideoPlayerController videoPlayerController;

  void nextStory() {}

  void previousStory() {}

  void nextStoryGroup() {}

  void previousStoryGroup() {}

  static void openStory(User user, int index) {
    Get.to<Widget>(
      () => StoryGroupView(
        initialIndex: index,
        storyGroupController: instagramSwipeController,
      ),
      transition: Transition.circularReveal,
    );
  }

  static void onStoryTimerDone() {}

  static void setTimerForStory(Story story) {
    if (story.storyType == StoryType.photo) {
      timer = PausableTimer(
        const Duration(seconds: 5),
        onStoryTimerDone,
      );
      barAnimationController.duration = const Duration(seconds: 5);
      barAnimationController
        ..reset()
        ..forward(from: barAnimationController.value);
      timer.start();
    } else {
      var durationOfVideo = Duration.zero;
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(story.url))
            ..initialize().then((value) {
              durationOfVideo = videoPlayerController.value.duration;
              timer = PausableTimer(
                durationOfVideo,
                onStoryTimerDone,
              );

              barAnimationController.duration = durationOfVideo;
              barAnimationController
                ..reset()
                ..forward(
                  from: barAnimationController.value,
                );

              timer.start();
            });

      videoPlayerController.play();
    }
    story.seen = true;
  }
}
