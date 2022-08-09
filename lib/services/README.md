# API说明(路由路径规范为全小写)

# 1、User基本操作api

| api名称                   | 路由路径                 | 作用                          | 方法   |
| ----------------------- | -------------------- | --------------------------- | ---- |
| **SignIn**              | /signin              | 登录账号(返回该登录用户基本数据)           | POST |
| **SignUp**              | /signup              | 注册账号(不提供激活但发送验证邮件)          | POST |
| **SignOut**             | /signout             | 退出账号(会清除authToken)          | PUT  |
| **EmailActivation**     | /emailactivation     | 作用于接受邮箱激活账号                 | POST |
| **TokenLogin**          | /tokenlogin          | 仅接受头部token登录账号(返回该登录用户基本数据) | POST |
| **RePassword**          | /repassword          | 发送修改密码的验证邮件                 | POST |
| **RePasswordValidate**  | /repassword/validate | 用于接受邮箱修改密码                  | PUT  |
| **UploadImg**           | /uploadimg           | 用于上传图片资源 (返回file基本信息)       | POST |
| **UploadAvatar**        | /uploadavatar        | 用于上传用户头像资源 (返回file基本信息)     | POST |
| **ReUserName**          | /reusername          | 用于修改用户昵称                    | PUT  |
| **SendActivationEmail** | /sendactivationemail | 发送激活账号的验证邮件                 | POST |
| **ReEmail**             | /reemail             | 用于修改用户邮箱                    | PUT  |

## 需要参数及返回参数内容(返回内容统一为result字段)

| api名称                   | 是否需要头部AuthToken或临时TokenT | 需要参数                | 返回result内容                                                                             |
| ----------------------- | ------------------------ | ------------------- | -------------------------------------------------------------------------------------- |
| **SignIn**              | NO                       | account,password    | { _id,name,email,friends[ ],inBox[ ],createDate,avatarUrl,authToken,isOnline,isAdmin } |
| **SignUp**              | NO                       | name,email,password | NULL                                                                                   |
| **SignOut**             | YES header-token         | NULL                | { isOnline:false }                                                                     |
| **EmailActivation**     | NO                       | NULL                | `<h1>用户账号已经激活,请勿重复验证!!!</h1>`                                                          |
| **TokenLogin**          | YES header-token         | NULL                | { _id,name,email,friends[ ],inBox[ ],createDate,avatarUrl,isOnline,isAdmin }           |
| **RePassword**          | NO                       | email               | NULL                                                                                   |
| **RePasswordValidate**  | YSE header-tokenT        | password            | NULL                                                                                   |
| **UploadImg**           | NO                       | NULL                | { file:这个file的基本信息 }                                                                   |
| **UploadAvatar**        | YES header-token         | NULL                | { file:这个file的基本信息 }                                                                   |
| **ReUserName**          | YES header-token         | name                | NULL                                                                                   |
| **SendActivationEmail** | NO                       | email               | NULL                                                                                   |
| **ReEmail**             | YES header-token         | email               | NULL                                                                                   |

# 2、inBox收件箱api

| api名称            | 路由路径          | 作用                          | 方法     |
| ---------------- | ------------- | --------------------------- | ------ |
| **GetUserInBox** | /getUserInBox | 获取该用户的收件箱数据(inBox as Array) | GET    |
| **ReadBoxMsg**   | /readboxmsg   | 让提供的id信件已读                  | PUT    |
| **DeleteBoxMsg** | /deleteboxmsg | 删除提供的id信件                   | DELETE |
| **ClearInBox**   | /clearinbox   | 清空用户收件箱                     | DELETE |

## 需要参数及返回参数内容(返回内容统一为result字段)

| api名称            | 是否需要头部AuthToken或临时TokenT | 需要参数     | 返回result内容                                                         |
| ---------------- | ------------------------ | -------- | ------------------------------------------------------------------ |
| **GetUserInBox** | YES header-token         | NULL     | [ { _id,msg,msgType,isRead,date,friendId(MayBe),isAgree(MayBe) } ] |
| **ReadBoxMsg**   | YES header-token         | id(信件ID) | { _id,msg,msgType,isRead,date,friendId(MayBe),isAgree(MayBe) }     |
| **DeleteBoxMsg** | YES header-token         | id(信件ID) | [ { _id,msg,msgType,isRead,date,friendId(MayBe),isAgree(MayBe) } ] |
| **ClearInBox**   | YES header-token         | NULL     | NULL                                                               |

# 3、roarText发泄墙api

| api名称                     | 路由路径                   | 作用                                   | 方法     |
| ------------------------- | ---------------------- | ------------------------------------ | ------ |
| **GetAllRoarText**        | /getallroartext        | 获取全部用户发布的宣泄帖子                        | GET    |
| **GetUserAllRoarText**    | /getuserallroartext    | 获取该用户的全部宣泄贴                          | GET    |
| **PostRoarText**          | /postroartext          | 用户发布宣泄帖子                             | POST   |
| **ClickTextLikes**        | /clicktextlikes        | 给指定的宣泄帖点赞                            | PUT    |
| **PutRoarText**           | /putroartext           | 编辑指定的宣泄帖内容                           | PUT    |
| **DeleteRoarText**        | /deleteroartext        | 删除指定的宣泄帖(支持管理员删除)                    | DELETE |
| **PostRoarTextComment**   | /postroartextcomment   | 评论指定的宣泄帖(未开启isCanComment功能时支持发帖本人评论) | POST   |
| **DeleteRoarTextComment** | /deleteroartextcomment | 删除指定的宣泄帖(支持发帖本人删除,支持管理员删除,支持评论人删除)   | DELETE |

## 需要参数及返回参数内容(返回内容统一为result字段)

| api名称                     | 是否需要头部AuthToken或临时TokenT | 需要参数                                             | 返回result内容                                                                                                                |
| ------------------------- | ------------------------ | ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------- |
| **GetAllRoarText**        | NO                       | NULL                                             | [ { _id,text,isPublic,isShowUserName,isCanComment,likeUsers[ ],textComments[ ],userId,createDate,smil,heart } ]           |
| **GetUserAllRoarText**    | YES header-token         | NULL                                             | [ { _id,text,isPublic,isShowUserName,isCanComment,likeUsers[ ],textComments[ ],userId,createDate,smil,heart } ]           |
| **PostRoarText**          | YES header-token         | text,isPublic,isShowUserName,isCanComment        | NULL                                                                                                                      |
| **ClickTextLikes**        | YES header-token         | textId,smil(bool),heart(bool)                    | { smil,heart }                                                                                                            |
| **PutRoarText**           | YES header-token         | textId,text,isPublic,isShowUserName,isCanComment | { _id,text,isPublic,isShowUserName,isCanComment,likeUsers[ ],textComments[ ],userId,createDate,smil,heart }               |
| **DeleteRoarText**        | YES header-token         | id(宣泄贴ID)                                        | { _id,text,isPublic,isShowUserName,isCanComment,likeUsers[ ],textComments[ ],userId,createDate,smil,heart } -> 被删除的宣泄贴    |
| **PostRoarTextComment**   | YSE header-token         | textId,commentText,isShowUserName                | RoarText{ ... , textComments:[ { _id,commentUserId,commentName,commentText,commentUserAvatarUrl,isShowUserName,date } ] } |
| **DeleteRoarTextComment** | YES header-token         | roarTextId, commentId                            | RoarText{ ... , textComments:[ { _id,commentUserId,commentName,commentText,commentUserAvatarUrl,isShowUserName,date } ] } |

# 4、friend好友路由api

| api名称              | 路由路径            | 作用                      | 方法     |
| ------------------ | --------------- | ----------------------- | ------ |
| **GetAllFriend**   | /getallfriend   | 获取用户全部好友基本信息            | GET    |
| **AddFriend**      | /addfriend      | 向对方发送好友申请(sendBoxMsg方式) | POST   |
| **AgreeAddFriend** | /agreeaddfriend | 同意好友申请                  | PUT    |
| **RemoveFriend**   | /removefriend   | 删除指定id好友                | DELETE |

## 需要参数及返回参数内容(返回内容统一为result字段)

| api名称              | 是否需要头部AuthToken或临时TokenT | 需要参数                    | 返回result内容                                        |
| ------------------ | ------------------------ | ----------------------- | ------------------------------------------------- |
| **GetAllFriend**   | YES header-token         | NULL                    | [ { _id,name,email,avatarUrl,isOnline,isAdmin } ] |
| **AddFriend**      | YES header-token         | id(要添加的好友ID)            | NULL                                              |
| **AgreeAddFriend** | YES header-token         | id(接受的申请信件ID)           | NULL                                              |
| **RemoveFriend**   | YES header-token         | id(要删除的好友ID,必须是已存在好友列表) | friends[]                                         |
