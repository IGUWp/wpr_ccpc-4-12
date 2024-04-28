import 'package:flutter/material.dart';

class videodetailprovider with ChangeNotifier {
  late videodetail _videodetail;

  videodetail get Videodetail => _videodetail;

  void setvideodetail(videodetail Videodetail) {
    _videodetail = Videodetail;
    notifyListeners(); // 当用户数据改变时，通知所有监听器
  }
}

class videodetail {
  videodetail(
      {this.commentsId = '',
      this.userId = '',
      this.topCommentsId = '',
      this.fatherId = '',
      this.videoId = '',
      this.nickname = '',
      this.avatarUrl = '',
      this.commentsDetail = '',
      this.ischildcomment = false,
      this.userName = ''});
  String commentsId;
  String userId;
  String topCommentsId;
  String fatherId;
  String videoId;
  String avatarUrl;
  String userName;
  String nickname;
  String commentsDetail;
  bool ischildcomment;
}
