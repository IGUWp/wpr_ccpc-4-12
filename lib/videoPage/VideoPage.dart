import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wpr_ccpc_4_12/usermodel/user_riverpod.dart';
import 'package:wpr_ccpc_4_12/videoPage/comments.dart';
import 'package:wpr_ccpc_4_12/videoPage/detail_space.dart';
import 'package:wpr_ccpc_4_12/videoPage/focusNodePovider.dart';
import 'package:wpr_ccpc_4_12/videoPage/publisher.dart';
import 'package:wpr_ccpc_4_12/navigation_home_screen.dart';
import 'package:wpr_ccpc_4_12/videoPage/studentlist.dart';
import 'package:wpr_ccpc_4_12/http_request.dart';
import 'package:wpr_ccpc_4_12/videoPage/videodetail.dart';

// import 'package:video_player/video_player.dart';
class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String userid;
  final String videoid;

  VideoPlayerPage({
    required this.videoUrl,
    required this.userid,
    required this.videoid,
  });
  @override
  videoPlayerPageState createState() => videoPlayerPageState();
}

final TextEditingController Comment = TextEditingController();
List<studentlist> stulist = studentlist.stulist;

closeASROverlay() {
  // 使用 GlobalKey 来访问 realASRViewState 并调用 removeOverlay
  navigationHomeScreenState.currentInstance()?.removeOverlay();
}

class videoPlayerPageState extends State<VideoPlayerPage> {
  var _futureBuilderFuture;
  var x;

  Future<Response> fetchPost() async {
    Response response = await http.post(
      "/Video/GetOneVideoDetail",
      data: {
        "videoid": widget.videoid,
        "userid": widget.userid,
      },
    ).then((data) => x = data);
    print(response);
    return response;
  }

  late VideoPlayerController _controller;
  bool isplay = false;
  bool isFullScreen = false;
  late Duration WatchingTime;
  @override
  void initState() {
    _futureBuilderFuture = fetchPost();
    // print(_futureBuilderFuture.toString());
    // print(x);
    super.initState();
    closeASROverlay(); //删除overlay的一个entry
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      // _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(_onVideoEnd);
        _controller.addListener(getWatchingTime);
      });
  }

  void getWatchingTime() {
    WatchingTime = _controller.value.position;
  }

  void _onVideoEnd() {
    if (!_controller.value.isInitialized) return;
    if (_controller.value.position >= _controller.value.duration) {
      // 视频结束，重置到开始位置
      _controller.seekTo(Duration.zero);
      isplay = false; // 重置播放状态
      setState(() {});
    }
  }

  Future<void> _toggleFullScreen() async {
    setState(() {
      isFullScreen = !isFullScreen;
      // print(_controller.value.aspectRatio);
    });
    if (isFullScreen) {
      // 进入横屏全屏模式
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      // print(_controller.value.aspectRatio);
    } else {
      // 退出全屏模式
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      // print(_controller.value.aspectRatio);
    }
  }

  @override
  Widget build(BuildContext context) {
final focusNodeProvider = Provider.of<FocusNodeProvider>(context);
    
    // request();
    print(x);
    final userProvider = Provider.of<UserProvider>(context);
    final videodetail1 = Provider.of<videodetailprovider>(context);
    FocusNode commentFocusNode = FocusNode();
    double screenWidth = MediaQuery.of(context).size.width;
    // 根据视频宽高比和屏幕宽度计算内边距
    double topPadding = screenWidth / (_controller.value.aspectRatio) - 46;
    return Scaffold(
      backgroundColor: isFullScreen ? Colors.black : Colors.white,
      appBar: isFullScreen
          ? null
          : AppBar(
              toolbarHeight: 2,
              backgroundColor: Colors.transparent,
            ),
      body: FutureBuilder(
          future: _futureBuilderFuture,
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            print('connectionState:${snapShot.connectionState}');
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapShot.connectionState == ConnectionState.done) {
              print(snapShot.hasError);
              print('data:${snapShot.data}');

              if (snapShot.hasError) {
                return Text('Error: ${snapShot.error}');
              }
            }
            return isFullScreen
                ? SafeArea(
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                            onTapDown: ((details) {
                              if (isplay) {
                                _controller.pause();
                              } else {
                                _controller.play();
                              }
                              setState(() {
                                isplay = !isplay;
                              });
                            })),
                        Positioned(
                          child: !isplay
                              ? IconButton(
                                  icon: Icon(Icons.pause),
                                  color: Colors.black,
                                  iconSize: 80,
                                  onPressed: () {
                                    if (isplay) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                    setState(() {
                                      isplay = !isplay;
                                    });
                                  },
                                )
                              : Container(), // 根据isPaused状态显示暂停图标
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // 按钮：快速回退
                              IconButton(
                                color: Colors.white,
                                visualDensity: VisualDensity.compact,
                                alignment: Alignment.centerRight,
                                iconSize: 20,
                                icon: Icon(Icons.fast_rewind),
                                onPressed: () {
                                  _controller.seekTo(
                                      _controller.value.position -
                                          const Duration(seconds: 10));
                                },
                              ),
                              // 按钮：快速前进
                              IconButton(
                                color: Colors.white,
                                visualDensity: VisualDensity.compact,
                                alignment: Alignment.centerLeft,
                                iconSize: 20,
                                icon: Icon(Icons.fast_forward),
                                onPressed: () {
                                  _controller.seekTo(
                                      _controller.value.position +
                                          const Duration(seconds: 10));
                                },
                              ),
                              // 按钮：亮度调整
                              // Icon(Icons.brightness_4),
                              // 视频进度指示器
                              Expanded(
                                child: VideoProgressIndicator(_controller,
                                    allowScrubbing: true,
                                    colors: VideoProgressColors(
                                      playedColor: Colors.red,
                                      backgroundColor: Colors.blue,
                                      bufferedColor: Colors.green,
                                    )),
                              ),
                              IconButton(
                                  color: Colors.white,
                                  onPressed: _toggleFullScreen,
                                  icon: Icon(Icons.fullscreen)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    slivers: <Widget>[
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        pinned: true,
                        backgroundColor: Colors.transparent,
                        expandedHeight: topPadding * 1.3,
                        //空间大小可变的组件FlexibleSpaceBar，给我们处理好了title过渡的效果。
                        flexibleSpace: FlexibleSpaceBar(
                          // titlePadding: EdgeInsets.only(bottom: 10),
                          // title: Text(
                          //   "Python",
                          // ),
                          background: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                                onTapDown: (details) {
                                  if (isplay) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                  setState(() {
                                    isplay = !isplay;
                                  });
                                },
                              ),
                              Positioned(
                                child: !isplay
                                    ? IconButton(
                                        icon: Icon(Icons.pause),
                                        color: Colors.black,
                                        iconSize: 80,
                                        onPressed: () {
                                          if (isplay) {
                                            _controller.pause();
                                          } else {
                                            _controller.play();
                                          }
                                          setState(() {
                                            isplay = !isplay;
                                          });
                                        },
                                      )
                                    : Container(), // 根据isPaused状态显示暂停图标
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: topPadding),
                                child: !isplay
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // 按钮：快速回退
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            alignment: Alignment.centerRight,
                                            iconSize: 20,
                                            icon: Icon(Icons.fast_rewind),
                                            onPressed: () {
                                              _controller.seekTo(_controller
                                                      .value.position -
                                                  const Duration(seconds: 10));
                                            },
                                          ),
                                          // 按钮：快速前进
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            alignment: Alignment.centerLeft,
                                            iconSize: 20,
                                            icon: Icon(Icons.fast_forward),
                                            onPressed: () {
                                              _controller.seekTo(_controller
                                                      .value.position +
                                                  const Duration(seconds: 10));
                                            },
                                          ),
                                          // 按钮：亮度调整
                                          // Icon(Icons.brightness_4),
                                          // 视频进度指示器
                                          Expanded(
                                            child: VideoProgressIndicator(
                                                _controller,
                                                allowScrubbing: true,
                                                colors: VideoProgressColors(
                                                  playedColor: Colors.red,
                                                  backgroundColor: Colors.blue,
                                                  bufferedColor: Colors.green,
                                                )),
                                          ),
                                          IconButton(
                                              onPressed: _toggleFullScreen,
                                              icon: Icon(Icons.fullscreen)),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: <Widget>[
                            // 视频播放器和其他组件
                            publisher(
                                nickname: x.data['author']["nickname"],
                                resumeUrl: x.data['author']["avatarUrl"] == null
                                    ? 'assets/images/userImage.png'
                                    : x.data['author'][
                                        "avatarUrl"]), // 直接调用 publisher 而不是返回 Widget
                            Padding(padding: EdgeInsets.all(7)),
                            detail_space(
                              title: x.data['video']["title"],
                              introduce: x.data['video']["introduce"],
                              datetime: x.data['video']["datetime"],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return comments(
                                avatarUrl: x.data['videoComments'][index]
                                    ['avatarUrl'],
                                nickname: x.data['videoComments'][index]
                                    ['nickname'],
                                topCommentsId: x.data['videoComments'][index]
                                    ['topCommentsId'],
                                fatherId: x.data['videoComments'][index]
                                    ['topCommentsId'],
                                date: x.data['videoComments'][index]
                                    ['timeStamp'],
                                comment: x.data['videoComments'][index]
                                    ['commentsDetail'],
                                childComments: x.data['videoComments'][index]
                                    ["childComments"]);
                          },
                          childCount: x.data['videoComments'].length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 60),
                      )
                    ],
                  );
          }),
      bottomSheet: BottomAppBar(
        child: TextField(
          
          focusNode: focusNodeProvider.commentFocusNode,
          controller: Comment,
          // scrollPadding: EdgeInsets.all(0),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[500],
            // border: OutlineInputBorder(
            //     borderRadius: BorderRadius.all(Radius.circular(60))),
            suffixIcon: IconButton(
              color: Colors.white,
              icon: Icon(Icons.send),
              onPressed: () async {
                if (Comment.text.toString() != "") {
                  if (videodetail1.Videodetail.ischildcomment == true) {
                    // videodetail newvideodetai;
                    // newvideodetai = videodetail(
                    //     commentsId: '',
                    //     userId: '',
                    //     topCommentsId: "",
                    //     fatherId: '',
                    //     videoId: "",
                    //     nickname: '',
                    //     avatarUrl: '',
                    //     commentsDetail: '',
                    //     ischildcomment: false,
                    //     userName: '');
                    // videodetail1.setvideodetail(newvideodetai);
                    // commentFocusNode.requestFocus();
                    videodetail1.Videodetail.ischildcomment =
                        !videodetail1.Videodetail.ischildcomment;
                    var response = await http
                        .post("/Video/AddOneChildVideoComments", data: {
                      "videoid": widget.videoid,
                      "userid": widget.userid,
                      "fatherId": videodetail1.Videodetail.fatherId,
                      "topCommentsId": videodetail1.Videodetail.topCommentsId,
                      "commentsDetail": Comment.text,
                      "timeStamp": DateTime.now().toIso8601String(),
                      "userName": userProvider.user.username,
                      "AvatarUrl": userProvider.user.avatarurl,
                      "Nickname": userProvider.user.nickname
                      // "username":widget.
                    });
                  } else {
                    var response =
                        await http.post("/Video/AddOneTopVideoComments", data: {
                      "videoid": widget.videoid,
                      "userid": widget.userid,
                      "commentsDetail": Comment.text,
                      "timeStamp": DateTime.now().toIso8601String(),
                      "userName": userProvider.user.username,
                      "AvatarUrl": userProvider.user.avatarurl,
                      "Nickname": userProvider.user.nickname
                      // "username":widget.
                    });
                  }

                  setState(() {
                    // print(http.token);
                    // print(response);
                  });
                }
              },
            ),
            hintText: '说点什么...', //提示文字
            enabledBorder: UnderlineInputBorder(
              //输入框被选中时的边框样式
              borderRadius: BorderRadius.all(Radius.circular(40)),
              borderSide:
                  BorderSide(color: Colors.white, style: BorderStyle.solid),
            ),
            focusedBorder: UnderlineInputBorder(
              //输入框被选中时的边框样式
              borderRadius: BorderRadius.all(Radius.circular(40)),

              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          keyboardType: TextInputType.text, //键盘的类型
          maxLength: 50, //最多字数
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller.dispose();
    _controller.removeListener(_onVideoEnd);
    navigationHomeScreenState.currentInstance()?.addoverlay(); //把删除的overlay加回来
  }
}
