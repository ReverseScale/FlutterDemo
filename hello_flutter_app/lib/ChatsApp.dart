import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

const String _name = "CYC"; //聊天帐号昵称

class FriendlychatApp extends StatelessWidget {
  final ThemeData kIOSTheme = ThemeData(
    //Cupertino主题风格
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light,
  );

  final ThemeData kDefaultTheme = ThemeData(
    //默认的Material主题风格
    primarySwatch: Colors.purple,
    accentColor: Colors.orangeAccent[400],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //创建一个MaterialApp控件对象，其下可塞入支持Material设计语言特性的控件
      title: "Friendlychat",
      theme: defaultTargetPlatform ==
              TargetPlatform.iOS //defaultTargetPlatform用于识别操作系统
          ? kIOSTheme 
          : kDefaultTheme,
      home: ChatScreen(), //主页面为用户自定义ChatScreen控件
    );
  }
}

//单条聊天信息控件
class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      //用SizeTransition动效控件包裹整个控件，定义从小变大的动画效果
      sizeFactor: CurvedAnimation(
          //CurvedAnimation定义动画播放的时间曲线
          parent: animationController,
          curve: Curves.easeOut), //指定曲线类型
      axisAlignment: 0.0, //对齐
      child: Container(
        //modified  Container控件被包裹到SizeTransition中
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            Expanded(
              //new  Expanded控件
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_name, style: Theme.of(context).textTheme.subhead),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//聊天主页面ChatScreen控件定义为一个有状态控件
class ChatScreen extends StatefulWidget {
  @override
  State createState() =>
      ChatScreenState(); //ChatScreenState作为控制ChatScreen控件状态的子类
}

//ChatScreenState状态中实现聊天内容的动态更新
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages =
      <ChatMessage>[]; //存放聊天记录的数组，数组类型为无状态控件ChatMessage
  final TextEditingController _textController =
      TextEditingController(); //聊天窗口的文本输入控件
  bool _isComposing = false;

  @override
  void dispose() {
    for (ChatMessage message in _messages) //遍历_messages数组
      message.animationController.dispose(); //释放动效
    super.dispose();
  }

  //定义发送文本事件的处理函数
  void _handleSubmitted(String text) {
    _textController.clear(); //清空输入框
    ChatMessage message = ChatMessage(
      //定义新的消息记录控件对象
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 500), //动画持续时间
        vsync: this, //默认属性和参数
      ),
    );
    //状态变更，向聊天记录中插入新记录
    setState(() {
      _isComposing = false;
      _messages.insert(0, message); //插入新的消息记录
    });
    message.animationController.forward(); //启动动画
  }

  //定义文本输入框控件
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        //文本输入和发送按钮都在同一行，使用Row控件包裹实现
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController, //载入文本输入控件
              onChanged: (String text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                  hintText: "Send a message"), //输入框中默认提示文字
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? //modified
                CupertinoButton(
                    //使用Cupertino控件库的CupertinoButton控件作为IOS端的发送按钮
                    child: Text("Send"),
                    onPressed: _isComposing
                        ? () => _handleSubmitted(_textController.text)
                        : null,
                  )
                : IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _isComposing
                        ? () =>
                            _handleSubmitted(_textController.text) //modified
                        : null, //modified  当没有为onPressed绑定处理函数时，IconButton默认为禁用状态
                  ),
          ),
        ],
      ),
    );
  }

  //定义整个聊天窗口的页面元素布局
  Widget build(BuildContext context) {
    return Scaffold(
      //页面脚手架
      appBar: AppBar(
          title: Text("Friendlychat"),
          elevation: Theme.of(context).platform == TargetPlatform.iOS
              ? 0.0
              : 4.0), //适配IOS的扁平化无阴影效果
      //页面标题
      body: SafeArea(
        child: Container(
            child: Column(
              //Column使消息记录和消息输入框垂直排列
              children: <Widget>[
                Flexible(
                    //子控件可柔性填充，如果下方弹出输入框，使消息记录列表可适当缩小高度
                    child: ListView.builder(
                  //可滚动显示的消息列表
                  padding: EdgeInsets.all(8.0),
                  reverse: true, //反转排序，列表信息从下至上排列
                  itemBuilder: (_, int index) => _messages[index], //插入聊天信息控件
                  itemCount: _messages.length,
                )),
                Divider(height: 1.0), //聊天记录和输入框之间的分隔
                Container(
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: _buildTextComposer(), //页面下方的文本输入控件
                ),
              ],
            ),
            decoration:
                Theme.of(context).platform == TargetPlatform.iOS //加入主题风格
                    ? BoxDecoration(
                        border: Border(
                          //为适应IOS加入边框特性
                          top: BorderSide(color: Colors.grey[200]), //顶部加入灰色边框
                        ),
                      )
                    : null),
      ),
    );
  }
}
