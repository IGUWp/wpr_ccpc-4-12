class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: '数据结构',
      kacl: 525,
      meals: <String>['指针,', '链表,', '树'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: '机器学习',
      kacl: 602,
      meals: <String>['数据集,', '感知器,', '贝叶斯'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: '数据库原理',
      kacl: 0,
      meals: <String>['存储过程', '触发器'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: '计算机网络',
      kacl: 0,
      meals: <String>['TCP/IP', 'DNS'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
