import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';
import 'stats_leaderboard_view.dart';
import 'anatomy_screen.dart';
import 'beginner_programs_screen.dart';
import 'nutrition_tracking_screen.dart';
import 'settings_view.dart'; // Importation du nouvel écran de paramètres

class HomeScreen extends StatefulWidget {
  final String initialLanguage;
  const HomeScreen({Key? key, required this.initialLanguage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _currentLanguage;
  int _currentIndex = 0;

  // Dictionnaires de texte pour le support multi-langues
  final Map<String, Map<String, String>> _uiTexts = {
    'FR': {
      'title': 'Exercices',
      'leaderboardTitle': 'Classement',
      'subtitle': '« Entraînez-vous intelligemment. Bougez bien. »',
      'btnAnatomy': 'Mode Anatomique Interactif 🧍‍♂️',
      'chest': 'Séance Pectoraux', 'chestSub': 'Ciselé. Puissance. Poussez fort.',
      'legs': 'Séance Jambes', 'legsSub': 'Force. Puissance. Stabilité.',
      'abs': 'Séance Abdos / Core', 'absSub': 'Gainage. Contrôle. Définition.',
      'shoulders': 'Séance Épaules', 'shouldersSub': 'Développer. Galber. Renforcer.',
      'back': 'Séance Dos', 'backSub': 'Amplitude. Densité. Posture.',
      'arms': 'Séance Bras', 'armsSub': 'Volume. Congestion. Force.',
      'navExercise': 'Exercice', 'navStats': 'Stats', 'navFav': 'Nutrition', 'navSettings': 'Paramètres'
    },
    'EN': {
      'title': 'Exercise',
      'leaderboardTitle': 'Leaderboard',
      'subtitle': '“Train Wise. Move Right.”',
      'btnAnatomy': 'Interactive Anatomy Mode 🧍‍♂️',
      'chest': 'Chest Workout', 'chestSub': 'Chisel. Power. Push Hard.',
      'legs': 'Leg Workout', 'legsSub': 'Power. Strength. Stability.',
      'abs': 'Abs / Core Workout', 'absSub': 'Core. Control. Definition.',
      'shoulders': 'Shoulder Workout', 'shouldersSub': 'Lift. Shape. Strengthen.',
      'back': 'Back Workout', 'backSub': 'Width. Density. Posture.',
      'arms': 'Arms Workout', 'armsSub': 'Volume. Pump. Strength.',
      'navExercise': 'Exercise', 'navStats': 'Stats', 'navFav': 'Nutrition', 'navSettings': 'Settings'
    },
    'AR': {
      'title': 'التمارين',
      'leaderboardTitle': 'المتصدرين',
      'subtitle': '«تدرب بذكاء. تحرك بشكل صحيح.»',
      'btnAnatomy': 'الوضع التشريحي التفاعلي 🧍‍♂️',
      'chest': 'تمارين الصدر', 'chestSub': 'نحت. قوة. دفع بأقصى قوة.',
      'legs': 'تمارين الأرجل', 'legsSub': 'قوة. تحمل. استقرار.',
      'abs': 'تمارين البطن / الجذع', 'absSub': 'ثبات. تحكم. بروز.',
      'shoulders': 'تمارين الأكتاف', 'shouldersSub': 'رفع. تشكيل. تقوية.',
      'back': 'تمارين الظهر', 'backSub': 'عرض. كثافة. استقامة.',
      'arms': 'تمارين الذراعين', 'armsSub': 'ضخامة. تفجير. قوة.',
      'navExercise': 'التمارين', 'navStats': 'الاحصائيات', 'navFav': 'التغذية', 'navSettings': 'الإعدادات'
    },
  };

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.initialLanguage;
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = _currentLanguage == 'AR';
    final texts = _uiTexts[_currentLanguage]!;

    final List<Map<String, dynamic>> categories = [
      {'id': 'chest', 'title': texts['chest']!, 'subtitle': texts['chestSub']!, 'image': 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=500'},
      {'id': 'legs', 'title': texts['legs']!, 'subtitle': texts['legsSub']!, 'image': 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?q=80&w=500'},
      {'id': 'abs', 'title': texts['abs']!, 'subtitle': texts['absSub']!, 'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=500'},
      {'id': 'shoulders', 'title': texts['shoulders']!, 'subtitle': texts['shouldersSub']!, 'image': 'https://images.unsplash.com/photo-1532029837206-abbe2b7620e3?q=80&w=500'},
      {'id': 'back', 'title': texts['back']!, 'subtitle': texts['backSub']!, 'image': 'https://images.unsplash.com/photo-1603287681836-b174ce5074c2?q=80&w=500'},
      {'id': 'arms', 'title': texts['arms']!, 'subtitle': texts['armsSub']!, 'image': 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=500'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Icon(
              _currentIndex == 0 
                  ? Icons.fitness_center 
                  : (_currentIndex == 1 ? Icons.emoji_events : (_currentIndex == 2 ? Icons.restaurant_rounded : Icons.settings)), 
              color: Colors.white, 
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              _currentIndex == 0 
                  ? texts['title']! 
                  : (_currentIndex == 1 ? texts['leaderboardTitle']! : (_currentIndex == 2 ? texts['navFav']! : texts['navSettings']!)),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFC0F235)),
            ),
          ],
        ),
        actions: [_buildLanguageDropdown()],
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: IndexedStack(
            index: _currentIndex,
            children: [
              // Onglet 0 : Liste des exercices
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      texts['subtitle']!,
                      style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC0F235),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.rocket_launch_rounded, fontWeight: FontWeight.bold),
                      label: Text(
                        _currentLanguage == 'AR' ? 'برامج المبتدئين ' : 'Programmes Débutants ',
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BeginnerProgramsScreen(currentLanguage: _currentLanguage),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1E1E),
                        foregroundColor: const Color(0xFFC0F235),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Color(0xFFC0F235), width: 1),
                        ),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.accessibility_new_rounded),
                      label: Text(
                        texts['btnAnatomy']!,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnatomyScreen(currentLanguage: _currentLanguage),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDetailScreen(
                                  categoryId: item['id'],
                                  categoryName: item['title'],
                                  currentLanguage: _currentLanguage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(image: NetworkImage(item['image']), fit: BoxFit.cover),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [Colors.black.withOpacity(0.85), Colors.black.withOpacity(0.2)],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item['title'], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(color: const Color(0xFFC0F235), borderRadius: BorderRadius.circular(20)),
                                        child: Text(item['subtitle'], style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              // Onglet 1 : Classement (Stats Leaderboard)
              StatsLeaderboardView(currentLanguage: _currentLanguage),
              
              // Onglet 2 : Suivi Nutrition
              NutritionTrackingScreen(currentLanguage: _currentLanguage),
              
              // Onglet 3 : Paramètres avec gestion des avatars
              SettingsView(currentLanguage: _currentLanguage),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: const Color(0xFF1A1A1A)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xFFC0F235),
          unselectedItemColor: Colors.grey[600],
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: _currentIndex == 0 ? const Color(0xFFC0F235).withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.fitness_center),
              ),
              label: texts['navExercise']!,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: _currentIndex == 1 ? const Color(0xFFC0F235).withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.show_chart),
              ),
              label: texts['navStats']!,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: _currentIndex == 2 ? const Color(0xFFC0F235).withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.restaurant_rounded),
              ),
              label: texts['navFav']!,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: _currentIndex == 3 ? const Color(0xFFC0F235).withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.settings),
              ),
              label: texts['navSettings']!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _currentLanguage,
          dropdownColor: const Color(0xFF1E1E1E),
          icon: const Icon(Icons.language, color: Colors.white, size: 16),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          onChanged: (newValue) {
            if (newValue != null) setState(() => _currentLanguage = newValue);
          },
          items: <String>['EN', 'FR', 'AR'].map((String v) => DropdownMenuItem<String>(value: v, child: Text(v))).toList(),
        ),
      ),
    );
  }
}