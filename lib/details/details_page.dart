import 'package:flutter/material.dart';
import 'package:listview_optimize/animation/my_blur_page.dart';
import 'package:listview_optimize/models/product.dart';
// import 'package:listview_optimize/animation/my_blur_page.dart';
// import 'package:listview_optimize/product.dart';

class Details extends StatelessWidget {
  Details();

  @override
  Widget build(BuildContext context) {
    // Получение данных с предыдущего экрана:
    final Product product = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      onTap: () {
        MyBlurPage.pop(context); // Опционально
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.centerLeft,
          height: double.infinity,

          color: Color.fromARGB(204, 18, 18, 18),
          // Сверху нужен такой отступ, что бы небыло видно
          // первый элемент списка товаров
          padding: EdgeInsets.only(top: 98),
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            color: Color.fromARGB(255, 17, 17, 17), // test --
            height: double.infinity,

            child: Stack(children: [
              Container(
                // color: Colors.green,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //
                      SizedBox(height: 17),
                      // 1. Изображение товара
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 27),
                          child: Image.asset(
                            product.image,
                            width: 263 / 100 * 80, // меньше, чем в макете
                            height: 252 / 100 * 80, // меньше, чем в макете
                          ),
                        ),
                      ),

                      SizedBox(height: 4),
                      // 2. Информация о товаре
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 63),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1.1 Наименование товара
                              Text(
                                product.title,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 84, 148, 121),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1.25,
                                ),
                              ),
                              //
                              SizedBox(height: 10),
                              // 1.2 Подзаголовок
                              Text(
                                product.subtitle,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 175, 175, 189),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12, // 14
                                ),
                              ),
                              //
                              SizedBox(height: 13),
                              // Ценник
                              Text(
                                '₽${product.price.toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 24, // 14
                                ),
                              ),
                              //
                              SizedBox(height: 18),
                              // Количество товара
                              Text(
                                '-   1   +', // три пробела между символами
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 24, // 14
                                ),
                              ),
                              //
                              SizedBox(height: 28),
                              // Самая нижняя строка
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // "Состав:"
                                        Text(
                                          'Состав:',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14, // 14
                                          ),
                                        ),
                                        SizedBox(height: 7),

                                        // Состав
                                        Text(
                                          'Чай черный, рассыпной, листовой, крупный, цедра цитрусовых, ломтики цитрусовых, ароматизатор, кусочки грейпфрута (грейпфрут, сахар, подкислитель: лимонная кислота), липестки розы.', // три пробела между символами
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                127, 255, 255, 255),
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 9, // 14
                                            height: 1.85,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //
                                  SizedBox(width: 70),
                                  // // ЗАКАЗАТЬ
                                  // // Заказать к столу
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   // color: Colors.green,
                                  //   // Заказать товар
                                  //   child: product.canOrder
                                  //       ? Container(
                                  //           padding: EdgeInsets.only(right: 20),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Text(
                                  //                 '→',
                                  //                 style: TextStyle(
                                  //                   color: Colors.white,
                                  //                   fontFamily: 'Montserrat',
                                  //                   fontWeight:
                                  //                       FontWeight.normal,
                                  //                   fontSize: 18, // 14
                                  //                   height: 1.6,
                                  //                 ),
                                  //               ),
                                  //               SizedBox(width: 2),
                                  //               Image.asset(
                                  //                 'assets/icons/icon_table.png',
                                  //                 width: 30,
                                  //                 height: 20,
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         )
                                  //       : Row(),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
              // Кнопка ЗАКРЫТЬ
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.only(right: 20),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  // color: Colors.blue,
                  child: Text(
                    'X',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.normal,
                      fontSize: 25, // 14
                    ),
                  ),
                ),
              ),
              // Кнопка ЗАКАЗАТЬ
              Align(
                alignment: Alignment.bottomRight,
                child: product.canOrder
                    ? Container(
                        height: 80,
                        width: 85,
                        // color: Colors.red,
                        // padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '→',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.normal,
                                fontSize: 18, // 14
                                height: 1.6,
                              ),
                            ),
                            SizedBox(width: 2),
                            Image.asset(
                              'assets/icons/icon_table.png',
                              width: 30,
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    : Row(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
