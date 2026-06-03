import 'package:flutter/material.dart';
import 'diet_analysis_screen.dart';
import 'monthly_comparison_screen.dart';
import 'body_metrics_screen.dart';

class NutritionTrackingScreen extends StatefulWidget {
  final String currentLanguage;
  const NutritionTrackingScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<NutritionTrackingScreen> createState() => _NutritionTrackingScreenState();
}

class _NutritionTrackingScreenState extends State<NutritionTrackingScreen> {
  final Map<String, Map<String, String>> _localizedTexts = {
    'FR': {
      'pageTitle': 'Suivi & Nutrition',
      'nutritionTitle': 'Analyse de l’alimentation',
      'nutritionSub': 'Analyse de l’alimentation et recommandations personnalisées.',
      'comparisonTitle': 'Comparaison mensuelle',
      'comparisonSub': 'Comparaison mensuelle de l’évolution physique.',
      'metricsTitle': 'Composition corporelle',
      'metricsSub': 'Suivi du poids, de la masse musculaire et du taux de graisse.',
    },
    'EN': {
      'pageTitle': 'Tracking & Nutrition',
      'nutritionTitle': 'Diet Analysis',
      'nutritionSub': 'Diet analysis and personalized recommendations.',
      'comparisonTitle': 'Monthly Comparison',
      'comparisonSub': 'Monthly comparison of physical evolution.',
      'metricsTitle': 'Body Composition',
      'metricsSub': 'Track weight, muscle mass, and body fat.',
    },
    'AR': {
      'pageTitle': 'التغذية والمتابعة',
      'nutritionTitle': 'تحليل التغذية',
      'nutritionSub': 'تحليل النظام الغذائي وتوصيات مخصصة.',
      'comparisonTitle': 'مقارنة شهرية',
      'comparisonSub': 'مقارنة شهرية للتطور البدني.',
      'metricsTitle': 'تركيبة الجسم',
      'metricsSub': 'متابعة الوزن، الكتلة العضلية ونسبة الدهون.',
    }
  };

  @override
  Widget build(BuildContext context) {
    final texts = _localizedTexts[widget.currentLanguage] ?? _localizedTexts['FR']!;
    final isRtl = widget.currentLanguage == 'AR';

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Directionality(
          textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              // 1. DIRECTION DE L'ANALYSE ALIMENTAIRE
              _buildMenuCard(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DietAnalysisScreen(currentLanguage: widget.currentLanguage))),
                icon: Icons.restaurant_rounded,
                title: texts['nutritionTitle']!,
                subtitle: texts['nutritionSub']!,
                isRtl: isRtl,
              ),
              // 2. DIRECTION COMPARAISON
              _buildMenuCard(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MonthlyComparisonScreen(currentLanguage: widget.currentLanguage))),
                icon: Icons.compare_rounded,
                title: texts['comparisonTitle']!,
                subtitle: texts['comparisonSub']!,
                isRtl: isRtl,
              ),
              // 3. DIRECTION COMPOSITION CORPORELLE
              _buildMenuCard(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BodyMetricsScreen(currentLanguage: widget.currentLanguage))),
                icon: Icons.monitor_weight_rounded,
                title: texts['metricsTitle']!,
                subtitle: texts['metricsSub']!,
                isRtl: isRtl,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard({required VoidCallback onTap, required IconData icon, required String title, required String subtitle, required bool isRtl}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[900]!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF262626), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: const Color(0xFFC0F235), size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12, height: 1.3)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(isRtl ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 14),
          ],
        ),
      ),
    );
  }
}