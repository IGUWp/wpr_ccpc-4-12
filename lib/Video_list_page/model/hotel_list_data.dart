class VideoListData {
  VideoListData(
      {this.videourl = '',
      this.coverUrl = '',
      this.title = '',
      this.nickname = '',
      this.reviews = 80,
      this.rating = 4.5,
      this.perNight = 180,
      this.introduce = '',
      this.videoid = '',
      this.userid = '',
      this.datatime = ''});
  String userid;
  String videourl;
  String datatime;
  String coverUrl;
  String videoid;
  String title;
  String nickname;
  double rating;
  int reviews;
  int perNight;
  String introduce;
  factory VideoListData.fromJson(Map<String, dynamic> json) {
    return VideoListData(
      videoid: json['videoid'] ?? '',
      userid: json['userid'] ?? '',
      nickname: json['nickname'] ?? '',
      title: json['title'] ?? '',
      introduce: json['introduce'] ?? '',
      coverUrl: json['coverUrl'] ?? '',
      videourl: json['videoUrl'] ?? '',
      reviews: json['column'] ?? '',
      datatime: json['datetime'] ?? '',
      rating: 4.5,
      perNight: json['column'] ?? '',
    );
  }
  static List<VideoListData> fromJsonList(List<dynamic> list) {
    return list.map((i) => VideoListData.fromJson(i)).toList();
  }

  // static List<VideoListData> VideoList = <VideoListData>[
  //   VideoListData(
  //     userid: "",
  //     datatime: "",
  //     videoid: "",
  //     coverUrl: 'assets/hotel/hotel_1.png',
  //     title: 'C#',
  //     nickname: '李明浩',
  //     introduce: "C#基本语法和程序设计",
  //     reviews: 80,
  //     rating: 4.4,
  //     perNight: 18,
  //   ),
  //   VideoListData(
  //     userid: "",
  //     datatime: "",
  //     videoid: "",
  //     coverUrl: 'assets/hotel/hotel_2.png',
  //     title: 'JAVA',
  //     nickname: '郭嘉捷',
  //     introduce: "JAVA基本语法和程序设计",
  //     reviews: 74,
  //     rating: 4.5,
  //     perNight: 20,
  //   ),
  //   VideoListData(
  //     userid: "",
  //     datatime: "",
  //     videoid: "",
  //     coverUrl: 'assets/hotel/hotel_3.png',
  //     title: 'C/C++',
  //     nickname: '王念川',
  //     introduce: "C/C++基本语法和算法设计",
  //     reviews: 62,
  //     rating: 4.0,
  //     perNight: 60,
  //   ),
  //   VideoListData(
  //     userid: "",
  //     datatime: "",
  //     videoid: "",
  //     coverUrl: 'assets/hotel/hotel_4.png',
  //     title: 'Python',
  //     nickname: '乔羽浩',
  //     introduce: "Python基本语法和算法设计",
  //     reviews: 90,
  //     rating: 4.4,
  //     perNight: 17,
  //   ),
  //   VideoListData(
  //     userid: "",
  //     datatime: "",
  //     videoid: "",
  //     coverUrl: 'assets/hotel/hotel_5.png',
  //     title: 'HTML',
  //     nickname: '柏芝新',
  //     introduce: "HTML基本语法和页面设计",
  //     reviews: 240,
  //     rating: 4.5,
  //     perNight: 13,
  //   ),
  // ];
}
