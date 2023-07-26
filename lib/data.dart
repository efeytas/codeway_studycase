import 'package:codeway_case/models/story.dart';
import 'package:codeway_case/models/user.dart';
import 'package:get/get.dart';

//this is mock data

final RxList<Rx<User>> users = [user, user2, user3, user4, user5, user6].obs;

final Rx<User> user = User(
  uuid: '1',
  name: 'John 1',
  profilePhotoUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
  userStories: stories1,
).obs;

final Rx<User> user2 = User(
  uuid: '2',
  name: 'John 2',
  profilePhotoUrl: 'https://wallpapercave.com/wp/wp12407567.jpg',
  userStories: stories2,
).obs;

final Rx<User> user3 = User(
  uuid: '3',
  name: 'John 3',
  profilePhotoUrl: 'https://wallpapercave.com/wp/wp11706632.jpg',
  userStories: stories3,
).obs;

final Rx<User> user4 = User(
  uuid: '4',
  name: 'John 4',
  profilePhotoUrl: 'https://wallpapercave.com/uwp/uwp3838384.webp',
  userStories: stories4,
).obs;

final Rx<User> user5 = User(
  uuid: '5',
  name: 'John 5',
  profilePhotoUrl: 'https://wallpapercave.com/wp/wp12577064.jpg',
  userStories: stories5,
).obs;

final Rx<User> user6 = User(
  uuid: '6',
  name: 'John 6',
  profilePhotoUrl: 'https://wallpapercave.com/uwp/uwp3857012.jpeg',
  userStories: stories6,
).obs;

final RxList<Story> stories1 = [
  Story(
    id: 1,
    url:
        'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    storyType: StoryType.photo,
    seen: true,
  ),
  Story(
    id: 2,
    url:
        'https://images.unsplash.com/photo-1623838804048-d820eccdd088?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=627&q=80',
    storyType: StoryType.photo,
    seen: false,
  ),
  Story(
    id: 3,
    url:
        'https://media.istockphoto.com/id/1447621737/ko/%EB%B9%84%EB%94%94%EC%98%A4/%EC%97%AC%EA%B0%9D%EC%84%A0-%EB%A6%AC%ED%8B%80-%ED%94%8C%EB%9E%98%EB%8B%9B-%ED%8F%AC%EB%A7%B7.mp4?s=mp4-480x480-is&k=20&c=syHz49l3GI6xtJwbOqNWjUY8pH32sBZf6qui025JvJ4=',
    storyType: StoryType.video,
    seen: false,
  ),
].obs;

RxList<Story> stories2 = [
  Story(
    id: 5,
    url:
        'https://images.unsplash.com/photo-1567861911437-538298e4232c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=928&q=80',
    storyType: StoryType.photo,
    seen: false,
  ),
  Story(
    id: 6,
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    storyType: StoryType.video,
    seen: false,
  ),
].obs;

RxList<Story> stories3 = [
  Story(
    id: 7,
    url:
        'https://images.unsplash.com/photo-1542639130-c9fadbddcc6b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    storyType: StoryType.photo,
    seen: true,
  ),
  Story(
    id: 8,
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    storyType: StoryType.video,
    seen: true,
  ),
].obs;

RxList<Story> stories4 = [
  Story(
    id: 9,
    url:
        'https://plus.unsplash.com/premium_photo-1683622797094-73a60392e97a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    storyType: StoryType.photo,
    seen: true,
  ),
  Story(
    id: 10,
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    storyType: StoryType.video,
    seen: true,
  ),
].obs;

RxList<Story> stories5 = [
  Story(
    id: 11,
    url:
        'https://images.unsplash.com/photo-1612387290123-34af734b5f61?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80',
    storyType: StoryType.photo,
    seen: true,
  ),
  Story(
    id: 12,
    url:
        'https://media.istockphoto.com/id/1409116437/tr/video/man-enjoys-coffee-and-relaxes-by-the-fire.mp4?s=mp4-640x640-is&k=20&c=WcOwM0KPzfl74_lHkvaMpfolLMXv-hHI7MsVsLJaGhA=',
    storyType: StoryType.video,
    seen: true,
  ),
    Story(
    id: 4,
    url:
        'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    storyType: StoryType.photo,
    seen: false,
  ),
].obs;

RxList<Story> stories6 = [
  Story(
    id: 13,
    url:
        'https://plus.unsplash.com/premium_photo-1673473619570-94b3ac8c4aed?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=627&q=80',
    storyType: StoryType.photo,
    seen: true,
  ),
  Story(
    id: 14,
    url:
        'https://media.istockphoto.com/id/1450313535/ko/%EB%B9%84%EB%94%94%EC%98%A4/%EC%B9%9C%ED%99%98%EA%B2%BD-%EC%9E%90%EB%8F%99%EC%B0%A8%EB%8A%94-%EA%B3%A0%EA%B0%80-%EB%8F%84%EB%A1%9C%EC%97%90%EC%84%9C-%EC%9A%B4%EC%A0%84%ED%95%A9%EB%8B%88%EB%8B%A4.mp4?s=mp4-480x480-is&k=20&c=KWqTqo2VnKVxgTPeyBqfTu-1PQTrkXblYo0BGG0DthI=',
    storyType: StoryType.video,
    seen: true,
  ),
].obs;
