import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilmart/models/product.dart';
import 'package:oilmart/models/vehicle.dart';
import 'package:oilmart/service/vehicle_api.dart';
import 'package:oilmart/theme/themedata.dart';

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

  List<Vehicle> recommendedVehicles = [];
  bool isLoadingVList = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      product = ModalRoute.of(context)!.settings.arguments as Product;
      VehicleAPIManager.getRecommendedVehiclesByProductId(product!.id)
          .then((result) {
        setState(() {
          isLoadingVList = false;
          recommendedVehicles = result;
        });
      });
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColorSwatche.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Product',
            style: TextStyle(
                color: AppColorSwatche.white,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: product == null
            ? Center(
                child: SpinKitRing(
                  color: AppColorSwatche.primary,
                ),
              )
            : SingleChildScrollView(
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
                                height:
                                    MediaQuery.of(context).size.height / 2.4,
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
                        // Product Name
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
                        Card(
                          elevation: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Description:',
                                  style: textStyle('h5', AppColorSwatche.black),
                                ),
                              ),
                              Divider(
                                color: AppColorSwatche.primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product == null
                                      ? 'Not found'
                                      : product!.specification,
                                  style: textStyle('p1', Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Details:',
                                  style: textStyle('h5', AppColorSwatche.black),
                                ),
                              ),
                              Divider(
                                color: AppColorSwatche.primary,
                              ),
                              Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Table(
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          padding: p1,
                                          child: Text('Grade',
                                              style: textStyle('p1',
                                                  AppColorSwatche.primary)),
                                        ),
                                        Container(
                                          padding: p1,
                                          child: Text(
                                            product == null
                                                ? 'Not found'
                                                : product!.grade,
                                            style: textStyle(
                                                'p1', AppColorSwatche.black),
                                          ),
                                        )
                                      ]),
                                      TableRow(children: [
                                        Container(
                                          padding: p1,
                                          child: Text('Package Size',
                                              style: textStyle('p1',
                                                  AppColorSwatche.primary)),
                                        ),
                                        Container(
                                          padding: p1,
                                          child: Text(
                                            product == null
                                                ? 'Not found'
                                                : product!.packingSize,
                                            style: textStyle(
                                                'p1', AppColorSwatche.black),
                                          ),
                                        )
                                      ])
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Card(
                          elevation: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Recommended Models:",
                                  style: textStyle('h5', AppColorSwatche.black),
                                ),
                              ),
                              Divider(
                                color: AppColorSwatche.primary,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isLoadingVList
                                    ? SpinKitRing(
                                        color: AppColorSwatche.primary)
                                    : recommendedVehicles.length == 0
                                        ? Text(
                                            'No recommended models for this product.',
                                            style: textStyle(
                                                'p1', AppColorSwatche.black))
                                        : ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                recommendedVehicles.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                child: Row(
                                                  children: [
                                                    Icon(Icons
                                                        .arrow_right_rounded),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          "${recommendedVehicles[index].vehicleCompany} - ${recommendedVehicles[index].vehicleModel}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: textStyle(
                                                              'p1',
                                                              AppColorSwatche
                                                                  .black)),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ));
  }
}
