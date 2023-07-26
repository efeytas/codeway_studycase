import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:codeway_case/data.dart';
import 'package:codeway_case/models/story.dart';
import 'package:codeway_case/models/user.dart';
import 'package:codeway_case/views/home_view.dart';
import 'package:codeway_case/views/story_view/story_overlay.dart';
import 'package:codeway_case/views/story_view/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:video_player/video_player.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({
    required this.stories,
    required this.initialIndex,
    required this.isLast,
    required this.isFirst,
    required this.storyUser,
    super.key,
  });
  final User storyUser;
  final List<Story> stories;
  final int initialIndex;
  final bool isLast;
  final bool isFirst;

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen>
    with TickerProviderStateMixin {
  late int _currentIndex;
  late PausableTimer timer;
  late AnimationController barAnimationController;

  bool isPressingLong = false;
  bool isDragging = false;
  bool isLoadingVideo = false;
  bool isProcessingTap = false;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    StoryViewModel.inStoryController =
        PageController(initialPage: _currentIndex);
    barAnimationController = AnimationController(
      vsync: this,
      duration: Duration.zero,
    )..addListener(() {
        if (!mounted) return;
        setState(() {});
      });
    _setTimerForCurrentStory();
    barAnimationController.forward(from: barAnimationController.value);
    super.initState();
  }

  @override
  void dispose() {
    barAnimationController
      ..stop()
      ..dispose();
    super.dispose();
  }

  void _setTimerForCurrentStory() {
    if (!mounted) return;
    setState(() {
      final userIndex = users
          .indexWhere((element) => element.value.uuid == widget.storyUser.uuid);
      users[userIndex].value.userStories[_currentIndex].seen = true;
      widget.stories[_currentIndex].seen = true;
    });
    if (widget.stories[_currentIndex].storyType == StoryType.photo) {
      timer = PausableTimer(
        const Duration(seconds: 5),
        _timerFinished,
      );
      barAnimationController
        ..duration = const Duration(seconds: 5)
        ..reset()
        ..forward(from: barAnimationController.value);
      timer.start();
    } else {
      isLoadingVideo = true;
      var durationOfVideo = Duration.zero;
      StoryViewModel.videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.stories[_currentIndex].url),
      )..initialize().then((value) {
          if (!mounted) return;
          setState(
            () {
              isLoadingVideo = false;
              durationOfVideo =
                  StoryViewModel.videoPlayerController.value.duration;
              timer = PausableTimer(
                durationOfVideo,
                _timerFinished,
              );

              barAnimationController
                ..duration = durationOfVideo
                ..reset()
                ..forward(
                  from: barAnimationController.value,
                );

              timer.start();
            },
          );
        });

      StoryViewModel.videoPlayerController.play();
    }
  }
// timer finished change page 
  void _timerFinished() {
    timer.cancel();
    // if last story go to home view
    if (widget.stories.length == _currentIndex + 1) {
      if (widget.isLast) {
        Get.to<Widget>(
          HomeView.new,
          fullscreenDialog: true,
          transition: Transition.circularReveal,
        );
        // if not last story go to next user
      } else {
        StoryViewModel.instagramSwipeController.nextPage(
          duration: const Duration(milliseconds: 300),
        );
        _setTimerForCurrentStory();
      }
      // if not last story go to next story
    } else {
      StoryViewModel.inStoryController.nextPage(
        duration: const Duration(milliseconds: 50),
        curve: Curves.linear,
      );
      _currentIndex++;
      _setTimerForCurrentStory();
    }
  }
// jump to previous story
  void _jumpPreviousStory() {
    timer.cancel();
    if (0 == _currentIndex) {
      // if first story go to home view
      if (widget.isFirst) {
        Get.to<Widget>(
          HomeView.new,
          fullscreenDialog: true,
          transition: Transition.circularReveal,
        );
      } else {
        StoryViewModel.instagramSwipeController
            .previousPage(duration: const Duration(milliseconds: 300));
      }
    } else {
      StoryViewModel.inStoryController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
      _currentIndex--;
      _setTimerForCurrentStory();
    }
  }

  @override
  // build story screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: GestureDetector(
        // if dragging swipe user or long press pause story
        onTapDown: _onTapDown,
        onVerticalDragStart: (details) {
          isDragging = true;
        },
        onVerticalDragEnd: (details) {
          isDragging = false;
        },
        onLongPress: () {
          if (!isProcessingTap) {
            isProcessingTap = true;
            if (!mounted) return;
            setState(() {
              isPressingLong = true;
            });
            // pause story
            timer.pause();
            barAnimationController.stop();
            if (widget.stories[_currentIndex].storyType == StoryType.video) {
              StoryViewModel.videoPlayerController.pause();
            }
            isProcessingTap = false;
          }
        },
        onLongPressUp: () {
          if (!isProcessingTap) {
            isProcessingTap = true;
            if (!mounted) return;
            setState(() {
              isPressingLong = false;
            });

            timer.start();
            barAnimationController.forward(from: barAnimationController.value);
            if (widget.stories[_currentIndex].storyType == StoryType.video) {
              StoryViewModel.videoPlayerController.play();
            }
            isProcessingTap = false;
          }
        },
        child: PageView.builder(
          controller: StoryViewModel.inStoryController,
          itemCount: widget.stories.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final story = widget.stories[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                buildBody(story),
                AnimatedOpacity(
                  opacity: isPressingLong ? 0 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: StoryOverlay(
                    widget: widget,
                    currentIndex: _currentIndex,
                    barAnimationController: barAnimationController,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildBody(Story story) {
    switch (story.storyType) {
      case StoryType.photo:
        return CachedNetworkImage(
          imageUrl: story.url,
          fit: BoxFit.cover,
        );
      case StoryType.video:
        if (StoryViewModel.videoPlayerController.value.isInitialized) {
          return FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: StoryViewModel.videoPlayerController.value.size.width,
              height: StoryViewModel.videoPlayerController.value.size.height,
              child: VideoPlayer(StoryViewModel.videoPlayerController),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
    }
  }

  Future<void> _onTapDown(TapDownDetails details) async {
    await Future<void>.delayed(const Duration(milliseconds: 500)).then((value) {
      if (isPressingLong || isDragging) {
        return;
      }
      isProcessingTap = true;
      final screenWidth = MediaQuery.of(context).size.width;
      final dx = details.globalPosition.dx;
      // if tap left side of screen go to previous story
      if (dx < screenWidth / 3) {
        _jumpPreviousStory();
     // if tap right side of screen go to next story
      } else {
        _timerFinished();
      }
      isProcessingTap = false;
    });
  }
}
