const String userTables = "users";

//表内变量等
class UserFields {
  //db需要全部值的sql语句名称时
  //可以直接传入这个值就行了
  static final List<String> dbValues = [
    id,
    createTime,
    userName,
    userImgUrl,
    isAdmin,
  ];

  //用来在表里表示的值
  static const String id = '_id';
  static const String createTime = 'createTime';
  static const String userName = 'userName';
  static const String userImgUrl = 'userImgUrl';
  static const String isAdmin = 'isAdmin';
}

//实体化变量等
class User {
  final int? id;
  final DateTime createTime;
  final String userName;
  final String userImgUrl;
  final bool isAdmin;

//构造函数
  User({
    this.id,
    required this.createTime,
    required this.userName,
    required this.userImgUrl,
    required this.isAdmin,
  });

//获取原数据的内容拷贝一份出来
  User copy({
    int? id,
    DateTime? createTime,
    String? userName,
    String? userImgUrl,
    bool? isAdmin,
  }) =>
      User(
        id: id ?? this.id,
        createTime: createTime ?? this.createTime,
        userName: userName ?? this.userName,
        userImgUrl: userImgUrl ?? this.userImgUrl,
        isAdmin: isAdmin ?? this.isAdmin,
      );

//由JSON类型转换成User类型
  static User fromJson(Map<String, Object?> json) => User(
        //利用Map里的键获取这个JSON类型(也可以叫Map类型)里的值数据.
        id: json[UserFields.id] as int?,
        createTime: DateTime.parse(json[UserFields.createTime] as String),
        userName: json[UserFields.userName] as String,
        userImgUrl: json[UserFields.userImgUrl] as String,
        //因为bool数据存表里就变成了整数类型(1=true, 0=false)
        //所以要转回User类型时要表达清楚
        isAdmin: json[UserFields.isAdmin] == 1,
      );

//转换成K,V类型,在这里也可以理解为JSON类型
  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.createTime: createTime.toIso8601String(),
        UserFields.userName: userName,
        UserFields.userImgUrl: userImgUrl,
        UserFields.isAdmin: isAdmin,
      };
}
