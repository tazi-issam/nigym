import 'package:flutter/material.dart';

class MonthlyComparisonScreen extends StatelessWidget {
  final String currentLanguage;
  const MonthlyComparisonScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Données simulées dynamiques
    final List<Map<String, dynamic>> comparisonData = [
      {'metric': 'Poids Corporel', 'lastMonth': '82.5 kg', 'thisMonth': '80.1 kg', 'status': 'down'},
      {'metric': 'Tour de Bras', 'lastMonth': '38.5 cm', 'thisMonth': '39.2 cm', 'status': 'up'},
      {'metric': 'Tour de Taille', 'lastMonth': '88.0 cm', 'thisMonth': '85.5 cm', 'status': 'down'},
      {'metric': 'Force Max (Développé Couché)', 'lastMonth': '90 kg', 'thisMonth': '95 kg', 'status': 'up'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(currentLanguage == 'AR' ? 'مقارنة شهرية' : 'Evolution Mensuelle'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: comparisonData.length,
        itemBuilder: (context, index) {
          final data = comparisonData[index];
          bool isUp = data['status'] == 'up';

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[900]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['metric'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mois dernier', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(data['lastMonth'], style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      ],
                    ),
                    Icon(Icons.arrow_forward_rounded, color: Colors.grey[700]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Ce mois-ci', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          data['thisMonth'], 
                          style: TextStyle(
                            color: isUp ? const Color(0xFFC0F235) : Colors.cyanAccent, 
                            fontSize: 18, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}