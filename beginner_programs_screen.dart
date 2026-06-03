import 'package:flutter/material.dart';

class BeginnerProgramsScreen extends StatefulWidget {
  final String currentLanguage;
  const BeginnerProgramsScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<BeginnerProgramsScreen> createState() => _BeginnerProgramsScreenState();
}

class _BeginnerProgramsScreenState extends State<BeginnerProgramsScreen> {
  // Traductions de l'interface
 final Map<String, Map<String, String>> _localizedTexts = {
    'FR': {
      'title': 'Espace Débutant', // <-- Fusée retirée ici
      'subtitle': 'Programmes guidés et vidéos d\'exécution pour bien commencer.',
      'duration': 'Durée :',
      'weeks': '4 sem.',
      'frequency': 'Fréquence :',
      'daysPerWeek': '3 j/sem.',
      'startBtn': 'Commencer le programme',
      'videoHint': 'Regarder la vidéo de démonstration',
    },
    'EN': {
      'title': 'Beginner Zone', // <-- Fusée retirée ici
      'subtitle': 'Guided programs and execution videos to start right.',
      'duration': 'Duration:',
      'weeks': '4 wks',
      'frequency': 'Frequency:',
      'daysPerWeek': '3 days/wk',
      'startBtn': 'Start Program',
      'videoHint': 'Watch execution video',
    },
    'AR': {
      'title': 'مساحة المبتدئين', // <-- Fusée retirée ici
      'subtitle': 'برامج موجهة وفيديوهات تعليمية للبدء بشكل صحيح.',
      'duration': 'المدة:',
      'weeks': '4 أسابيع',
      'frequency': 'التردد:',
      'daysPerWeek': '3 أيام / أسبوع',
      'startBtn': 'ابدأ البرنامج',
      'videoHint': 'مشاهدة فيديو الشرح',
    }
  };
  // Liste des programmes
  final List<Map<String, dynamic>> _programs = [
    {
      'titleFR': '1. Full-Body Fondations',
      'titleEN': '1. Full-Body Foundations',
      'titleAR': '1. أساسيات الجسم كامل',
      'descFR': 'Idéal pour réveiller les muscles et apprendre les mouvements de base de la musculation.',
      'descEN': 'Ideal to wake up muscles and learn core strength movements.',
      'descAR': 'مثالي لتنشيط العضلات وتعلم الحركات الأساسية لبناء الأجسام.',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Squat au poids du corps',
          'nameEN': 'Bodyweight Squat',
          'nameAR': 'قرفصاء بوزن الجسم',
          'sets': '3x12',
          'videoUrl': 'https://www.exemple.com/videos/squat.mp4',
        },
        {
          'nameFR': 'Pompes sur les genoux',
          'nameEN': 'Knee Push-ups',
          'nameAR': 'تمرين الضغط على الركبتين',
          'sets': '3x10',
          'videoUrl': '',
        },
        {
          'nameFR': 'Tirage Buste Penché (Rowing)',
          'nameEN': 'Dumbbell Row',
          'nameAR': 'تجديف بالدمبل',
          'sets': '3x12',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '2. Circuit Cardio & Renfo',
      'titleEN': '2. Cardio & Strength Circuit',
      'titleAR': '2. دائرة الكارديو والتقوية',
      'descFR': 'Brûler des calories tout en renforçant le centre du corps (sangle abdominale).',
      'descEN': 'Burn calories while strengthening your core.',
      'descAR': 'حرق السعرات الحرارية مع تقوية عضلات الجذع والبطن.',
      'image': 'https://images.unsplash.com/photo-1603287681836-b174ce5074c2?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Gainage Planche',
          'nameEN': 'Plank Hold',
          'nameAR': 'تمرين اللوح (البلانك)',
          'sets': '3x30 sec',
          'videoUrl': '',
        },
        {
          'nameFR': 'Jumping Jacks',
          'nameEN': 'Jumping Jacks',
          'nameAR': 'قفز جاك',
          'sets': '3x45 sec',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '3. Focus Haut du Corps (Upper Body)',
      'titleEN': '3. Upper Body Focus',
      'titleAR': '3. تركيز الجزء العلوي',
      'descFR': 'Développer la force des bras, des épaules et des pectoraux sans surcharger.',
      'descEN': 'Build arm, shoulder, and chest strength without overload.',
      'descAR': 'بناء قوة الذراعين، الأكتاف، والصدر بدون إجهاد زائد.',
      'image': 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Développé Couché Haltères',
          'nameEN': 'Dumbbell Bench Press',
          'nameAR': 'ضغط الصدر بالدمبل',
          'sets': '3x10',
          'videoUrl': '',
        },
        {
          'nameFR': 'Curl Biceps aux Haltères',
          'nameEN': 'Dumbbell Biceps Curl',
          'nameAR': 'تبادل بايسبس بالدمبل',
          'sets': '3x12',
          'videoUrl': '',
        },
        {
          'nameFR': 'Développé Militaire (Épaules)',
          'nameEN': 'Dumbbell Shoulder Press',
          'nameAR': 'ضغط الأكتاف بالدمبل',
          'sets': '3x10',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '4. Spécial Bas du Corps (Lower Body)',
      'titleEN': '4. Lower Body Blast',
      'titleAR': '4. تفجير الجزء السفلي',
      'descFR': 'Tonifier les cuisses, les fessiers et renforcer les genoux en toute sécurité.',
      'descEN': 'Tone thighs, glutes, and safely strengthen your knees.',
      'descAR': 'شد الفخذين، المؤخرة، وتقوية الركبتين بأمان تام.',
      'image': 'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Fentes Avant au poids du corps',
          'nameEN': 'Bodyweight Lunges',
          'nameAR': 'تمرين الطعن الأمامي',
          'sets': '3x10 / jambe',
          'videoUrl': '',
        },
        {
          'nameFR': 'Glute Bridges (Pont Fessier)',
          'nameEN': 'Glute Bridge',
          'nameAR': 'تمرين الجسر للمؤخرة',
          'sets': '3x15',
          'videoUrl': '',
        },
        {
          'nameFR': 'Extensions Mollets Debout',
          'nameEN': 'Standing Calf Raises',
          'nameAR': 'رفع الساقين للمطاط (السمانة)',
          'sets': '3x15',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '5. Abdos & Core Sculpt',
      'titleEN': '5. Core & Abs Sculpt',
      'titleAR': '5. نحت البطن والجذع',
      'descFR': 'Un programme court mais intense pour cibler le grand droit et les obliques.',
      'descEN': 'A short but intense program targeting your six-pack and obliques.',
      'descAR': 'برنامج قصير مكثف لاستهداف عضلات البطن العلوية والجانبية.',
      'image': 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Crunch Abdominal Basique',
          'nameEN': 'Basic Crunch',
          'nameAR': 'تمرين المعدة الكلاسيكي',
          'sets': '3x15',
          'videoUrl': '',
        },
        {
          'nameFR': 'Russian Twists (Torsions)',
          'nameEN': 'Russian Twists',
          'nameAR': 'التواء روسي للجانبين',
          'sets': '3x20',
          'videoUrl': '',
        },
        {
          'nameFR': 'Planche Latérale (Côté)',
          'nameEN': 'Side Plank',
          'nameAR': 'البلانك الجانبي',
          'sets': '3x20 sec / côté',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '6. Initiation Haltères (Dumbbell Only)',
      'titleEN': '6. Dumbbell Only Start',
      'titleAR': '6. البداية بالدمبل فقط',
      'descFR': 'Parfait si tu t\'entraînes à la maison avec seulement une paire d\'haltères.',
      'descEN': 'Perfect if you train at home with just a pair of dumbbells.',
      'descAR': 'ممتاز إذا كنت تتمرن في المنزل باستخدام زوج من الدمبل فقط.',
      'image': 'https://images.unsplash.com/photo-1638536532686-d610adfc8e5c?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Goblet Squat (Haltère au torse)',
          'nameEN': 'Goblet Squat',
          'nameAR': 'قرفصاء غوبلت بالدمبل',
          'sets': '3x10',
          'videoUrl': '',
        },
        {
          'nameFR': 'Extension Triceps derrière la tête',
          'nameEN': 'Overhead Triceps Extension',
          'nameAR': 'ترايسبس خلف الرأس بالدمبل',
          'sets': '3x12',
          'videoUrl': '',
        },
      ]
    },
    {
      'titleFR': '7. Posture & Renforcement Dos',
      'titleEN': '7. Back & Posture Care',
      'titleAR': '7. العناية بالظهر والقوام',
      'descFR': 'Corriger la posture assise, éliminer les douleurs et renforcer les lombaires.',
      'descEN': 'Fix sitting posture, eliminate pain, and strengthen lower back.',
      'descAR': 'تعديل وضعية الجلوس، التخلص من الآلام وتقوية أسفل الظهر.',
      'image': 'https://images.unsplash.com/photo-1600881333168-2ef49b341f30?q=80&w=600',
      'isFavorite': false,
      'exercises': [
        {
          'nameFR': 'Extensions Lombaires (Superman)',
          'nameEN': 'Superman Hold',
          'nameAR': 'تمرين سوبرمان لأسفل الظهر',
          'sets': '3x12',
          'videoUrl': '',
        },
        {
          'nameFR': 'Bird-Dog',
          'nameEN': 'Bird-Dog Exercise',
          'nameAR': 'تمرين الطائر الكلب للتوازن',
          'sets': '3x10 / côté',
          'videoUrl': '',
        },
      ]
    }
  ];

  // Gestion de l'état des favoris
  void _toggleFavorite(int index) {
    setState(() {
      _programs[index]['isFavorite'] = !_programs[index]['isFavorite'];
    });

    final isFav = _programs[index]['isFavorite'];
    final snackBar = SnackBar(
      content: Text(isFav ? 'Ajouté aux favoris' : 'Retiré des favoris'),
      duration: const Duration(seconds: 1),
      backgroundColor: const Color(0xFF1E1E1E),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final texts = _localizedTexts[widget.currentLanguage] ?? _localizedTexts['EN']!;
    final isRtl = widget.currentLanguage == 'AR';

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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: _programs.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0, left: 4, right: 4),
                  child: Text(
                    texts['subtitle']!,
                    style: TextStyle(fontSize: 14, color: Colors.grey[400], fontStyle: FontStyle.italic),
                  ),
                );
              }

              final programIndex = index - 1;
              final program = _programs[programIndex];
              final title = widget.currentLanguage == 'FR'
                  ? program['titleFR']
                  : widget.currentLanguage == 'AR'
                      ? program['titleAR']
                      : program['titleEN'];
              final desc = widget.currentLanguage == 'FR'
                  ? program['descFR']
                  : widget.currentLanguage == 'AR'
                      ? program['descAR']
                      : program['descEN'];
              final bool isFavorite = program['isFavorite'] ?? false;

              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[900]!, width: 1),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(program['image']), fit: BoxFit.cover),
                      ),
                      child: Container(
                        color: Colors.black.withOpacity(0.55),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _toggleFavorite(programIndex),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF121212).withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  color: isFavorite ? Colors.redAccent : Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            desc,
                            style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.3),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _buildInfoChip(Icons.calendar_today_rounded, texts['duration']!, texts['weeks']!),
                              _buildInfoChip(Icons.repeat_rounded, texts['frequency']!, texts['daysPerWeek']!),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Color(0xFF2D2D2D), height: 1),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: program['exercises'].length,
                            itemBuilder: (context, exIndex) {
                              final ex = program['exercises'][exIndex];
                              final exName = widget.currentLanguage == 'FR'
                                  ? ex['nameFR']
                                  : widget.currentLanguage == 'AR'
                                      ? ex['nameAR']
                                      : ex['nameEN'];

                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _showVideoModal(context, exName, ex['videoUrl']),
                                      child: const Icon(Icons.play_circle_fill_rounded, color: Color(0xFFC0F235), size: 30),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            exName,
                                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            ex['sets'],
                                            style: const TextStyle(color: Color(0xFFC0F235), fontSize: 11, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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

  Widget _buildInfoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFC0F235)),
          const SizedBox(width: 4),
          Text(
            "$label $value",
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showVideoModal(BuildContext context, String exerciseName, String videoUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    exerciseName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC0F235).withOpacity(0.3), width: 1),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.fitness_center_rounded, size: 48, color: Colors.grey[800]),
                        Positioned(
                          bottom: 12,
                          child: Text(
                            videoUrl.isNotEmpty 
                                ? (widget.currentLanguage == 'AR' ? "تشغيل الفيديو المتاح" : "Vidéo prête à charger")
                                : (widget.currentLanguage == 'AR' ? "لا يوجد فيديو حاليا" : "Aucune vidéo configurée"),
                            style: TextStyle(
                              color: videoUrl.isNotEmpty ? const Color(0xFFC0F235) : Colors.grey, 
                              fontWeight: FontWeight.bold, 
                              fontSize: 13
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D2D2D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(widget.currentLanguage == 'AR' ? "إغلاق" : "Fermer"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}