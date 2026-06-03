import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import requis pour la redirection finale

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedLanguage = 'FR'; // Langue par défaut

  // Liens directs vers 3 photos de musculation/fitness totalement différentes
  final List<String> _gymImages = [
   'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=600', // Photo 1 : Haltères / Musculation
    'https://images.unsplash.com/photo-1476480862126-209bfaa8edc8?auto=format&fit=crop&q=80&w=600', // Nouvelle Photo 2 : Tracking / Progrès / Performance
    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=600', // Photo 3 : Effort intense / Crossfit
  ];
  

  // Traductions multi-langues pour le onboarding
  final Map<String, Map<String, dynamic>> _localizedContent = {
    'FR': {
      'btnNext': 'Suivant',
      'btnGetStarted': 'Commencer',
      'slides': [
        {
          'title': 'Bienvenue sur Ni-Gym',
          'description': 'Des plans adaptés par IA qui s\'ajustent à vos objectifs, vos limites et votre style de vie.',
        },
        {
          'title': 'Suivez vos Progrès',
          'description': 'Suivez vos réussites quotidiennes et restez motivé grâce à des statistiques et analyses en temps réel.',
        },
        {
          'title': 'Repoussez vos Limites',
          'description': 'Débloquez votre véritable potentiel avec des entraînements intensifs conçus spécialement pour vous.',
        },
      ]
    },
    'EN': {
      'btnNext': 'Next',
      'btnGetStarted': 'Get Started',
      'slides': [
        {
          'title': 'Welcome to Ni-Gym',
          'description': 'AI-curated plans that adapt to your goals, limits, and lifestyle — because fitness isn’t one-size-fits-all.',
        },
        {
          'title': 'Track Your Progress',
          'description': 'Monitor your daily achievements and stay motivated with real-time statistics and insights.',
        },
        {
          'title': 'Push Your Limits',
          'description': 'Unlock your true potential with high-intensity workouts designed just for you.',
        },
      ]
    },
    'AR': {
      'btnNext': 'التالي',
      'btnGetStarted': 'ابدأ الآن',
      'slides': [
        {
          'title': 'مرحباً بك في Ni-Gym',
          'description': 'خطط مدعومة بالذكاء الاصطناعي تتكيف مع أهدافك، حدودك، ونمط حياتك.',
        },
        {
          'title': 'تابع تقدمك',
          'description': 'راقب إنجازاتك اليومية وحافظ على حماسك باستخدام إحصائيات وتحليلات فورية.',
        },
        {
          'title': 'تحدى حدودك',
          'description': 'اكتشف طاقاتك الكامنة مع تمارين مكثفة مصممة خصيصاً من أجلك.',
        },
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    // Récupération des données selon la langue sélectionnée
    final currentLocal = _localizedContent[_selectedLanguage]!;
    final List<dynamic> slidesData = currentLocal['slides'];
    final isRtl = _selectedLanguage == 'AR';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // 1. Le PageView pour faire défiler les 3 slides
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: slidesData.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Image de fond unique pour chaque page de l'onboarding
                  Image.network(
                    _gymImages[index], 
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF121212),
                        child: const Center(
                          child: CircularProgressIndicator(color: Color(0xFFC0F235)),
                        ),
                      );
                    },
                  ),
                  // Dégradé sombre pour la lisibilité du texte
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                          Colors.black,
                        ],
                        stops: [0.3, 0.7, 1.0],
                      ),
                    ),
                  ),
                  // Contenu Textuel traduit dynamique
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Directionality(
                      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            slidesData[index]['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slidesData[index]['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 180), // Espace pour les boutons du bas
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. Bouton de sélection de langue fonctionnel
          Positioned(
            top: 50,
            right: isRtl ? null : 16,
            left: isRtl ? 16 : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  dropdownColor: const Color(0xFF1E1E1E),
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Icon(Icons.language, color: Colors.white, size: 18),
                  ),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                    }
                  },
                  items: <String>['EN', 'FR', 'AR'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // 3. Les indicateurs de page (Dots) et bouton de navigation
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Les Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slidesData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 10,
                      width: _currentPage == index ? 30 : 10,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xFFC0F235) // Vert ni_gym
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // Bouton principal (Suivant / Commencer)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < slidesData.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Redirection vers LoginScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(initialLanguage: _selectedLanguage),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC0F235),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _currentPage == slidesData.length - 1
                              ? currentLocal['btnGetStarted']!
                              : currentLocal['btnNext']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isRtl ? Icons.arrow_back : Icons.arrow_forward, 
                          size: 22
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}