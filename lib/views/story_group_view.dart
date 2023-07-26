import 'package:codeway_case/data.dart';
import 'package:codeway_case/views/story_view.dart';
import 'package:codeway_case/views/story_view/story_view_model.dart';
import 'package:codeway_case/widgets/dissmissable.dart';
import 'package:codeway_case/widgets/insta_story_swipe.dart';
import 'package:codeway_case/widgets/swipe_controller.dart';
import 'package:flutter/material.dart';

class StoryGroupView extends StatefulWidget {
  const StoryGroupView({
    required this.initialIndex,
    required this.storyGroupController,
    super.key,
  });
  final int initialIndex;
  final InstagramSwipeController storyGroupController;

  @override
  State<StoryGroupView> createState() => _StoryGroupViewState();
}

class _StoryGroupViewState extends State<StoryGroupView> {
  @override
  Widget build(BuildContext context) {
    StoryViewModel.instagramSwipeController.pageController =
        PageController(initialPage: widget.initialIndex);
    return Scaffold(
      body: SnapchatDismiss(
        child: InstagramStorySwipe(
          initialPage: widget.initialIndex,
          instagramSwipeController: StoryViewModel.instagramSwipeController,
          children: List.generate(users.length, (index) {
            final selectedUser = users[index];
            final notSeenIndex = selectedUser.value.userStories
                .indexWhere((element) => element.seen == false);
            return StoryScreen(
              stories: selectedUser.value.userStories,
              initialIndex: (notSeenIndex == -1) ? 0 : notSeenIndex,
              isLast: index == users.length - 1,
              isFirst: index == 0,
              storyUser: selectedUser.value,
            );
          }),
        ),
      ),
    );
  }
}
