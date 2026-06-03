import 'package:flutter/material.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final String currentLanguage;

  const WorkoutDetailScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
    required this.currentLanguage,
  }) : super(key: key);

  // Base de données locale de tous les exercices du corps traduits
  static const Map<String, Map<String, List<Map<String, String>>>> _exercisesDatabase = {
    'chest': {
      'FR': [
        {'name': 'Développé Couché', 'desc': '3 séries x 10 réps — Exercice roi pour la masse globale des pectoraux.'},
        {'name': 'Développé Incliné Halères', 'desc': '3 séries x 12 réps — Cible le haut des pectoraux.'},
        {'name': 'Écarté à la Poulie Haute', 'desc': '4 séries x 15 réps — Idéal pour l\'isolation et la définition du milieu.'}
      ],
      'EN': [
        {'name': 'Barbell Bench Press', 'desc': '3 sets x 10 reps — Absolute king for overall chest mass.'},
        {'name': 'Incline Dumbbell Press', 'desc': '3 sets x 12 reps — Targets the upper chest fibers.'},
        {'name': 'Cable Crossover', 'desc': '4 sets x 15 reps — Prefect isolation for chest definition.'}
      ],
      'AR': [
        {'name': 'بنش بريس بالبار', 'desc': '3 جولات × 10 تكرارات — التمرين الأساسي لبناء ضخامة الصدر.'},
        {'name': 'تجميع صدر مائل بالدمبلز', 'desc': '3 جولات × 12 تكرار — يستهدف الألياف العلوية للصدر.'},
        {'name': 'تفتيح صدر عالي بالكابل', 'desc': '4 جولات × 15 تكرار — عزل ممتاز لإبراز تفاصيل العضلة.'}
      ]
    },
    'legs': {
      'FR': [
        {'name': 'Squat à la Barre', 'desc': '4 séries x 8 réps — Développe la puissance globale des quadriceps et fessiers.'},
        {'name': 'Presse à Cuisses', 'desc': '3 séries x 12 réps — Idéal pour charger lourd en toute sécurité.'},
        {'name': 'Leg Curl Ischio', 'desc': '3 séries x 15 réps — Isolation parfaite pour l\'arrière des cuisses.'}
      ],
      'EN': [
        {'name': 'Barbell Squat', 'desc': '4 sets x 8 reps — Builds supreme power in quads and glutes.'},
        {'name': 'Leg Press', 'desc': '3 sets x 12 reps — Great compound lift to load heavy safely.'},
        {'name': 'Seated Leg Curl', 'desc': '3 sets x 15 reps — Targets hamstrings directly.'}
      ],
      'AR': [
        {'name': 'سكوات بالبار', 'desc': '4 جولات × 8 تكرارات — يبني القوة الشاملة للفخذ الأمامي والمؤخرة.'},
        {'name': 'دفع الأرجل بالآلة', 'desc': '3 جولات × 12 تكرار — تمرين مركب ممتاز لزيادة الأوزان بأمان.'},
        {'name': 'لف أرجل خلفي بالآلة', 'desc': '3 جولات × 15 تكرار — يستهدف عضلات الفخذ الخلفية مباشرة.'}
      ]
    },
    'abs': {
      'FR': [
        {'name': 'Crunch à la Poulie Haute', 'desc': '4 séries x 15 réps — Permet de travailler le grand droit avec résistance.'},
        {'name': 'Levé de Jambes Suspendu', 'desc': '3 séries x 12 réps — Cible intensément le bas des abdominaux.'},
        {'name': 'Gainage Planche', 'desc': '3 séries x 1 minute — Renforce le core profond et la posture.'}
      ],
      'EN': [
        {'name': 'Cable Crunch', 'desc': '4 sets x 15 reps — Excellent way to load the rectus abdominis.'},
        {'name': 'Hanging Leg Raise', 'desc': '3 sets x 12 reps — Intensely fires up the lower ab region.'},
        {'name': 'Plank Hold', 'desc': '3 sets x 1 minute — Core isometric stabilization and posture.'}
      ],
      'AR': [
        {'name': 'طحن البطن بالكابل', 'desc': '4 جولات × 15 تكرار — طريقة ممتازة لتدريب عضلات البطن مع مقاومة.'},
        {'name': 'رفع الأرجل أثناء التعلق', 'desc': '3 جولات × 12 تكرار — يستهدف بشدة المنطقة السفلية للبطن.'},
        {'name': 'تمرين اللوح (البلانك)', 'desc': '3 جولات × دقيقة واحدة — لثبات الجذع وتحسين الاستقامة.'}
      ]
    },
    'shoulders': {
      'FR': [
        {'name': 'Développé Militaire Halères', 'desc': '3 séries x 10 réps — Masse globale sur les deltoïdes antérieurs.'},
        {'name': 'Élévations Latérales', 'desc': '4 séries x 15 réps — Donne de la largeur et l\'aspect "3D".'},
        {'name': 'Oiseau aux Haltères', 'desc': '3 séries x 12 réps — Cible l\'arrière de l\'épaule pour équilibrer la posture.'}
      ],
      'EN': [
        {'name': 'Dumbbell Shoulder Press', 'desc': '3 sets x 10 reps — Overall mass builder for front delts.'},
        {'name': 'Dumbbell Lateral Raise', 'desc': '4 sets x 15 reps — Essential for round 3D shoulders.'},
        {'name': 'Rear Delt Fly', 'desc': '3 sets x 12 reps — Hits the back of the shoulder for posture balance.'}
      ],
      'AR': [
        {'name': 'ضغط أكتاف بالدمبلز', 'desc': '3 جولات × 10 تكرارات — تمرين أساسي لكتلة الأكتاف الأمامية.'},
        {'name': 'رفرفة جانبي بالدمبلز', 'desc': '4 جولات × 15 تكرار — ضروري للحصول على أكتاف دائرية عريضة.'},
        {'name': 'رفرفة خلفي بالدمبلز', 'desc': '3 جولات × 12 تكرار — يستهدف الكتف الخلفي لتوازن الاستقامة.'}
      ]
    },
    'back': {
      'FR': [
        {'name': 'Tirage Poitrine (Lat Pulldown)', 'desc': '4 séries x 10 réps — Donne de la largeur au dos.'},
        {'name': 'Rowing Barre T', 'desc': '3 séries x 8 réps — Excellent pour l\'épaisseur globale du dos.'},
        {'name': 'Extensions Lombaires', 'desc': '3 séries x 15 réps — Renforce le bas du dos.'}
      ],
      'EN': [
        {'name': 'Lat Pulldown', 'desc': '4 sets x 10 reps — Essential for adding width to the back.'},
        {'name': 'T-Bar Row', 'desc': '3 sets x 8 reps — Supreme exercise for mid-back thickness.'},
        {'name': 'Hyperextensions', 'desc': '3 sets x 15 reps — Strengthens lower back muscles.'}
      ],
      'AR': [
        {'name': 'سحب ظهر عريض بالآلة', 'desc': '4 جولات × 10 تكرارات — تمرين أساسي لزيادة عرض الظهر.'},
        {'name': 'تجديف بالبار (T-Bar)', 'desc': '3 جولات × 8 تكرارات — تمرين قوي جداً لزيادة سمك منتصف الظهر.'},
        {'name': 'المد المفرط (فيجر)', 'desc': '3 جولات × 15 تكرار — يقوي عضلات أسفل الظهر.'}
      ]
    },
    'arms': {
      'FR': [
        {'name': 'Curl Barre EZ', 'desc': '3 séries x 12 réps — Développe la masse des biceps.'},
        {'name': 'Extension Triceps Poulie', 'desc': '4 séries x 12 réps — Cible la portion latérale des triceps.'},
        {'name': 'Curl Marteau (Hammer)', 'desc': '3 séries x 10 réps — Épaissit l\'avant-bras et le biceps.'}
      ],
      'EN': [
        {'name': 'EZ-Bar Curl', 'desc': '3 sets x 12 reps — Classic mass builder for biceps.'},
        {'name': 'Triceps Rope Pushdown', 'desc': '4 sets x 12 reps — Isolates lateral triceps head.'},
        {'name': 'Hammer Curl', 'desc': '3 sets x 10 reps — Thickens long head and brachioradialis.'},
      ],
      'AR': [
        {'name': 'تبادل بايسبس بالبار EZ', 'desc': '3 جولات × 12 تكرار — تمرين كلاسيكي لبناء كتلة البايسبس.'},
        {'name': 'ترايسبس بالكابل (حبل)', 'desc': '4 جولات × 12 تكرار — يعزل الرأس الجانبي للترايسبس.'},
        {'name': 'تبادل شاكوش (Hammer)', 'desc': '3 جولات × 10 تكرارات — يزيد من سمك الساعد وعضلة البايسبس الطويلة.'}
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    final isRtl = currentLanguage == 'AR';
    
    // Récupération sécurisée des données selon la catégorie et la langue
    final categoryData = _exercisesDatabase[categoryId] ?? {};
    final List<Map<String, String>> exercises = categoryData[currentLanguage] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(categoryName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          icon: Icon(isRtl ? Icons.arrow_forward : Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: exercises.isEmpty
              ? const Center(child: Text('No exercises found.', style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final ex = exercises[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          // Rond d'indexation vert fluo
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC0F235),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Titre + Description de l'exercice
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ex['name']!,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  ex['desc']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[400], height: 1.3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}