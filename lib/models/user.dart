import 'package:codeway_case/models/story.dart';

class User {
  User({
    required this.name,
    required this.uuid,
    required this.profilePhotoUrl,
    required this.userStories,
  });
  final String name;
  final String uuid;
  final String profilePhotoUrl;
  final List<Story> userStories;
}
