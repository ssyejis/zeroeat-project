import 'package:flutter/material.dart';

import '../features/home/home_page.dart';
import '../features/search/search_page.dart';
import '../features/product/product_page.dart';
import '../features/community/review_page.dart';
import '../features/community/review_form.dart';
import '../features/category/category_page.dart';
import '../models.dart';
import 'routes.dart';

class ZeroEatRouter {
  const ZeroEatRouter._();

  static String get initialRoute => ZeroEatRoutes.home;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Allow deep links like '/productDetail?id=123' or '/productDetail/123'
    final uri = settings.name != null ? Uri.parse(settings.name!) : null;
    switch (uri?.path ?? settings.name) {
      case ZeroEatRoutes.home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case ZeroEatRoutes.search:
        return MaterialPageRoute<void>(
          builder: (_) => const SearchPage(),
          settings: settings,
        );
      case ZeroEatRoutes.productDetail:
        // Try to get Product from arguments first (normal navigation)
        var product = settings.arguments;

        // If not provided via arguments, try to parse id from URL
        if (product is! Product) {
          final idFromQuery = uri?.queryParameters['id'];
          final idFromPath = uri != null && uri.pathSegments.length > 1
              ? uri.pathSegments[1]
              : null;
          final id = idFromQuery ?? idFromPath;
          if (id != null) {
            // Try to find product from in-memory dummy list
            try {
              product = productDummyList.firstWhere((p) => p.id == id);
            } catch (_) {
              product = null;
            }
          }
        }

        if (product is! Product) {
          return MaterialPageRoute<void>(
            builder: (_) => const _UnknownRoutePage(),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (_) => ProductDetailPage(product: product as Product),
          settings: settings,
        );
      case ZeroEatRoutes.review:
        final product = settings.arguments;
        if (product is! Product) {
          return MaterialPageRoute<void>(
            builder: (_) => const _UnknownRoutePage(),
            settings: settings,
          );
        }
        return MaterialPageRoute<void>(
          builder: (_) => ReviewPage(product: product),
          settings: settings,
        );
      case ZeroEatRoutes.reviewForm:
        return MaterialPageRoute(
          builder: (_) => ReviewForm(),
        );
      case ZeroEatRoutes.category:
        // Allow selecting a category via arguments or query param
        String? category;
        if (settings.arguments is String) category = settings.arguments as String;
        final catFromQuery = uri?.queryParameters['category'];
        if (catFromQuery != null && catFromQuery.isNotEmpty) category = catFromQuery;
        return MaterialPageRoute<void>(
          builder: (_) => CategoryList(selectedCategory: category),
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => _UnknownRoutePage(routeName: settings.name),
          settings: settings,
        );
    }
  }
}

class _UnknownRoutePage extends StatelessWidget {
  const _UnknownRoutePage({this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page not found')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('페이지 없음'),
          ],
        ),
      ),
    );
  }
}
