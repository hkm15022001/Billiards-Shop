import 'package:flutter/material.dart';
import 'package:hk_mobile/core/components/network_img.dart';
import 'package:hk_mobile/dto/product_dto.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDto product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    var listImages = <String>[];
    listImages.add(widget.product.variants[0].thumbnail!);
    var count = 1;
    for (var item in widget.product.variants[0].pictures?.whereType<String>().toList() ?? []) {
      if (count == 5) {
        break;
      }
      listImages.add(item);
      count++;
    }
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(350),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
                tag: widget.product.id.toString(),
                child: NetworkImg(imageUrl: listImages[selectedImage], imageFit: BoxFit.contain)),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(listImages.length, (index) => buildSmallProductPreview(index, listImages)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index, List<String> listImages) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(
          listImages[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
