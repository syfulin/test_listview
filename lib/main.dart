import 'package:flutter/material.dart';
import 'package:listview_optimize/animation/my_blur_page.dart';
import 'package:listview_optimize/details/details_page.dart';
import 'package:listview_optimize/models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> roductsItems = List<Product>();
  @override
  void initState() {
    super.initState();
    roductsItems = List<Product>.generate(
      50,
      (i) => Product(
        image: "assets/images/test_products/product${(i) % 9}.png",
        title: i % 2 == 0 ? "Сладкий грейпфрут" : "Мелиса и Мята",
        subtitle: i % 2 == 0 ? "Фруктовый" : "Royal smoke",
        price: (i * i).toDouble(),
        canOrder: true,
        index: i,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: ListView.builder(
            itemCount: roductsItems.length,
            itemBuilder: (context, index) {
              return ProductListTile(product: roductsItems[index]);
            },
          ),
        ),
      ),
    );
  }
}

// LIST ITEM
class ProductListTile extends StatelessWidget {
  final Product product;
  const ProductListTile({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Open details card.
        Navigator.push(
          context,
          createBlurRouteWithBlurBackground(Details(), '/details',
              arguments: product),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              top: 13,
              bottom: 13,
              right: 17,
            ),
            child: Image.asset(
              product.image,
              width: 82,
              height: 94,
            ),
          ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: 450),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    product.title,
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 148, 121),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    product.subtitle,
                    style: TextStyle(
                      color: Color.fromARGB(255, 175, 175, 189),
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₽${product.price.toString()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14, // 14
                            height: 2.4,
                          ),
                        ),
                        product.canOrder
                            ? Image.asset(
                                'assets/icons/icon_table.png',
                                width: 16,
                                height: 11,
                              )
                            : Row(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
