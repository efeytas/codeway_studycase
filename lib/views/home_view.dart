import 'package:codeway_case/data.dart';
import 'package:codeway_case/models/user.dart';
import 'package:codeway_case/views/story_view/story_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}
// build home view
class _HomeViewState extends State<HomeView> {
  // sort users by seen or not seen of their stories
  List<Rx<User>> usersHaveStory = users
      .where((element) =>
          element.value.userStories
              .indexWhere((element) => element.seen == false) ==
          -1)
      .toList();
  List<Rx<User>> usersNotHaveStory = users
      .where((element) =>
          element.value.userStories
              .indexWhere((element) => element.seen == false) !=
          -1)
      .toList();
  // build user story list view
  @override
  Widget build(BuildContext context) {
    usersHaveStory.addAll(usersNotHaveStory);
    var allStorys = usersHaveStory.reversed.toList();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(allStorys.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () =>
                        StoryViewModel.openStory(allStorys[index].value, index),
                    child: Obx(
                      () => CircleAvatar(
                        radius: Get.height * 0.05 + 8,
                        backgroundColor:
                            (allStorys[index].value.userStories.indexWhere(
                                          (element) => element.seen == false,
                                        ) ==
                                    -1)
                                ? Colors.grey
                                : Colors.red,
                        child: CircleAvatar(
                          radius: Get.height * 0.05 + 4,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              allStorys[index].value.profilePhotoUrl,
                            ),
                            radius: Get.height * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Expanded(
            child: Text(
              'Codeway Story Clone',
              style: TextStyle(fontSize: 32),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
