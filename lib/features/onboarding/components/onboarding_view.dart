import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../data/onboarding_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    super.key,
    required this.data,
  });

  final OnboardingModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          height: MediaQuery.of(context).size.width / 1.1,
          child: Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Image.asset(
              data.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              data.headline,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w900, fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Text(
                data.description,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.normal, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ],
    );
  }
}
