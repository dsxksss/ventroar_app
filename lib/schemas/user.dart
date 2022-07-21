const String userTables = "user";

//表内变量等
class UserFields {
  //db需要全部值的sql语句名称时
  //可以直接传入这个值就行了
  static final List<String> dbValues = [
    id,
    createDate,
    name,
    email,
    isAdmin,
    isOline,
    avatarUrl,
  ];

  //用来在表里表示的值
  static const String id = '_id';
  static const String createDate = 'createDate';
  static const String name = 'name';
  static const String email = 'email';
  static const String isAdmin = 'isAdmin';
  static const String isOline = 'isOline';
  static const String avatarUrl = 'avatarUrl';
}

//实体化变量等
class UserFriend {
  final String id;
  final int createDate;
  final String name;
  final String email;
  final bool isOline;
  final bool isAdmin;
  final String avatarUrl;

//构造函数
  UserFriend({
    required this.id,
    required this.createDate,
    required this.name,
    required this.email,
    required this.isOline,
    required this.isAdmin,
    required this.avatarUrl,
  });

//获取原数据的内容拷贝一份出来
  UserFriend copy({
    String? id,
    int? createDate,
    String? name,
    String? email,
    bool? isOline,
    bool? isAdmin,
    String? avatarUrl,
  }) =>
      UserFriend(
        id: id ?? this.id,
        createDate: createDate ?? this.createDate,
        name: name ?? this.name,
        email: email ?? this.email,
        isOline: isOline ?? this.isOline,
        isAdmin: isAdmin ?? this.isAdmin,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );

//由JSON类型转换成UserFriend类型
  static UserFriend fromJson(Map<String, Object?> json) => UserFriend(
        //利用Map里的键获取这个JSON类型(也可以叫Map类型)里的值数据.
        id: json[UserFields.id] as String,
        createDate: json[UserFields.createDate] as int,
        name: json[UserFields.name] as String,
        email: json[UserFields.email] as String,
        //因为bool数据存表里就变成了整数类型(1=true, 0=false)
        //所以要转回User类型时要表达清楚
        isOline: json[UserFields.isOline] == 1,
        isAdmin: json[UserFields.isAdmin] == 1,
        avatarUrl: json[UserFields.avatarUrl] as String,
      );

//转换成K,V类型,在这里也可以理解为JSON类型
  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.createDate: createDate,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.isOline: isOline,
        UserFields.isAdmin: isAdmin,
        UserFields.avatarUrl: avatarUrl,
      };
}
