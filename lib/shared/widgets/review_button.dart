import 'package:flutter/material.dart';
import 'package:zeroeat/config/routes.dart';

class ReviewButton extends StatelessWidget {

  const ReviewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(ZeroEatRoutes.reviewForm);
        },
        backgroundColor: theme.colorScheme.primary,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 17,
        ),
        label: const Text(
          '리뷰 작성',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        extendedPadding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
      ),
    );
  }
}