class studentlist {
  studentlist(
      {this.username = '',
      this.date = '',
      this.commend = '',
      this.avatarurl = '',
      this.emailaddress = '',
      this.nickname = '',
      this.phonenumber = '',
      this.role = 1,
      this.userid = ''});
  String username;
  String date;
  String commend;
  String userid;
  String avatarurl;
  String nickname;
  int role;
  String emailaddress;
  String phonenumber;

  static List<studentlist> stulist = <studentlist>[
    studentlist(
        commend: "老师在视频的三分二十秒是为什么这样写啊",
        date: "2019 - 11 - 30 ",
        username: "郭莫"),
    studentlist(
        commend: "你的视频教学很好，感谢老师", date: "2018 - 12 - 26 ", username: "李树浩"),
    studentlist(
        commend: "请问有老师这个pdf文件资源吗", date: "2019 - 5 - 30 ", username: "小福饼"),
    studentlist(
        commend: "我猜测越往后人越少哈哈！咱们最后一期见",
        date: "2020 - 8 - 6 ",
        username: "无人识竹北"),
  ];
}
