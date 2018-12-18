import 'package:flutter/material.dart';

class TravelHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Image.network(
            'http://ghexoblogimages.oss-cn-beijing.aliyuncs.com/18-12-17/14367887.jpg',
            height: 240,
            fit: BoxFit.cover,
          ),
          ComponentTitle(),
          ComponentTools(),
          ComponentText(),
        ],
      ),
    ));
  }
}

class ComponentTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '不知道去哪国旅游团',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )),
                  Text(
                    '走到哪算哪...',
                    style: TextStyle(color: Colors.black45),
                  )
                ])),
            // Icon(
            //   Icons.star,
            //   color: Colors.red[500],
            // ),
            // Text('10')
            FavoriteWidget(),
          ],
        ));
  }
}

class ComponentTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Expanded buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return Expanded(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          )
        ],
      ));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
      child: Row(
        children: <Widget>[
          buildButtonColumn(Icons.call, '拨打'),
          buildButtonColumn(Icons.near_me, '定位'),
          buildButtonColumn(Icons.share, '分享'),
        ],
      ),
    );
  }
}

class ComponentText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
      child: Text(
        '''
一次和朋友去泰国的时候，我在路边买香蕉饼，他过来，也想买一个，和泰国的商贩说“老板来2个”，泰国的商贩对着他看了看，然后他才意识到原来需要说英文的，当成在自己城市里买路边摊，老板来2个了。同样的事情也发生在我上星期去日本的时候，我老婆在买蛋挞的时候，和日本的售货员说要2个，然后人家听不懂，然后立马反应过来，是在日本，只能说日语或者英语。在去苏州爬灵岩山的时候，其实我不是一个很喜欢爬小山的人，都想原路返回了，后来我朋友说，这个爬山要龙门进虎门出，不走回头路的，你不走不行的，于是我就被他拖着“龙门进虎门出”。和朋友去阳澄湖，阳澄湖有一个水上公园，里面有租4人自行车的，我们一辆4人自行车，硬生生的坐了7个人，引起了周边所有游客的关注，正当我们觉得很厉害的时候，对面来了一辆坐了8个人的，还带着一条小狗。
        ''',
        softWrap: true,
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 10;

  void _toActionFavorite() {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toActionFavorite,
          ),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}
