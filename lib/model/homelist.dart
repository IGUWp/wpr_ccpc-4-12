import 'package:wpr_ccpc_4_12/fitness_app/fitness_app_home_screen.dart';
import 'package:wpr_ccpc_4_12/Video_list_page/video_home_screen.dart';
import 'package:wpr_ccpc_4_12/introduction_animation/introduction_animation_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({this.navigateScreen, this.imagePath = '', this.description = ''});

  Widget? navigateScreen;
  String imagePath;
  String description;
  static List<HomeList> homeList = [
    HomeList(
        imagePath: 'assets/imformation/relax.png',
        navigateScreen: IntroductionAnimationScreen(),
        description: "assets/imformation/relax_word.png"),
    HomeList(
        imagePath: 'assets/imformation/videopage.png',
        navigateScreen: VideoHomeScreen(),
        description: "assets/imformation/video_word.png"),
    HomeList(
        imagePath: 'assets/imformation/information.png',
        navigateScreen: FitnessAppHomeScreen(),
        description: "assets/imformation/information_word.png"),
    HomeList(
        imagePath: 'assets/imformation/willcome.png',
        navigateScreen: FitnessAppHomeScreen(),
        description: "assets/imformation/willcome_word.png"),
    // HomeList(
    //   imagePath: 'assets/design_course/design_course.png',
    //   navigateScreen: DesignCourseHomeScreen(),
    // ),
    // HomeList(
    //   imagePath: 'assets/introduction_animation/introduction_animation.png',
    //   navigateScreen: VideoPlayerPage(
    //       videoUrl: 'https://www.w3school.com.cn/example/html5/mov_bbb.mp4'),
    // ),
  ];
}
