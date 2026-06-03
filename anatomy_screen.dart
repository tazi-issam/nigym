import 'package:flutter/material.dart';
import 'workout_detail_screen.dart';

class AnatomyScreen extends StatefulWidget {
  final String currentLanguage;
  const AnatomyScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<AnatomyScreen> createState() => _AnatomyScreenState();
}

class _AnatomyScreenState extends State<AnatomyScreen> {
  String? _selectedMuscleId;

  // Textes traduits pour l'interface
  final Map<String, Map<String, String>> _localizedTexts = {
    'FR': {
      'title': 'Anatomie Interactive',
      'subtitle': 'Appuyez sur un muscle du corps pour voir les exercices',
      'btnViewWorkout': 'Afficher les exercices',
      'chest': 'Pectoraux',
      'back': 'Dos (Dorsaux)',
      'shoulders': 'Épaules (Deltoïdes)',
      'arms': 'Bras (Biceps / Triceps)',
      'abs': 'Abdominaux',
      'legs': 'Jambes (Quadriceps / Mollets)',
    },
    'EN': {
      'title': 'Interactive Anatomy',
      'subtitle': 'Tap on a muscle to view specific exercises',
      'btnViewWorkout': 'Show Exercises',
      'chest': 'Chest',
      'back': 'Back',
      'shoulders': 'Shoulders',
      'arms': 'Arms',
      'abs': 'Abs / Core',
      'legs': 'Legs',
    },
    'AR': {
      'title': 'التشريح التفاعلي',
      'subtitle': 'اضغط على العضلة لعرض التمارين الخاصة بها',
      'btnViewWorkout': 'عرض التمارين',
      'chest': 'الصدر',
      'back': 'الظهر',
      'shoulders': 'الأكتاف',
      'arms': 'الذراعين',
      'abs': 'البطن',
      'legs': 'الأرجل',
    }
  };

  final Map<String, String> _muscleKeys = {
    'chest': 'chest',
    'back': 'back',
    'shoulders': 'shoulders',
    'arms': 'arms',
    'abs': 'abs',
    'legs': 'legs',
  };

  @override
  Widget build(BuildContext context) {
    final texts = _localizedTexts[widget.currentLanguage] ?? _localizedTexts['EN']!;
    final isRtl = widget.currentLanguage == 'AR';
    final selectedMuscleName = _selectedMuscleId != null ? texts[_muscleKeys[_selectedMuscleId]!] : null;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          texts['title']!,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  texts['subtitle']!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[400], fontStyle: FontStyle.italic),
                ),
              ),

              // Corps humain interactif dessiné vectoriellement
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 300,
                      height: 480,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey[900]!, width: 1),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Le dessin du corps (Silhouette + Muscles)
                          CustomPaint(
                            size: const Size(260, 440),
                            painter: HumanBodyPainter(selectedMuscleId: _selectedMuscleId),
                          ),

                          // Zones invisibles mais cliquables placées exactement par-dessus les muscles dessinés
                          // Épaules
                          _buildInvisibleTouchZone('shoulders', top: 40, left: 60, width: 140, height: 35),
                          // Pectoraux
                          _buildInvisibleTouchZone('chest', top: 65, left: 90, width: 80, height: 40),
                          // Bras Gauche et Droit
                          _buildInvisibleTouchZone('arms', top: 75, left: 55, width: 35, height: 90),
                          _buildInvisibleTouchZone('arms', top: 75, left: 170, width: 35, height: 90),
                          // Abdos
                          _buildInvisibleTouchZone('abs', top: 110, left: 95, width: 70, height: 60),
                          // Dos (Dorsaux visibles sur les côtés externes du buste)
                          _buildInvisibleTouchZone('back', top: 105, left: 80, width: 15, height: 50),
                          _buildInvisibleTouchZone('back', top: 105, left: 165, width: 15, height: 50),
                          // Jambes / Cuisses / Mollets
                          _buildInvisibleTouchZone('legs', top: 180, left: 80, width: 100, height: 220),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Panneau du bas qui affiche la sélection et le bouton vers les exercices
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: SizedBox(
                    width: double.infinity,
                    child: _selectedMuscleId == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.touch_app_rounded, color: const Color(0xFFC0F235).withOpacity(0.6), size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  widget.currentLanguage == 'AR' ? "مس العضلة" : "Touchez un muscle du corps",
                                  style: TextStyle(color: Colors.grey[500], fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                selectedMuscleName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC0F235), // Ton vert fluo ni_gym
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  elevation: 0,
                                ),
                                icon: const Icon(Icons.fitness_center_rounded, fontWeight: FontWeight.bold),
                                label: Text(
                                  texts['btnViewWorkout']!,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WorkoutDetailScreen(
                                        categoryId: _selectedMuscleId!,
                                        categoryName: selectedMuscleName,
                                        currentLanguage: widget.currentLanguage,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvisibleTouchZone(String id, {required double top, required double left, required double width, required double height}) {
    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _selectedMuscleId = (_selectedMuscleId == id) ? null : id;
          });
        },
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

// Le dessinateur avec l'énumération PaintingStyle corrigée
class HumanBodyPainter extends CustomPainter {
  final String? selectedMuscleId;
  HumanBodyPainter({required this.selectedMuscleId});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    // Définition des pinceaux avec PaintingStyle
    final Paint bodyBasePaint = Paint()
      ..color = const Color(0xFF2B2B2B)
      ..style = PaintingStyle.fill; // <-- Corrigé ici

    final Paint outlinePaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke // <-- Corrigé ici
      ..strokeWidth = 1.5;

    final Paint muscleDefaultPaint = Paint()
      ..color = const Color(0xFF3D3D3D)
      ..style = PaintingStyle.fill; // <-- Corrigé ici

    final Paint muscleSelectedPaint = Paint()
      ..color = const Color(0xFFC0F235)
      ..style = PaintingStyle.fill; // <-- Corrigé ici

    Paint getMusclePaint(String id) => (selectedMuscleId == id) ? muscleSelectedPaint : muscleDefaultPaint;

    // --- 1. SILHOUETTE DE BASE ---
    canvas.drawCircle(Offset(center, 25), 16, bodyBasePaint);
    canvas.drawCircle(Offset(center, 25), 16, outlinePaint);
    canvas.drawRect(Rect.fromLTWH(center - 5, 41, 10, 10), bodyBasePaint);

    // --- 2. ÉPAULES ---
    final Paint shoulderPaint = getMusclePaint('shoulders');
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 65, 48, 25, 25), const Radius.circular(8)), shoulderPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 65, 48, 25, 25), const Radius.circular(8)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 40, 48, 25, 25), const Radius.circular(8)), shoulderPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 40, 48, 25, 25), const Radius.circular(8)), outlinePaint);

    // --- 3. DOS / DORSAUX ---
    final Paint backPaint = getMusclePaint('back');
    Path leftVast = Path()
      ..moveTo(center - 40, 95)
      ..lineTo(center - 50, 115)
      ..lineTo(center - 35, 145)
      ..lineTo(center - 30, 95)
      ..close();
    canvas.drawPath(leftVast, backPaint);
    canvas.drawPath(leftVast, outlinePaint);

    Path rightVast = Path()
      ..moveTo(center + 40, 95)
      ..lineTo(center + 50, 115)
      ..lineTo(center + 35, 145)
      ..lineTo(center + 30, 95)
      ..close();
    canvas.drawPath(rightVast, backPaint);
    canvas.drawPath(rightVast, outlinePaint);

    // --- 4. PECTORAUX ---
    final Paint chestPaint = getMusclePaint('chest');
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 40, 54, 39, 35), const Radius.circular(6)), chestPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 40, 54, 39, 35), const Radius.circular(6)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 1, 54, 39, 35), const Radius.circular(6)), chestPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 1, 54, 39, 35), const Radius.circular(6)), outlinePaint);

    // --- 5. ABDOMINAUX ---
    final Paint absPaint = getMusclePaint('abs');
    for (int row = 0; row < 3; row++) {
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 25, 96 + (row * 16), 23, 12), const Radius.circular(3)), absPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 25, 96 + (row * 16), 23, 12), const Radius.circular(3)), outlinePaint);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 2, 96 + (row * 16), 23, 12), const Radius.circular(3)), absPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 2, 96 + (row * 16), 23, 12), const Radius.circular(3)), outlinePaint);
    }

    // --- 6. BRAS ---
    final Paint armsPaint = getMusclePaint('arms');
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 63, 75, 18, 45), const Radius.circular(6)), armsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 63, 75, 18, 45), const Radius.circular(6)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 61, 122, 15, 45), const Radius.circular(4)), armsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 61, 122, 15, 45), const Radius.circular(4)), outlinePaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 45, 75, 18, 45), const Radius.circular(6)), armsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 45, 75, 18, 45), const Radius.circular(6)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 46, 122, 15, 45), const Radius.circular(4)), armsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 46, 122, 15, 45), const Radius.circular(4)), outlinePaint);

    // --- 7. JAMBES ---
    final Paint legsPaint = getMusclePaint('legs');
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 32, 180, 28, 90), const Radius.circular(10)), legsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 32, 180, 28, 90), const Radius.circular(10)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 4, 180, 28, 90), const Radius.circular(10)), legsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 4, 180, 28, 90), const Radius.circular(10)), outlinePaint);

    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 29, 276, 22, 80), const Radius.circular(8)), legsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center - 29, 276, 22, 80), const Radius.circular(8)), outlinePaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 7, 276, 22, 80), const Radius.circular(8)), legsPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(center + 7, 276, 22, 80), const Radius.circular(8)), outlinePaint);
  }

  @override
  bool shouldRepaint(covariant HumanBodyPainter oldDelegate) {
    return oldDelegate.selectedMuscleId != selectedMuscleId;
  }
}