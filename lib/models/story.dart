enum StoryType { photo, video }

class Story {
  Story({
    required this.id,
    required this.url,
    required this.storyType,
    required this.seen,
  });
  final int id;
  final String url;
  final StoryType storyType;
  bool seen;
}
