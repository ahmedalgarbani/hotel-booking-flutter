// lib/GTX/views/screens/review_hotels/review_hotels_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels/GTX/controller/sortedByrievew.dart';
import 'package:hotels/GTX/views/widgets/ReviewHotelCardwidget/ReviewHotelCard.dart';

class ReviewHotelsScreen extends StatelessWidget {
  const ReviewHotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SortedHotelReviewController controller =
        Get.find<SortedHotelReviewController>();

    return Scaffold(
      appBar: AppBar(title: const Text("أفضل الفنادق حسب التقييم")),
      body: Obx(() {
        if (controller.hotelsListSorted.isEmpty) {
          return const Center(child: Text("لا توجد فنادق متاحة."));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: controller.hotelsListSorted.length,
          itemBuilder: (context, index) {
            final hotel = controller.hotelsListSorted[index];
            if (hotel.reviews.isEmpty) return const SizedBox();

            final review = hotel.reviews.first;
            final averageRating = (review.ratingCleanliness +
                    review.ratingLocation +
                    review.ratingService +
                    review.ratingValueForMoney) /
                4;

            return ReviewHotelCard(
              hotel: hotel,
              image: hotel.image,
              name: "${hotel.name} (${averageRating.toStringAsFixed(1)})",
              rating: averageRating,
              location: hotel.location,
            );
          },
        );
      }),
    );
  }
}
