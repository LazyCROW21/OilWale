import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/theme/themedata.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? product;
  EdgeInsets p1 = EdgeInsets.all(4);
  final TextStyle heading1 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 28.0, color: Colors.black);
  final TextStyle heading2 = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black);
  final TextStyle desc = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 16.0, color: Colors.grey);
  final List<String> imageURLList = [
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200',
    'https://picsum.photos/200'
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   args = ModalRoute.of(context)!.settings.arguments as String;
  // }
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepOrange),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Product',
            style: textStyle('h4', AppColorSwatche.primary),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      child: Hero(
                    tag: ValueKey(product!.id),
                    child: CarouselSlider(
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height / 2.4,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false),
                      items: imageURLList
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Image.network(
                                        e,
                                        height: 600,
                                        width: 600,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product == null ? 'Not found' : product!.name,
                      textAlign: TextAlign.center,
                      style: textStyle('h4', AppColorSwatche.black),
                    ),
                  ),
                  Divider(
                    color: Colors.deepOrange,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description:',
                      style: textStyle('h5', AppColorSwatche.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product == null ? 'Not found' : product!.specification,
                      style: textStyle('p1', Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Details:',
                      style: textStyle('h5', AppColorSwatche.black),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Container(
                              padding: p1,
                              child: Text('Grade',
                                  style:
                                      textStyle('p1', AppColorSwatche.primary)),
                            ),
                            Container(
                              padding: p1,
                              child: Text(
                                product == null ? 'Not found' : product!.grade,
                                style: textStyle('p1', AppColorSwatche.black),
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Container(
                              padding: p1,
                              child: Text('Package Size',
                                  style:
                                      textStyle('p1', AppColorSwatche.primary)),
                            ),
                            Container(
                              padding: p1,
                              child: Text(
                                product == null
                                    ? 'Not found'
                                    : product!.packingSize,
                                style: textStyle('p1', AppColorSwatche.black),
                              ),
                            )
                          ])
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Recommended Models:",
                      style: textStyle('h5', AppColorSwatche.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "> Model1 Brand1",
                          style: textStyle('p1', AppColorSwatche.black),
                        ),
                        Text(
                          "> Model2 Brand2",
                          style: textStyle('p1', AppColorSwatche.black),
                        ),
                        Text(
                          "> Model3 Brand3",
                          style: textStyle('p1', AppColorSwatche.black),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
