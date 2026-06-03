import 'dart:async';
import 'dart:math'; // Importé pour utiliser Random()
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  final String currentLanguage;
  const SettingsView({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Données de profil locales par défaut
  String _username = "issam";
  String _selectedAvatar = "⚡";

  // Liste des avatars disponibles classés par catégorie
  final List<Map<String, dynamic>> _avatars = [
    {'emoji': '💪', 'category': 'Hommes'},
    {'emoji': '🥷', 'category': 'Hommes'},
    {'emoji': '🏋️‍♂️', 'category': 'Hommes'},
    {'emoji': '🧔', 'category': 'Hommes'},
    {'emoji': '✨', 'category': 'Femmes'},
    {'emoji': '🤸‍♀️', 'category': 'Femmes'},
    {'emoji': '🏋️‍♀️', 'category': 'Femmes'},
    {'emoji': '👩‍', 'category': 'Femmes'},
    {'emoji': '⚡', 'category': 'Créatures'},
    {'emoji': '🔥', 'category': 'Créatures'},
    {'emoji': '🤖', 'category': 'Créatures'},
    {'emoji': '🦁', 'category': 'Créatures'},
  ];

  // --- 1. PRIVACY POLICY ---
  void _showPrivacyPolicyDialog() {
    final isAr = widget.currentLanguage == 'AR';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          isAr ? 'سياسة الخصوصية' : 'Privacy Policy',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Text(
              isAr 
                  ? 'نحن نحترم خصوصيتك. تطبيق ni_gym لا يجمع أو يشارك بياناتك الشخصية مع أي طرف ثالث. جميع بيانات تمارينك يتم حفظها محلياً على جهازك فقط.'
                  : 'Chez ni_gym, nous respectons votre vie privée. L\'application ne collecte, ne stocke ni ne partage vos données personnelles avec des tiers. Toutes vos données d\'entraînement restent localement sur votre appareil.',
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isAr ? 'إغلاق' : 'Fermer', style: const TextStyle(color: Color(0xFFC0F235))),
          ),
        ],
      ),
    );
  }

  // --- 2. RATE US ---
  void _showRateUsDialog() {
    int selectedStars = 5;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          final isAr = widget.currentLanguage == 'AR';
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text(
              isAr ? 'تقييم التطبيق' : 'Rate ni_gym',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isAr ? 'هل يعجبك التطبيق؟ يرجى إعطائنا تقييمك!' : 'Tu aimes l\'application ? Laisse-nous une note !',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    int starValue = index + 1;
                    bool isLit = starValue <= selectedStars;
                    return GestureDetector(
                      onTap: () => setDialogState(() => selectedStars = starValue),
                      child: Icon(
                        isLit ? Icons.star_rounded : Icons.star_border_rounded,
                        color: isLit ? const Color(0xFFC0F235) : Colors.white24,
                        size: 42,
                      ),
                    );
                  }),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(isAr ? 'إلغاء' : 'Plus tard', style: const TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0F235),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar(isAr ? 'شكرا لك على تقييمك! ❤️' : 'Merci pour tes $selectedStars étoiles ! 🔥');
                },
                child: Text(isAr ? 'إرسال' : 'Voter', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- 3. FEEDBACK ---
  void _showFeedbackDialog() {
    final _feedbackController = TextEditingController();
    final isAr = widget.currentLanguage == 'AR';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          isAr ? 'آراء وملاحظات' : 'Feedback & Suggestions',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isAr ? 'اكتب رأيك أو اقتراحاتك لتحسين التطبيق:' : 'Écris ton avis ou tes idées d\'amélioration :',
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: isAr ? 'أدخل رسالتك هنا...' : 'Ton message ici...',
                hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
                fillColor: const Color(0xFF262626),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFC0F235), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isAr ? 'إلغاء' : 'Annuler', style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC0F235),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              if (_feedbackController.text.trim().isNotEmpty) {
                Navigator.pop(context);
                _showSnackBar(isAr ? 'تم إرسال ملاحظتك بنجاح! شكراً لك.' : 'Feedback envoyé avec succès ! Merci. 💪');
              }
            },
            child: Text(isAr ? 'إرسال' : 'Envoyer', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // --- 4. OUVERTURE DU SCANNEUR QR CODE ---
  void _openQrScanner() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrScannerScreen(currentLanguage: widget.currentLanguage),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF1E222A),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          message,
          style: const TextStyle(color: Color(0xFFC0F235), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Boîte de dialogue pour modifier le profil
  void _showEditProfileDialog() {
    final _nameController = TextEditingController(text: _username);
    String tempAvatar = _selectedAvatar;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            title: Text(
              widget.currentLanguage == 'AR' ? 'تعديل الحساب' : 'Modifier le Profil',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: widget.currentLanguage == 'AR' ? 'اسم المستخدم' : 'Nom d\'utilisateur',
                        labelStyle: const TextStyle(color: Colors.white54),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC0F235))),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.currentLanguage == 'AR' ? 'اختر الأفاتار' : 'Choisir un Avatar',
                      style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: _avatars.length,
                      itemBuilder: (context, index) {
                        final avatar = _avatars[index];
                        bool isSelected = tempAvatar == avatar['emoji'];
                        return GestureDetector(
                          onTap: () => setDialogState(() => tempAvatar = avatar['emoji']),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFC0F235) : const Color(0xFF262626),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: isSelected ? Colors.white : Colors.transparent, width: 2),
                            ),
                            alignment: Alignment.center,
                            child: Text(avatar['emoji'], style: const TextStyle(fontSize: 26)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler', style: TextStyle(color: Colors.grey)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0F235),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_nameController.text.trim().isNotEmpty) {
                    setState(() {
                      _username = _nameController.text.trim();
                      _selectedAvatar = tempAvatar;
                    });
                  }
                  Navigator.pop(context);
                },
                child: const Text('Sauvegarder', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = widget.currentLanguage == 'AR';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                        child: const Icon(Icons.settings, color: Colors.black, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.currentLanguage == 'AR' ? 'الإعدادات' : 'Setting',
                            style: const TextStyle(color: Color(0xFFC0F235), fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '“Train Wise. Move Right.”',
                            style: TextStyle(color: Colors.white70, fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),

                  GestureDetector(
                    onTap: _showEditProfileDialog,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E222A),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFC0F235).withOpacity(0.3), width: 1),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xFF262626),
                            child: Text(_selectedAvatar, style: const TextStyle(fontSize: 32)),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_username, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(
                                  widget.currentLanguage == 'AR' ? 'تعديل الحساب ✎' : 'Modifier le compte ✎',
                                  style: const TextStyle(color: Color(0xFFC0F235), fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  _buildSettingCard(
                    icon: Icons.shield_outlined,
                    title: widget.currentLanguage == 'AR' ? 'سياسة الخصوصية' : 'Privacy Policy',
                    onTap: _showPrivacyPolicyDialog,
                  ),
                  _buildSettingCard(
                    icon: Icons.star_border_rounded,
                    title: widget.currentLanguage == 'AR' ? 'تقييم التطبيق' : 'Rate Us',
                    onTap: _showRateUsDialog, 
                  ),
                  _buildSettingCard(
                    icon: Icons.share_outlined,
                    title: widget.currentLanguage == 'AR' ? 'مشاركة' : 'share',
                    onTap: () {
                      _showSnackBar(widget.currentLanguage == 'AR' ? 'ميزة المشاركة ستكون متاحة قريباً!' : 'Le partage sera dispo bientôt !');
                    },
                  ),
                  _buildSettingCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    title: widget.currentLanguage == 'AR' ? 'آراء وملاحظات' : 'Feedback',
                    onTap: _showFeedbackDialog,
                  ),
                  
                  const SizedBox(height: 80),
                ],
              ),

              // --- MINI ICÔNE QR CODE EN BAS À DROITE ---
              Positioned(
                bottom: 20,
                right: isRtl ? null : 20,
                left: isRtl ? 20 : null,
                child: GestureDetector(
                  onTap: _openQrScanner,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E222A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC0F235).withOpacity(0.5), width: 1),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 4))
                      ],
                    ),
                    child: const Icon(
                      Icons.qr_code_2_rounded,
                      color: Color(0xFFC0F235),
                      size: 26,
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

  Widget _buildSettingCard({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E222A),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// --- ÉCRAN : SCANNEUR QR CODE AVEC SÉLECTION ALÉATOIRE DE 3 MACHINES ---
// =========================================================================
class QrScannerScreen extends StatefulWidget {
  final String currentLanguage;
  const QrScannerScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _scanTimer;

  // Structure globale pour modéliser une machine de gym
  late Map<String, dynamic> _selectedMachine;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Initialisation des données des 3 machines distinctes (Français & Arabe pris en charge)
    final List<Map<String, dynamic>> machinesDatabase = [
      {
        'title_fr': 'Machine Développé Couché',
        'title_ar': 'آلة ضغط الصدر (Bench Press)',
        'muscles_fr': 'Muscles ciblés : Pectoraux, Épaules, Triceps',
        'muscles_ar': 'العضلات المستهدفة: الصدر، الأكتاف، الترايسيبس',
        'exercises': [
          {'title_fr': 'Bench Press Classique', 'title_ar': 'ضغط الصcer مستوي', 'desc_fr': 'Cible le milieu de la poitrine.', 'desc_ar': 'بناء الكتلة العامة للصدر', 'icon': '🏋️‍♂️'},
          {'title_fr': 'Close-Grip Bench', 'title_ar': 'قبضة ضيقة', 'desc_fr': 'Accentue le travail sur les triceps.', 'desc_ar': 'تركيز أكبر على الترايسيبس', 'icon': '💪'},
          {'title_fr': 'Explosive Bench', 'title_ar': 'الضغط المتفجر', 'desc_fr': 'Développe la puissance brute.', 'desc_ar': 'تحسين القوة الانفجارية', 'icon': '🔥'}
        ]
      },
      {
        'title_fr': 'Machine Tirage Vertical',
        'title_ar': 'آلة السحب العلوى (Lat Pulldown)',
        'muscles_fr': 'Muscles ciblés : Grand Dorsal, Trapèzes, Biceps',
        'muscles_ar': 'العضلات المستهدفة: الظهر العريض، الأكتاف خلفية، البايسبس',
        'exercises': [
          {'title_fr': 'Tirage Poitrine Large', 'title_ar': 'سحب أمامي واسع', 'desc_fr': 'Développe la largeur du dos.', 'desc_ar': 'زيادة عرض وعمق عضلات الظهر', 'icon': '🦅'},
          {'title_fr': 'Tirage Prise Serrée', 'title_ar': 'سحب ضيق مقلوب', 'desc_fr': 'Focus sur les biceps et le bas des dorsaux.', 'desc_ar': 'تركيز على أسفل الظهر والبايسبس', 'icon': '💪'},
          {'title_fr': 'Tirage Nuque', 'title_ar': 'سحب خلف الرقبة', 'desc_fr': 'Variante pour isoler les trapèzes.', 'desc_ar': 'عزل عضلة الظهر العلوية', 'icon': '⚡'}
        ]
      },
      {
        'title_fr': 'Machine Presse à Cuisses',
        'title_ar': 'آلة ضغط الأرجل (Leg Press)',
        'muscles_fr': 'Muscles ciblés : Quadriceps, Fessiers, Ischios',
        'muscles_ar': 'العضلات المستهدفة: الفخذ الأمامي، الفخذ الخلفي، المؤخرة',
        'exercises': [
          {'title_fr': 'Leg Press Standard', 'title_ar': 'ضغط أرجل كلاسيكي', 'desc_fr': 'Développement global des cuisses.', 'desc_ar': 'بناء شامل وقوي لعضلات الأرجل', 'icon': '🦵'},
          {'title_fr': 'Placement Pieds Hauts', 'title_ar': 'وضع الأقدام في الأعلى', 'desc_fr': 'Focus intense sur les fessiers/ischios.', 'desc_ar': 'تركيز أكبر على المؤخرة والفخذ الخلفي', 'icon': '🍑'},
          {'title_fr': 'Placement Pieds Serrés', 'title_ar': 'وضع الأقدام ضيق', 'desc_fr': 'Accentue le vaste externe du quadriceps.', 'desc_ar': 'تركيز على العضلة الخارجية للفخذ', 'icon': '🔥'}
        ]
      }
    ];

    // SÉLECTION ALÉATOIRE par index (0, 1 ou 2)
    final random = Random();
    _selectedMachine = machinesDatabase[random.nextInt(machinesDatabase.length)];

    // Déclenchement automatique de la détection après 2 secondes
    _scanTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _showMachineDetailsBottomSheet();
      }
    });
  }

  // --- MODAL DE PRÉSENTATION DE LA MACHINE ---
  void _showMachineDetailsBottomSheet() {
    final isAr = widget.currentLanguage == 'AR';

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        final List<dynamic> exercises = _selectedMachine['exercises'];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barre esthétique supérieure
              Center(
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),

              // Badge de détection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC0F235).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isAr ? 'تم رصد آلة الرياضة' : 'MACHINE DÉTECTÉE ⚡',
                      style: const TextStyle(color: Color(0xFFC0F235), fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Icon(Icons.fitness_center_rounded, color: Colors.white70, size: 24),
                ],
              ),
              const SizedBox(height: 12),

              // NOM DE LA MACHINE ALÉATOIRE
              Text(
                isAr ? _selectedMachine['title_ar'] : _selectedMachine['title_fr'],
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              // MUSCLES CIBLÉS
              Text(
                isAr ? _selectedMachine['muscles_ar'] : _selectedMachine['muscles_fr'],
                style: const TextStyle(color: Colors.white54, fontSize: 13),
              ),
              
              const SizedBox(height: 24),

              // TITRE EXERCICES
              Text(
                isAr ? 'التمارين المتاحة بهذه الآلة :' : 'Exercices réalisables avec cette machine :',
                style: const TextStyle(color: Color(0xFFC0F235), fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // GALERIE HORIZONTALE DES EXERCICES DE LA MACHINE CHOSIE
              SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final ex = exercises[index];
                    return _buildExerciseCard(
                      title: isAr ? ex['title_ar'] : ex['title_fr'],
                      description: isAr ? ex['desc_ar'] : ex['desc_fr'],
                      iconLabel: ex['icon'],
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // BOUTON ACTION
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0F235),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Ferme la bottom sheet
                    Navigator.pop(context); // Quitte le scanner
                  },
                  child: Text(
                    isAr ? 'إضافة إلى حصتي اليوم' : 'Ajouter à ma séance',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExerciseCard({required String title, required String description, required String iconLabel}) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF262626),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF1E222A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(19)),
            ),
            child: Center(
              child: Text(iconLabel, style: const TextStyle(fontSize: 36)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scanTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.currentLanguage == 'AR';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isAr ? 'مسح رمز QR الآلة' : 'Scanner le QR Code d\'une machine',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Text(
              isAr ? 'وجه الكاميرا نحو الرمز الموجود على الآلة' : 'Vise le QR Code collé sur la machine de sport',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),

          // Cadre Viseur de Scan Central
          Center(
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30, width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  // Ligne Laser Animée Verte
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Positioned(
                        top: _animationController.value * 250,
                        left: 10,
                        right: 10,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC0F235),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFC0F235).withOpacity(0.8),
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Color(0xFFC0F235),
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  isAr ? 'جاري تحليل الآلة...' : 'Analyse de la machine en cours...',
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}