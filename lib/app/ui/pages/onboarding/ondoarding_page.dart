import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/infra/models/onborading/onboarding_model.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

@RoutePage()
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final List<OnboardingModel> pages = [
      OnboardingModel(
        title: AppLocalizations.of(context)!.onboardingTitle1,
        description: AppLocalizations.of(context)!.onboardingDescription1,
        image: Assets.images.onboarding1.path,
      ),
      OnboardingModel(
        title: AppLocalizations.of(context)!.onboardingTitle2,
        description: AppLocalizations.of(context)!.onboardingDescription2,
        image: Assets.images.onboarding2.path,
      ),
      OnboardingModel(
        title: AppLocalizations.of(context)!.onboardingTitle3,
        description: AppLocalizations.of(context)!.onboardingDescription3,
        image: Assets.images.onboarding3.path,
      ),
      OnboardingModel(
        title: AppLocalizations.of(context)!.onboardingTitle4,
        description: AppLocalizations.of(context)!.onboardingDescription4,
        image: Assets.images.onboarding4.path,
        skip: false,
      ),
    ];
    void onNextPage() {
      if (_activePage < pages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
        );
      }
    }

    void onSkipPage() {
      if (_activePage < pages.length - 1) {
        _pageController.animateToPage(
          pages.length - 1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    }

    List<Widget> buildIndicator() {
      final indicators = <Widget>[];

      for (var i = 0; i < pages.length; i++) {
        if (_activePage == i) {
          indicators.add(_indicatorsTrue());
        } else {
          indicators.add(_indicatorsFalse());
        }
      }
      return indicators;
    }

    return Scaffold(
      backgroundColor: AppColors.silver950.withOpacity(0.2),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            scrollBehavior: AppScrollBehavior(),
            onPageChanged: (page) {
              setState(() {
                _activePage = page;
              });
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          stops: [0.55, 0.9],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image(
                        image: AssetImage(pages[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        Text(
                          pages[index].title,
                          style: textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          pages[index].description,
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
          if (pages[_activePage].skip == true)
            Positioned(
              top: 30,
              right: 20,
              child: TextButton(
                style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                onPressed: onSkipPage,
                child: Text(
                  AppLocalizations.of(context)!.labelSkip,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.silver200,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 25,
            right: 10,
            left: 10,
            child: Row(
              children: [
                if (_activePage < pages.length - 1)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ...buildIndicator(),
                      ],
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _activePage < pages.length - 1 ? 10 : 40,
                    ),
                    child: ElevatedButton(
                      onPressed: _activePage < pages.length - 1
                          ? onNextPage
                          : () {
                              context.router.push(const SignInRoute());
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _activePage < pages.length - 1
                                ? AppLocalizations.of(context)!.labelNext
                                : AppLocalizations.of(context)!.labelStarted,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.silver200,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (_activePage < pages.length - 1)
                            const Icon(
                              Icons.navigate_next_rounded,
                              color: AppColors.silver200,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _indicatorsTrue() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      margin: const EdgeInsets.only(right: 2, left: 2),
      height: 6,
      width: 22,
      decoration: BoxDecoration(
        color: AppColors.visVis500,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      margin: const EdgeInsets.only(right: 2, left: 2),
      height: 6,
      width: 14,
      decoration: BoxDecoration(
        color: AppColors.silver50,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
