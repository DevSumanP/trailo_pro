// State class to hold the onbparding page index
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingState {
  final PageController pageController;
  final int currentPage;

  OnboardingState({
    required this.pageController,
    required this.currentPage,
  });

  OnboardingState copyWith({PageController? pageController, int? currentPage}) {
    return OnboardingState(
      pageController: pageController ?? this.pageController,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

// State Notifier to manage onboarding logic
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier()
      : super(
            OnboardingState(pageController: PageController(), currentPage: 0));

  void updatePageIndicator(int index) {
    state = state.copyWith(currentPage: index);
  }

  void nextPage() {
    final nextPage = state.currentPage + 1;
    if (nextPage < 3) {
      state.pageController.animateToPage(nextPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      updatePageIndicator(nextPage);
    }
  }

  void skipToLastPage() {
    final lastPage = 2;
    state.pageController.jumpToPage(lastPage);
    updatePageIndicator(lastPage);
  }
}

// Provider
final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>(
        (ref) => OnboardingNotifier());
