import 'package:carousel_slider/carousel_slider.dart' as carousel_slider;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/card_design/visit_again_card.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/home/widgets/components/custom_triangle_shape.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/arrow_icon_button.dart';

class WebVisitAgainView extends StatefulWidget {
  final bool fromFood;
  const WebVisitAgainView({super.key, required this.fromFood});

  @override
  State<WebVisitAgainView> createState() => _WebVisitAgainViewState();
}

class _WebVisitAgainViewState extends State<WebVisitAgainView> {

  // Replace CarouselController with CarouselSliderController
  final carousel_slider.CarouselSliderController carouselController = carousel_slider.CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      List<Store>? stores;
      if (storeController.visitAgainStoreList != null && storeController.visitAgainStoreList!.length > 3) {
        stores = storeController.visitAgainStoreList;
      } else {
        stores = storeController.latestStoreList;
      }
      return stores != null && stores.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Text(
                storeController.visitAgainStoreList != null &&
                    storeController.visitAgainStoreList!.length > 3
                    ? "visit_again".tr
                    : '${"whats_new_on".tr} ${AppConstants.appName}',
                style: robotoBold.copyWith(color: Theme.of(context).cardColor),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              storeController.visitAgainStoreList != null &&
                  storeController.visitAgainStoreList!.length > 3
                  ? Text(
                'get_your_recent_purchase_from_the_shop_you_recently_visited'.tr,
                style: robotoRegular.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: Dimensions.fontSizeSmall),
              )
                  : const SizedBox(),
              SizedBox(
                  height: storeController.visitAgainStoreList != null &&
                      storeController.visitAgainStoreList!.length > 3
                      ? Dimensions.paddingSizeSmall
                      : 0),
              carousel_slider.CarouselSlider.builder( // Use CarouselSlider.builder
                carouselController: carouselController, // Use CarouselSliderController
                itemCount: stores.length,
                options: carousel_slider.CarouselOptions( // Use CarouselOptions
                  aspectRatio: 6,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .25,
                  enlargeFactor: 0.2,
                  onPageChanged: (index, reason) {},
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return VisitAgainCard(store: stores![index], fromFood: widget.fromFood);
                },
              ),
            ]),
          ),
          const Positioned(top: 20, left: 172, child: TriangleWidget()),
          const Positioned(top: 10, right: 116, child: TriangleWidget()),
          Positioned(
            top: 130,
            right: 0,
            child: ArrowIconButton(
              onTap: () => carouselController.nextPage(), // CarouselSliderController method
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            child: ArrowIconButton(
              onTap: () => carouselController.previousPage(), // CarouselSliderController method
              isRight: false,
            ),
          ),
        ]),
      )
          : const SizedBox();
    });
  }
}

class WebVisitAgainShimmerView extends StatelessWidget {
  final StoreController storeController;
  const WebVisitAgainShimmerView({super.key, required this.storeController});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Column(children: [
              Container(
                height: 20,
                width: 100,
                color: Colors.grey[300],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Container(
                height: 20,
                width: 200,
                color: Colors.grey[300],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              carousel_slider.CarouselSlider.builder( // Use CarouselSlider.builder
                itemCount: 5,
                options: carousel_slider.CarouselOptions( // Use CarouselOptions
                  aspectRatio: 6,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: .25,
                  enlargeFactor: 0.2,
                  onPageChanged: (index, reason) {},
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    height: 150,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                  );
                },
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
