import 'package:flutter/material.dart';
import 'package:oilmart/models/product.dart';
import 'package:oilmart/theme/themedata.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: ValueKey(product.id),
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pushNamed(context, "/cust_product", arguments: product);
          },
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://picsum.photos/200',
                          height: 80,
                          width: 80,
                        )),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle('h4', AppColorSwatche.primary),
                            ),
                            Row(
                              children: [
                                Text('Grade: ',
                                    style:
                                        textStyle('h5', AppColorSwatche.black)),
                                Text(product.grade,
                                    style: textStyle(
                                        'h5', AppColorSwatche.primary)),
                              ],
                            ),
                            Text(product.specification,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle('p1', Colors.black)),
                          ],
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
