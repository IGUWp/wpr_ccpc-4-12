import 'package:flutter/material.dart';

///
///制作者的一栏，紧紧贴合在视频下边
///
class publisher extends StatefulWidget {
  ///
  ///制作者的一栏，紧紧贴合在视频下边
  ///
  String nickname;
  String resumeUrl;
  publisher({super.key, required this.nickname, required this.resumeUrl});

  @override
  State<publisher> createState() => _publisherState();
}

class _publisherState extends State<publisher> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          ClipRRect(
            //圆形的用户头像
            borderRadius: const BorderRadius.all(Radius.circular(60.0)),
            child: widget.resumeUrl == 'assets/images/userImage.png'
                ? Image.asset(
                    'assets/images/userImage.png', 
                    width: 43,
                    height: 43,
                  ): Image.network(
                    widget.resumeUrl,
                    width: 43,
                    height: 43,
                  )
                ,
          ),
          Padding(padding: EdgeInsets.all(8)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.nickname,
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 18,
                ),
              ),
              Text("10粉丝   10视频")
            ],
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: TextStyle(fontWeight: FontWeight.bold)),
            child: Text(
              "关注",
              selectionColor: Colors.white,
            ),
            onPressed: () {},
          ),
          Padding(padding: EdgeInsets.all(8)),
        ],
      ),
    );
  }
}
