import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import 'login_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Discover Tribal Culture',
      description: 'Explore authentic tribal heritage, traditions, and lifestyles with immersive experiences.',
      icon: Icons.explore_outlined,
      color: const Color(0xFF667eea),
    ),
    OnboardingData(
      title: 'Premium Tourism',
      description: 'Book exclusive tribal tours, homestays, and adventure activities with local guides.',
      icon: Icons.landscape_outlined,
      color: const Color(0xFF764ba2),
    ),
    OnboardingData(
      title: 'Authentic Marketplace',
      description: 'Shop genuine tribal handicrafts, art, clothing, and traditional food items.',
      icon: Icons.store_outlined,
      color: const Color(0xFFf093fb),
    ),
    OnboardingData(
      title: 'Cultural Events',
      description: 'Join tribal festivals, music shows, and cultural celebrations.',
      icon: Icons.celebration_outlined,
      color: const Color(0xFF43e97b),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _pages[_currentPage].color.withOpacity(0.8),
              _pages[_currentPage].color.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () => _navigateToLogin(),
                    child: Text(
                      'Skip',
                      style: AppTheme.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              
              // PageView
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_pages[index], index);
                  },
                ),
              ),
              
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ).animate()
                    .scale(duration: 300.ms)
                    .fadeIn(duration: 300.ms),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Navigation Buttons
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    if (_currentPage > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Previous'),
                        ),
                      )
                    else
                      const Expanded(child: SizedBox()),
                    
                    if (_currentPage > 0) const SizedBox(width: 16),
                    
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            _navigateToLogin();
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _pages[_currentPage].color,
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingData data, int index) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(75),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(
              data.icon,
              size: 80,
              color: Colors.white,
            ),
          ).animate()
            .scale(
              delay: (300 * index).ms,
              duration: 600.ms,
              curve: Curves.elasticOut,
            )
            .fadeIn(delay: (300 * index).ms, duration: 600.ms),
          
          const SizedBox(height: 40),
          
          // Title
          Text(
            data.title,
            style: AppTheme.headingLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ).animate()
            .slideY(
              begin: 50,
              delay: (500 * index).ms,
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(delay: (500 * index).ms, duration: 600.ms),
          
          const SizedBox(height: 16),
          
          // Description
          Text(
            data.description,
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white.withOpacity(0.9),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate()
            .slideY(
              begin: 30,
              delay: (700 * index).ms,
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(delay: (700 * index).ms, duration: 600.ms),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}