import 'package:flutter/material.dart';

class SpecialOffersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Special Offers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              OfferCard(imageUrl: 'assets/images/offer1.png'),
              SizedBox(width: 16),
              OfferCard(imageUrl: 'assets/images/offer2.png'),
            ],
          ),
        ),
      ],
    );
  }
}

class OfferCard extends StatelessWidget {
  final String imageUrl;

  const OfferCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
