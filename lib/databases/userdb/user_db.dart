import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ventroar_app/schemas/user.dart';

class UserDB {
  static final UserDB instance = UserDB._init();

  static Database? _database;

  UserDB._init();

//获取一个已经打开的DabaBase对象
  Future<Database> get database async {
    //先判断是否存在已经打开的DabaBase对象,如果存在的话则不再二次打开
    //并且返回已打开的DabaBase对象给调用者
    if (_database != null) return _database!;

    //如果不存在的话就打开user.db数据文件
    _database = await _initDB("user.db");
    //返回一个新打开的DabaBase对象给调用者
    return _database!;
  }

//初始化该user.db数据文件等操作
  Future<Database> _initDB(String filePath) async {
    //先获取存放DabaBase的路径
    final dbPath = await getDatabasesPath();
    //合并成一个完整的存放数据的目录地址
    final path = join(dbPath, filePath);
    //返回已被初始化好的任意文件名的Database对象实例
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

//在一个已经打开的数据库文件里建表操作
  Future _createDB(Database db, int version) async {
    //表内类型
    //这里表示,由数据库自动生成每个id
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    //这里不用说都知道是啥
    const integerType = "INTEGER NOT NULL";
    const textType = "TEXT NOT NULL";
    const boolType = "BOOLEAN NOT NULL";

    //sqlite建表语句等
    //CREATE TABLE <表明>
    //() 里的是这个表要装的K V
    //K:String类型
    //V:要用sql语句来表示类型
    await db.execute('''
CREATE TABLE $userTables (
  ${UserFields.id} $idType,
  ${UserFields.createTime} $integerType,
  ${UserFields.userName} $textType,
  ${UserFields.userImgUrl} $textType,
  ${UserFields.isAdmin} $boolType
)
''');
  }

//在表里添加新的数据
  Future<User> createUser(User user) async {
    //获取已经打开的DabaBase对象实例
    final db = await instance.database;

    //在这个已经打开的DabaBase对象里的某个表里添加数据
    //insert是sqflite插件库的<数据增加>函数,它有两个参数
    //C1:表名,C2:要存入的表数据(里面元素得和上面创建表时声明的一样)
    //C2:只支持存入Map<String, Object?>类型 (个人猜测)
    //return:会返回此创建好的数据id值
    final id = await db.insert(userTables, user.toJson());
    //返回带有id值的copy备份给外界调用
    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    //获取已经打开的DabaBase对象实例
    final db = await instance.database;

    //利用外界传入的id来获取相应的user数据
    //query是sqflite插件库的<数据获取/查找>函数
    //参数内容自行查看...这里只解释用到的参数
    //C1:表名,C2.columns:要查找的内容集,类型是List<String>
    //C2.where:具体要查找的内容,sql语句表示,这里的?号是一个具体变量值的占位符
    //?号的好处是不设置具体的数据值,以防sql注入
    //C2.whereArgs:?号占位符的具体值内容,类型是List
    final maps = await db.query(
      userTables,
      columns: UserFields.dbValues,
      where: "${UserFields.id} = ?",
      whereArgs: [id],
    );

    //如果查找成功的话就返回一个经过类型转换好的User类型对象
    if (maps.isNotEmpty) {
      //Map.first 等同于 Map[0]
      return User.fromJson(maps.first);
    } else {
      //如果查找失败或者数据不存在的话就抛出一个异常
      throw Exception("ID $id not found!!!");
    }
  }

  Future<List<User>> readAllUsers() async {
    //获取已经打开的DabaBase对象实例
    final db = await instance.database;

    //以一个时间获取全部表数据集对象
    const orderBy = "${UserFields.createTime} ASC";
    final result = await db.query(userTables, orderBy: orderBy);
    //将每个获取的数据利用Map进行类型转换
    return result.map((e) => User.fromJson(e)).toList();
  }

  Future<int> update(User user) async {
    //获取已经打开的DabaBase对象实例
    final db = await instance.database;

    //update是sqflite插件库的<数据更新>函数
    //参数类似于上面提到的query函数里的参数
    //这里讲一下第二个参数
    //C2:需要进行更新的数据内容
    //返回的是已经更新完的数据的id
    return db.update(
      userTables,
      user.toJson(),
      where: "${UserFields.id} = ?",
      //利用传入的更新数据的id查找相应的位置进行数据更新
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    //获取已经打开的DabaBase对象实例
    final db = await instance.database;

    //delete是sqflite插件库的数据删除函数
    //参数类似于上面提到的query函数里的参数
    //返回的是已经删除后的数据的id
    return db.delete(
      userTables,
      where: "${UserFields.id} = ?",
      whereArgs: [id],
    );
  }

  Future deleteAllUsers() async {
    final db = await instance.database;
//以一个时间获取全部表数据集对象
    await db.execute('''
DELETE FROM $userTables
''');
  }

//关闭数据库函数
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
