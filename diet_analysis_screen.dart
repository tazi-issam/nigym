import 'package:flutter/material.dart';

class DietAnalysisScreen extends StatefulWidget {
  final String currentLanguage;
  const DietAnalysisScreen({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<DietAnalysisScreen> createState() => _DietAnalysisScreenState();
}

class _DietAnalysisScreenState extends State<DietAnalysisScreen> {
  final List<Map<String, dynamic>> _meals = [
    {'name': 'Omelette & Pain', 'calories': 450, 'protein': 30},
    {'name': 'Poulet & Riz', 'calories': 650, 'protein': 45},
  ];

  final int _calorieGoal = 2000;
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();

  int get totalCalories => _meals.fold(0, (sum, item) => sum + (item['calories'] as int));
  int get totalProtein => _meals.fold(0, (sum, item) => sum + (item['protein'] as int));

  void _addMeal() {
    if (_nameController.text.isEmpty || _caloriesController.text.isEmpty || _proteinController.text.isEmpty) return;
    
    setState(() {
      _meals.add({
        'name': _nameController.text,
        'calories': int.parse(_caloriesController.text),
        'protein': int.parse(_proteinController.text),
      });
    });

    _nameController.clear();
    _caloriesController.clear();
    _proteinController.clear();
    Navigator.pop(context);
  }

  void _showAddMealDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(widget.currentLanguage == 'AR' ? 'إضافة وجبة' : 'Ajouter un repas', style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: widget.currentLanguage == 'AR' ? 'اسم الوجبة' : 'Nom du repas', labelStyle: const TextStyle(color: Colors.white54))),
            TextField(controller: _caloriesController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Calories (kcal)', labelStyle: const TextStyle(color: Colors.white54))),
            TextField(controller: _proteinController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Protéines (g)', labelStyle: const TextStyle(color: Colors.white54))),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFC0F235)),
            onPressed: _addMeal,
            child: const Text('Ajouter', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = totalCalories / _calorieGoal;
    if (progress > 1.0) progress = 1.0;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(widget.currentLanguage == 'AR' ? 'تحليل التغذية' : 'Analyse Alimentaire'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Jauge de Calories
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$totalCalories / $_calorieGoal kcal', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFC0F235))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[800],
                    color: const Color(0xFFC0F235),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.bolt, color: const Color(0xFFC0F235), size: 18),
                      const SizedBox(width: 4),
                      Text('Protéines totales : ${totalProtein}g', style: const TextStyle(color: Colors.white70)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(widget.currentLanguage == 'AR' ? 'وجبات اليوم' : 'Repas du jour', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _meals.length,
                itemBuilder: (context, index) {
                  final meal = _meals[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(meal['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text('${meal['protein']}g Protéines', style: TextStyle(color: Colors.grey[400])),
                      trailing: Text('${meal['calories']} kcal', style: const TextStyle(color: Color(0xFFC0F235), fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFC0F235),
        onPressed: _showAddMealDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}