const String userTables = "userFriends";

//表内变量等
class UserFriendFields {
  //db需要全部值的sql语句名称时
  //可以直接传入这个值就行了
  static final List<String> dbValues = [
    id,
    createDate,
    friendName,
    avatarUrl,
    isOnlien,
  ];

  //用来在表里表示的值
  static const String id = '_id';
  static const String createDate = 'createDate';
  static const String friendName = 'friendName';
  static const String avatarUrl = 'avatarUrl';
  static const String isOnlien = 'isOnlien';
}

//实体化变量等
class UserFriend {
  final int? id;
  final int createDate;
  final String friendName;
  final String avatarUrl;
  final bool isOnlien;

//构造函数
  UserFriend({
    this.id,
    required this.createDate,
    required this.friendName,
    required this.avatarUrl,
    required this.isOnlien,
  });

//获取原数据的内容拷贝一份出来
  UserFriend copy({
    int? id,
    int? createDate,
    String? friendName,
    String? avatarUrl,
    bool? isOnlien,
  }) =>
      UserFriend(
        id: id ?? this.id,
        createDate: createDate ?? this.createDate,
        friendName: friendName ?? this.friendName,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        isOnlien: isOnlien ?? this.isOnlien,
      );

//由JSON类型转换成UserFriend类型
  static UserFriend fromJson(Map<String, Object?> json) => UserFriend(
        //利用Map里的键获取这个JSON类型(也可以叫Map类型)里的值数据.
        id: json[UserFriendFields.id] as int?,
        createDate: json[UserFriendFields.createDate] as int,
        friendName: json[UserFriendFields.friendName] as String,
        avatarUrl: json[UserFriendFields.avatarUrl] as String,
        //因为bool数据存表里就变成了整数类型(1=true, 0=false)
        //所以要转回User类型时要表达清楚
        isOnlien: json[UserFriendFields.isOnlien] == 1,
      );

//转换成K,V类型,在这里也可以理解为JSON类型
  Map<String, Object?> toJson() => {
        UserFriendFields.id: id,
        UserFriendFields.createDate: createDate,
        UserFriendFields.friendName: friendName,
        UserFriendFields.avatarUrl: avatarUrl,
        UserFriendFields.isOnlien: isOnlien,
      };
}
