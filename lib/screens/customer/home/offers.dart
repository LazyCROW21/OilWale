import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oilwale/components/offercard.dart';
import 'package:oilwale/models/offer.dart';
import 'package:oilwale/models/product.dart';
import 'package:oilwale/service/offer_api.dart';
import 'package:oilwale/theme/themedata.dart';

class OffersScreen extends StatefulWidget {
  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final Offer newOffer = Offer(
      description: 'A realy good offer',
      endsAt: '27 Nov, 2021',
      productList: [
        Product(
            id: 'asd',
            name: 'asdsdasd',
            grade: 'asdsads',
            specification: 'asdasdasdasdda',
            packingSize: '5ltr')
      ],
      schemeId: 'asddsadsadad',
      schemeName: 'New Offer',
      startedAt: '27 Nov, 2021',
      targetGroup: 'customer');

  bool _isLoadingActiveOffers = true;
  List<Offer> _activeOffers = [];
  bool _isLoadingUpComingOffers = true;
  List<Offer> _upComingOffers = [];

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    OffersAPIManager.getUpComingCustomerSchemes().then((_upcoming) {
      setState(() {
        _isLoadingUpComingOffers = false;
        _upComingOffers = _upcoming;
      });
    });

    OffersAPIManager.getActiveCustomerSchemes().then((_result) {
      setState(() {
        _isLoadingActiveOffers = false;
        _activeOffers = _result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // Upcoming Offers
            Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  'Upcoming Offers !!!',
                  style: textStyle('h5', AppColorSwatche.black),
                ),
                Expanded(child: Divider())
              ],
            ),
            _isLoadingUpComingOffers
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: SpinKitRing(
                        color: AppColorSwatche.primary,
                      ),
                    ),
                  )
                : (_upComingOffers.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nothing to show yet, keep checking'),
                      )
                    : Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _upComingOffers.length,
                          itemBuilder: (context, index) {
                            return OfferCard(_upComingOffers[index], 'active');
                          },
                        ),
                      )),

            SizedBox(
              height: 16,
            ),
            // Current Offers
            Row(
              children: [
                Expanded(child: Divider()),
                Text(
                  'Active Offers !!!',
                  style: textStyle('h5', AppColorSwatche.black),
                ),
                Expanded(child: Divider())
              ],
            ),
            _isLoadingActiveOffers
                ? Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: SpinKitRing(
                        color: AppColorSwatche.primary,
                      ),
                    ),
                  )
                : (_activeOffers.length == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Nothing to show yet, keep checking'),
                      )
                    : Container(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _activeOffers.length,
                          itemBuilder: (context, index) {
                            return OfferCard(_activeOffers[index], 'active');
                          },
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
