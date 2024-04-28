import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpr_ccpc_4_12/app_theme.dart';
import 'package:wpr_ccpc_4_12/usermodel/user_riverpod.dart';

class information extends StatefulWidget {
  @override
  _informationState createState() => _informationState();
}

class _informationState extends State<information> {
  // late User user;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      // appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: userProvider.user.avatarurl,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(userProvider.user.nickname, userProvider.user.emailaddress),
          const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(
              "邮箱", userProvider.user.emailaddress, Icon(Icons.attach_email)),
          const SizedBox(height: 24),
          buildAbout("账号", userProvider.user.userid, Icon(Icons.person)),
          const SizedBox(height: 24),
          buildAbout(
              "用户名", userProvider.user.nickname, Icon(Icons.person_outline)),
          const SizedBox(height: 24),
          buildAbout("手机号", userProvider.user.phonenumber, Icon(Icons.phone)),
        ],
      ),
    );
  }

  Widget buildName(name, email) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: !isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyle(
            color: Colors.grey,
            backgroundColor:
                isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          ),
        )
      ],
    );
  }

  // Widget buildUpgradeButton() => ButtonWidget(
  //       text: 'Upgrade To PRO',
  //       onClicked: () {},
  //     );

  Widget buildAbout(text, String value, Icon icon) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(38.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              icon, //图标
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: !isLightMode
                          ? AppTheme.nearlyWhite
                          : AppTheme.nearlyBlack,
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !isLightMode
                          ? AppTheme.nearlyWhite
                          : AppTheme.nearlyBlack,
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    // final color = isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    // final image = AssetImage("assets/images/userImage.png");

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(context, '4.8', '观看时长'),
          buildDivider(),
          buildButton(context, '35', '观看课程数'),
          buildDivider(),
          buildButton(context, '2024-4-2', '注册日期'),
        ],
      );
  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color:
                    !isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack),
          ),
          SizedBox(height: 2),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: !isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
            ),
          ),
        ],
      ),
    );
  }
}
