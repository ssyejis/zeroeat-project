import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String brand,
    required String imageUrl,
    required double rating,
    required Ingredient ingredient,
    required List<String> tags, // ["무설탕","저칼로리","키토"]
  }) = _Product;
}

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required int kcal,
    required double sugarG,
    required double sodiumMg,
    required double fatG,
    required double proteinG,
    required List<String> warningIngredients
  }) = _Ingredient;
}

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String productId,
    required String author,
    required double stars,
    required String content,
    String? photoUrl,
    String? dietType,
    required DateTime createdAt,
  }) = _Review;
}

final productDummyList = <Product>[
  Product(
    id: 'prod_001',
    name: '제로 콜라 라임',
    brand: '펩시',
    imageUrl: 'assets/images/zeroCola.png',
    rating: 4.5,
    ingredient: Ingredient(
      kcal: 15,
      sugarG: 0,
      sodiumMg: 5,
      fatG: 0,
      proteinG: 0,
      warningIngredients: ['말티톨', '아스파탐'],
    ),
    tags: const ['무설탕', '제로칼로리'],
  ),
  Product(
    id: 'prod_002',
    name: '보성홍차 아이스티 제로',
    brand: '동원',
    imageUrl: 'assets/images/icedTea.png',
    rating: 4.2,
    ingredient: Ingredient(
      kcal: 210,
      sugarG: 4.5,
      sodiumMg: 120,
      fatG: 6,
      proteinG: 18,
      warningIngredients: ['아스파탐'],
    ),
    tags: const ['무설탕', '제로칼로리'],
  ),
  Product(
    id: 'prod_003',
    name: '파인트 생우유',
    brand: '라라스윗',
    imageUrl: 'assets/images/pintMilk.png',
    rating:0,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: [],
    ),
    tags: const ['저당', '프로바이오틱스', '저칼로리'],
  ),
  Product(
    id: 'prod_004',
    name: '에이스저당 검은콩 두유',
    brand: '베지밀',
    imageUrl: 'assets/images/soyMilk.png',
    rating: 4.8,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: ['아스파탐'],
    ),
    tags: const ['비건', '고단백', '저지방'],
  ),
  Product(
    id: 'prod_005',
    name: '고단백 저당 배꼽 베이글',
    brand: '널담',
    imageUrl: 'assets/images/bagel.png',
    rating: 4.8,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: ['말티톨'],
    ),
    tags: const ['저당', '고단백', '식사대용'],
  ),
  Product(
    id: 'prod_006',
    name: '프로틴 그래놀라',
    brand: '켈로그',
    imageUrl: 'assets/images/granola.png',
    rating: 4.8,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: [],
    ),
    tags: const ['저당', '고단백', '식사대용'],
  ),
  Product(
    id: 'prod_007',
    name: '식물성 두유 요거트',
    brand: '그린리브스',
    imageUrl: 'assets/images/soyMilk.png',
    rating: 4.8,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: [],
    ),
    tags: const ['비건', '프로바이오틱스', '저지방'],
  ),
  Product(
    id: 'prod_008',
    name: '식물성 두유 요거트',
    brand: '그린리브스',
    imageUrl: 'assets/images/soyMilk.png',
    rating: 4.8,
    ingredient: Ingredient(
      kcal: 95,
      sugarG: 2.3,
      sodiumMg: 40,
      fatG: 3.5,
      proteinG: 8,
      warningIngredients: [],
    ),
    tags: const ['비건', '프로바이오틱스', '저지방'],
  ),
];

final reviewDummyList = <Review>[
  Review(
    id: 'rev_001',
    productId: 'prod_001',
    author: 'ray_zero',
    stars: 4.5,
    content: '달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요. \n달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요.달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '일반',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Review(
    id: 'rev_002',
    productId: 'prod_001',
    author: 'healthy_rice',
    stars: 4.0,
    content: '우유에 말아 먹으면 든든해서 아침 대용으로 딱 좋습니다.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '키토',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Review(
    id: 'rev_003',
    productId: 'prod_001',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  Review(
    id: 'rev_004',
    productId: 'prod_001',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  Review(
    id: 'rev_005',
    productId: 'prod_001',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  Review(
    id: 'rev_001',
    productId: 'prod_002',
    author: 'ray_zero',
    stars: 4.5,
    content: '달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요. \n달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요.달지 않고 콜라맛이 잘 살아서 탄산이 생각날 때 마시기 좋아요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '일반',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  Review(
    id: 'rev_002',
    productId: 'prod_002',
    author: 'healthy_rice',
    stars: 4.0,
    content: '우유에 말아 먹으면 든든해서 아침 대용으로 딱 좋습니다.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '키토',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Review(
    id: 'rev_003',
    productId: 'prod_002',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  Review(
    id: 'rev_004',
    productId: 'prod_002',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
  Review(
    id: 'rev_005',
    productId: 'prod_002',
    author: 'vegan_runner',
    stars: 5.0,
    content: '비건 요거트 중에서 제일 상큼하고 뒷맛이 깔끔해요.',
    photoUrl: 'https://picsum.photos/seed/granola-bowl/600/400',
    dietType: '비건',
    createdAt: DateTime.now().subtract(const Duration(hours: 12)),
  ),
];
