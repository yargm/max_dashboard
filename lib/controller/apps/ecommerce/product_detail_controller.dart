import 'package:maxdash/controller/my_controller.dart';

class ProductDetailController extends MyController {
  String selectedImage = "assets/dummy/single_product/single_product_1.png";

  final Map<String, dynamic> product = {
    "product_id": "12345",
    "name": "Slim Fit Denim Jacket",
    "description": "A stylish slim fit denim jacket for men. Perfect for casual outings and layering.",
    "category": "Jackets",
    "brand": "DenimCo",
    "size": [
      "S",
      "M",
      "L",
      "XL",
    ],
    "color": [
      "Blue",
      "Black",
      "Grey",
    ],
    "material": "Denim (100% Cotton)",
    "price": 59.99,
    "currency": "USD",
    "available_stock": {
      "S": 15,
      "M": 20,
      "L": 10,
      "XL": 5,
    },
    "images": [
      "assets/dummy/single_product/single_product_1.png",
      "assets/dummy/single_product/single_product_2.png",
      "assets/dummy/single_product/single_product_3.png",
      "assets/dummy/single_product/single_product_4.png",
      "assets/dummy/single_product/single_product_5.png",
      "assets/dummy/single_product/single_product_6.png",
    ],
    "rating": 4.5,
    "reviews": [
      {
        "user": "john_doe",
        "rating": 5,
        "comment": "Great fit and quality! Really happy with this jacket.",
      },
      {
        "user": "jane_smith",
        "rating": 4,
        "comment": "Good jacket but I wish it came in a larger size.",
      }
    ],
    "release_date": "2024-09-15",
    "shipping_details": {
      "weight": "1.2 kg",
      "dimensions": "40 x 30 x 5 cm",
      "shipping_cost": 4.99,
      "delivery_time": "3-5 business days",
    },
    "discounts": {
      "current_discount": 10,
      "discount_type": "percentage",
      "start_date": "2024-11-01",
      "end_date": "2024-11-30",
    },
    "tags": [
      "Casual",
      "Men",
      "Slim Fit",
      "Denim",
      "Jacket",
    ]
  };

  void onChangeImage(String image) {
    selectedImage = image;
    update();
  }
}
