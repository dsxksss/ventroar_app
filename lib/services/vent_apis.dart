//自定url地址配置类
class VentUrls {
  static String apiPath = "https://ventroar.xyz:2548";

  ///-----------------User基本操作api---------------------
  //POST   登录账号(返回该登录用户基本数据)	account,password
  static String signIn = "$apiPath/signin";
  //POST   注册账号(不提供激活但发送验证邮件)	name,email,password
  static String signUp = "$apiPath/signup";
  //PUT    退出账号(清除数据库内的验证token)
  static String signOut = "$apiPath/signout";
  //POST   作用于接受邮箱激活账号	null
  static String emailActivation = "$apiPath/emailactivation";
  //POST   仅接受头部token登录账号(返回该登录用户基本数据)	null
  static String tokenLogin = "$apiPath/tokenlogin";
  //POST   仅发送修改密码的验证邮件	email
  static String rePassword = "$apiPath/repassword";
  //PUT    作用于接受邮箱修改密码	password
  static String rePasswordValidate = "$apiPath/repassword/validate";
  //POST   用于上传图片资源	imager
  static String uploadImg = "$apiPath/uploadImg";
  //POST   用于上传用户头像资源	avatar
  static String uploadAvatar = "$apiPath/uploadavatar";
  //PUT    用于修改用户昵称
  static String reUserName = "$apiPath/reusername";
  //POST   仅发送激活账号的验证邮件	email
  static String sendActivationEmail = "$apiPath/sendactivationemail";
  //PUT    用于修改用户邮箱
  static String reEmail = "$apiPath/reemail";

  ///-----------------inBox收件箱api---------------------
  //GET    获取该用户的收件箱数据(inBox as Array)
  static String getUserInBox = "$apiPath/getUserInBox";
  //PUT    让提供的id信件已读
  static String readBoxMsg = "$apiPath/readboxmsg";
  //DELETE 删除提供的id信件
  static String deleteBoxMsg = "$apiPath/deleteboxmsg";
  //DELETE 清空用户收件箱
  static String clearInBox = "$apiPath/clearinbox";
  //DELETE 清空用户收件箱

  ///-----------------roarText发泄墙api---------------------
  //GET    获取全部用户发布的宣泄帖子
  static String getAllRoarText = "$apiPath/getallroartext";
  //GET    获取该用户的全部宣泄贴
  static String getUserAllRoarText = "$apiPath/getuserallroartext";
  //POST   用户发布宣泄帖子
  static String postRoarText = "$apiPath/postroartext";
  //POST   给指定宣泄帖子上传图片
  static String postTextImages = "$apiPath/posttextimages"; //?id
  //PUT    给指定的宣泄帖点赞
  static String clickTextLikes = "$apiPath/clicktextlikes";
  //PUT    编辑指定的宣泄帖内容
  static String putRoarText = "$apiPath/putroartext";
  //DELETE 删除指定的宣泄帖(支持管理员删除)
  static String deleteRoarText = "$apiPath/deleteroartext";
  //POST   评论指定的宣泄帖(未开启isCanComment功能时支持发帖本人评论)
  static String postRoarTextComment = "$apiPath/postroartextcomment";
  //DELETE 删除指定的宣泄帖(支持发帖本人删除,支持管理员删除,支持评论人删除)
  static String deleteRoarTextComment = "$apiPath/deleteroartextcomment";

  ///-----------------friend好友路由api---------------------
  //GET    获取用户全部好友基本信息
  static String getAllFriend = "$apiPath/getallfriend";
  //POST   向对方发送好友申请(sendBoxMsg方式)
  static String addFriend = "$apiPath/addfriend";
  //PUT    同意好友申请
  static String agreeAddFriend = "$apiPath/agreeaddfriend";
  //DELETE 获取全部用户发布的宣泄帖子
  static String removeFriend = "$apiPath/removefriend";
}

class VentUrlsTest {
  static String apiPath = "http://localhost:2547";

  ///-----------------User基本操作api---------------------
  //POST   登录账号(返回该登录用户基本数据)	account,password
  static String signIn = "$apiPath/signin";
  //POST   注册账号(不提供激活但发送验证邮件)	name,email,password
  static String signUp = "$apiPath/signup";
  //PUT    退出账号(清除数据库内的验证token)
  static String signOut = "$apiPath/signout";
  //POST   作用于接受邮箱激活账号	null
  static String emailActivation = "$apiPath/emailactivation";
  //POST   仅接受头部token登录账号(返回该登录用户基本数据)	null
  static String tokenLogin = "$apiPath/tokenlogin";
  //POST   仅发送修改密码的验证邮件	email
  static String rePassword = "$apiPath/repassword";
  //PUT    作用于接受邮箱修改密码	password
  static String rePasswordValidate = "$apiPath/repassword/validate";
  //POST   用于上传图片资源	imager
  static String uploadImg = "$apiPath/uploadImg";
  //POST   用于上传用户头像资源	avatar
  static String uploadAvatar = "$apiPath/uploadavatar";
  //PUT    用于修改用户昵称
  static String reUserName = "$apiPath/reusername";
  //POST   仅发送激活账号的验证邮件	email
  static String sendActivationEmail = "$apiPath/sendactivationemail";
  //PUT    用于修改用户邮箱
  static String reEmail = "$apiPath/reemail";

  ///-----------------inBox收件箱api---------------------
  //GET    获取该用户的收件箱数据(inBox as Array)
  static String getUserInBox = "$apiPath/getUserInBox";
  //PUT    让提供的id信件已读
  static String readBoxMsg = "$apiPath/readboxmsg";
  //DELETE 删除提供的id信件
  static String deleteBoxMsg = "$apiPath/deleteboxmsg";
  //DELETE 清空用户收件箱
  static String clearInBox = "$apiPath/clearinbox";
  //DELETE 清空用户收件箱

  ///-----------------roarText发泄墙api---------------------
  //GET    获取全部用户发布的宣泄帖子
  static String getAllRoarText = "$apiPath/getallroartext";
  //GET    获取该用户的全部宣泄贴
  static String getUserAllRoarText = "$apiPath/getuserallroartext";
  //POST   用户发布宣泄帖子
  static String postRoarText = "$apiPath/postroartext";
  //POST   给指定宣泄帖子上传图片
  static String postTextImages = "$apiPath/posttextimages"; //?id
  //PUT    给指定的宣泄帖点赞
  static String clickTextLikes = "$apiPath/clicktextlikes";
  //PUT    编辑指定的宣泄帖内容
  static String putRoarText = "$apiPath/putroartext";
  //DELETE 删除指定的宣泄帖(支持管理员删除)
  static String deleteRoarText = "$apiPath/deleteroartext";
  //POST   评论指定的宣泄帖(未开启isCanComment功能时支持发帖本人评论)
  static String postRoarTextComment = "$apiPath/postroartextcomment";
  //DELETE 删除指定的宣泄帖(支持发帖本人删除,支持管理员删除,支持评论人删除)
  static String deleteRoarTextComment = "$apiPath/deleteroartextcomment";

  ///-----------------friend好友路由api---------------------
  //GET    获取用户全部好友基本信息
  static String getAllFriend = "$apiPath/getallfriend";
  //POST   向对方发送好友申请(sendBoxMsg方式)
  static String addFriend = "$apiPath/addfriend";
  //PUT    同意好友申请
  static String agreeAddFriend = "$apiPath/agreeaddfriend";
  //DELETE 获取全部用户发布的宣泄帖子
  static String removeFriend = "$apiPath/removefriend";
}
