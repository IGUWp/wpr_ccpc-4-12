import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wpr_ccpc_4_12/videoPage/focusNodePovider.dart';
import 'package:wpr_ccpc_4_12/videoPage/videodetail.dart';

class comments extends StatefulWidget {
  comments({
    Key? key,
    required this.nickname,
    required this.date,
    // 提供默认值为空字符串
    required this.comment,
    required this.childComments,
    required this.avatarUrl,
    required this.topCommentsId,
    required this.fatherId,
  }) : super(key: key);
  final String nickname;
  final String date;
  final String comment;
  final String avatarUrl;
  final String topCommentsId;
  final String fatherId;
  final childComments;
  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  @override
  Widget build(BuildContext context) {
    final videodetail1 = Provider.of<videodetailprovider>(context);
    final focusNodeProvider = Provider.of<FocusNodeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        child: widget.avatarUrl.contains("http://localhost:")
                            ? Image.asset("assets/design_course/interFace3.png",
                                width: 43)
                            : Image.network(widget.avatarUrl, width: 43)
                        // Image.asset(
                        //   widget.avatarUrl.contains("http://localhost:")
                        //       ? "assets/design_course/interFace3.png"
                        //       : widget.avatarUrl,
                        //   width: 43,
                        // ),
                        ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nickname,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.date,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.comment,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_up_alt_outlined),
                        iconSize: 18,
                        constraints: const BoxConstraints.tightFor(
                          width: 30, // 设置按钮的宽度限制
                          height: 18, // 设置按钮的高度限制
                        ),
                        padding: EdgeInsets.all(0)),
                    Text(
                      "20",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.thumb_down_alt_outlined),
                        iconSize: 18,
                        constraints: const BoxConstraints.tightFor(
                          width: 30, // 设置按钮的宽度限制
                          height: 18, // 设置按钮的高度限制
                        ),
                        padding: EdgeInsets.all(0)),
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {
                          focusNodeProvider.requestFocus();
                          videodetail newvideodetai;
                          newvideodetai = videodetail(
                              commentsId: '',
                              userId: '',
                              topCommentsId: widget.topCommentsId,
                              fatherId: widget.topCommentsId,
                              videoId: "",
                              nickname: '',
                              avatarUrl: '',
                              commentsDetail: '',
                              ischildcomment: true,
                              userName: '');
                          videodetail1.setvideodetail(newvideodetai);
                          print(videodetail);
                          videodetail1.Videodetail.ischildcomment = true;
                          videodetail1.Videodetail.topCommentsId =
                              widget.topCommentsId;
                          videodetail1.Videodetail.fatherId =
                              widget.topCommentsId;
                        },
                        icon: Icon(Icons.chat_bubble_outline),
                        iconSize: 18,
                        constraints: const BoxConstraints.tightFor(
                          width: 30,
                          height: 18,
                        ),
                        padding: EdgeInsets.all(0)),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
        // Container(
        //   height: 100,
        //   color: Colors.grey[300],
        //   child: ListView.builder(
        //     itemCount: widget.childComments.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       return Padding(
        //         padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
        //         child: Text(
        //           widget.childComments[index]["commentsDetail"],
        //           style: TextStyle(fontSize: 15),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              widget.childComments.length,
              (index) => Row(
                children: [
                  Text(
                    widget.childComments[index]["nickname"] + " : ",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    widget.childComments[index]["commentsDetail"],
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  // 根据需要添加分隔线或者间距
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),

        Divider(
          // 创建一个水平分隔线
          color: Colors.grey,
          height: 1,
          thickness: 0.8,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }
}
