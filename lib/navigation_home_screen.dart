import 'package:wpr_ccpc_4_12/app_theme.dart';
import 'package:wpr_ccpc_4_12/custom_drawer/drawer_user_controller.dart';
import 'package:wpr_ccpc_4_12/custom_drawer/home_drawer.dart';
import 'package:wpr_ccpc_4_12/feedback_screen.dart';
import 'package:wpr_ccpc_4_12/help_screen.dart';
import 'package:wpr_ccpc_4_12/home_screen.dart';
import 'package:wpr_ccpc_4_12/user_information.dart';
import 'package:wpr_ccpc_4_12/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:wpr_ccpc_4_12/speech_to_text/realasr.dart';
// import 'package:wpr_ccpc_4_12/speech_to_text/realasr.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  navigationHomeScreenState createState() => navigationHomeScreenState();
}

List<OverlayEntry> entriesList = [];

class navigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView; //个人的功能页
  DrawerIndex? drawerIndex;
  static final GlobalKey _overlayKey = GlobalKey(); // 使用 final 修饰
  static currentInstance() {
    var state = navigationHomeScreenState._overlayKey.currentContext
        ?.findAncestorStateOfType<navigationHomeScreenState>();

    return state;
  }

  late OverlayEntry overlayEntry;
  late OverlayState overlayState;
  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage(); //显示四个主要方块的地方
    super.initState();
    addoverlay();
  }

  @override
  void dispose() {
    super.dispose(); // 移除OverlayEntry
  }

  void addoverlay() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      overlayState = Overlay.of(context);
      overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
            left: MediaQuery.of(context).size.width * 0.7,
            top: MediaQuery.of(context).size.height * 0.73,
            child: RealASRView());
      });
      overlayState!.insert(overlayEntry); // 确保overlayState不为空
    });
  }

  void removeOverlay() {
    overlayEntry.remove();
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _overlayKey,
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
          // floatingActionButton: RealASRView(),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = HelpScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Invite:
          setState(() {
            screenView = InviteFriend();
          });
          break;
        case DrawerIndex.Information:
          setState(() {
            screenView = information();
          });
          break;
        default:
          break;
      }
    }
  }
}
