import 'package:flutter/material.dart';

class BodyMetricsScreen extends StatefulWidget {
  final String currentLanguage;
  const BodyMetricsScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<BodyMetricsScreen> createState() => _BodyMetricsScreenState();
}

class _BodyMetricsScreenState extends State<BodyMetricsScreen> {
  double _weight = 78.5;
  double _muscleMass = 34.2;
  double _bodyFat = 14.5;

  void _updateMetric(String type, double value) {
    setState(() {
      if (type == 'weight') _weight = double.parse(value.toStringAsFixed(1));
      if (type == 'muscle') _muscleMass = double.parse(value.toStringAsFixed(1));
      if (type == 'fat') _bodyFat = double.parse(value.toStringAsFixed(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(widget.currentLanguage == 'AR' ? 'تركيبة الجسم' : 'Composition Corporelle'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSliderCard(title: 'Poids Global (kg)', value: _weight, min: 40, max: 150, type: 'weight', color: const Color(0xFFC0F235)),
            _buildSliderCard(title: 'Masse Musculaire (kg)', value: _muscleMass, min: 20, max: 80, type: 'muscle', color: Colors.white),
            _buildSliderCard(title: 'Taux de Graisse (%)', value: _bodyFat, min: 3, max: 50, type: 'fat', color: Colors.redAccent),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: const Color(0xFFC0F235)),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Ajuste les curseurs pour mettre à jour tes mesures du jour instantanément.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSliderCard({required String title, required double value, required double min, required double max, required String type, required Color color}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              Text(value.toString(), style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            activeColor: const Color(0xFFC0F235),
            inactiveColor: Colors.grey[800],
            onChanged: (val) => _updateMetric(type, val),
          ),
        ],
      ),
    );
  }
}