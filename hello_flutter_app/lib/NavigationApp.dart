import 'package:flutter/material.dart'; 

// 导航
class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('技师列表')),
      body: Center(
        child: RaisedButton(
          child: Text('查看技师资料'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> SecondScreenPage()
            ));
          },
        ),
      )
    );
  }
}

// 导航详情页
class SecondScreenPage extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('技师资料')),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

// 技师类 
class Product {
  final String title;
  final String description;

  Product(this.title, this.description);
}

// 技师列表脚手架
class ProductHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductList(
      products:List.generate(
        20, (i)=>Product('专业技师 $i 号', '漂亮的小姐姐,编号为 $i')
      )
    );
  }
}

// 技师列表
class ProductList extends StatelessWidget {
  final List<Product> products;
  ProductList({Key key, @required this.products}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('技师列表')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(products[index].title),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => ProductDetail(product:products[index])
                )
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key, @required this.product}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${product.title}号技师详情')),
      body: Center(child: Text('${product.description}')),
    );
  }
}
