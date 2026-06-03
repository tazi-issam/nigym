import 'package:flutter/material.dart';

class StatsLeaderboardView extends StatefulWidget {
  final String currentLanguage;
  const StatsLeaderboardView({Key? key, required this.currentLanguage}) : super(key: key);

  @override
  State<StatsLeaderboardView> createState() => _StatsLeaderboardViewState();
}

class _StatsLeaderboardViewState extends State<StatsLeaderboardView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _friendController = TextEditingController();

  // 1. Liste du cercle proche (Amis)
  final List<Map<String, dynamic>> _friends = [
    {'name': 'issam', 'points': 2850, 'level': 'Pro', 'avatar': '⚡', 'isMe': true},
    {'name': 'miloud', 'points': 2710, 'level': 'Expert', 'avatar': '🔥', 'isMe': false},
    {'name': 'mekki', 'points': 2540, 'level': 'Expert', 'avatar': '💪', 'isMe': false},
    {'name': 'farah', 'points': 2180, 'level': 'Avancé', 'avatar': '✨', 'isMe': false},
    {'name': 'aya', 'points': 1950, 'level': 'Avancé', 'avatar': '🌟', 'isMe': false},
    {'name': 'hady', 'points': 1720, 'level': 'Intermédiaire', 'avatar': '🦾', 'isMe': false},
    {'name': 'touil', 'points': 1510, 'level': 'Intermédiaire', 'avatar': '🏃‍♂️', 'isMe': false},
    {'name': 'anais', 'points': 1340, 'level': 'Débutant', 'avatar': '🎯', 'isMe': false},
    {'name': 'zaki', 'points': 1100, 'level': 'Débutant', 'avatar': '👟', 'isMe': false},
  ];

  // 2. Base de données globale (Mondial)
  final List<Map<String, dynamic>> _globalPlayers = [
    {'name': 'Alex_Grid', 'points': 4200, 'level': 'Élite', 'avatar': '👑', 'isMe': false, 'country': '🇺🇸'},
    {'name': 'Yuki_Sama', 'points': 3950, 'level': 'Élite', 'avatar': '🥷', 'isMe': false, 'country': '🇯🇵'},
    {'name': 'Carlos_Fit', 'points': 3100, 'level': 'Pro', 'avatar': '🏆', 'isMe': false, 'country': '🇪🇸'},
    {'name': 'issam', 'points': 2850, 'level': 'Pro', 'avatar': '⚡', 'isMe': true, 'country': '🇩🇿'},
    {'name': 'miloud', 'points': 2710, 'level': 'Expert', 'avatar': '🔥', 'isMe': false, 'country': '🇩🇿'},
    {'name': 'Hassan_Lift', 'points': 2600, 'level': 'Expert', 'avatar': '🏋️', 'isMe': false, 'country': '🇲🇦'},
    {'name': 'Emma_Gym', 'points': 2420, 'level': 'Avancé', 'avatar': '🤸‍♀️', 'isMe': false, 'country': '🇫🇷'},
    {'name': 'Klaus_99', 'points': 2210, 'level': 'Avancé', 'avatar': '🐻', 'isMe': false, 'country': '🇩🇪'},
    {'name': 'Alpha_Beast', 'points': 1800, 'level': 'Intermédiaire', 'avatar': '🐺', 'isMe': false, 'country': '🇬🇧'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Met à jour l'état pour afficher/masquer le bouton selon l'onglet actif
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _friendController.dispose();
    super.dispose();
  }

  void _addFriendAction() {
    final String inputName = _friendController.text.trim();
    if (inputName.isEmpty) return;

    bool alreadyFriend = _friends.any((f) => f['name'].toLowerCase() == inputName.toLowerCase());
    if (alreadyFriend) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$inputName est déjà dans votre liste d\'amis !')),
      );
      return;
    }

    setState(() {
      final globalMatch = _globalPlayers.firstWhere(
        (player) => player['name'].toLowerCase() == inputName.toLowerCase(),
        orElse: () => {},
      );

      if (globalMatch.isNotEmpty) {
        _friends.add({
          'name': globalMatch['name'],
          'points': globalMatch['points'],
          'level': globalMatch['level'],
          'avatar': globalMatch['avatar'],
          'isMe': false,
        });
      } else {
        _friends.add({
          'name': inputName,
          'points': 1200,
          'level': 'Débutant',
          'avatar': '💪',
          'isMe': false,
        });
      }
    });

    _friendController.clear();
    Navigator.pop(context);
  }

  void _showAddFriendDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          widget.currentLanguage == 'AR' ? 'إضافة صديق' : 'Ajouter un ami',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: _friendController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: widget.currentLanguage == 'AR' ? 'اسم المستخدم أو ID' : 'Pseudo ou ID de l\'ami',
            hintStyle: const TextStyle(color: Colors.white38),
            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFC0F235))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(widget.currentLanguage == 'AR' ? 'إلغاء' : 'Annuler', style: const TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC0F235),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _addFriendAction,
            child: Text(widget.currentLanguage == 'AR' ? 'إضافة' : 'Ajouter', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _friends.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));
    _globalPlayers.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));

    final isRtl = widget.currentLanguage == 'AR';

    return Column(
      children: [
        // Sélecteur d'onglets (Amis / Mondial) style Strava
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: const Color(0xFFC0F235),
              borderRadius: BorderRadius.circular(10),
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white60,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: [
              Tab(text: widget.currentLanguage == 'AR' ? 'الأصدقاء' : 'Amis'),
              Tab(text: widget.currentLanguage == 'AR' ? 'عالمي' : 'Mondial'),
            ],
          ),
        ),
        
        // Contenu des listes
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildLeaderboardList(_friends, isRtl, showCountry: false),
              _buildLeaderboardList(_globalPlayers, isRtl, showCountry: true),
            ],
          ),
        ),

        // Bouton d'ajout d'ami intégré directement en bas de l'onglet Amis
        if (_tabController.index == 0)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC0F235),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
                onPressed: _showAddFriendDialog,
                icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.black),
                label: Text(
                  widget.currentLanguage == 'AR' ? 'إضافة صديق' : 'Ajouter un ami',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLeaderboardList(List<Map<String, dynamic>> usersList, bool isRtl, {required bool showCountry}) {
    final top1 = usersList.length > 0 ? usersList[0] : null;
    final top2 = usersList.length > 1 ? usersList[1] : null;
    final top3 = usersList.length > 2 ? usersList[2] : null;
    final remainingUsers = usersList.skip(3).toList();

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
        children: [
          _buildPersonalStatsHeader(isRtl),
          const SizedBox(height: 20),
          
          // Le Podium Visuel
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (top2 != null) _buildPodiumColumn(top2, 2, 110, Colors.grey[400]!, showCountry),
              if (top1 != null) _buildPodiumColumn(top1, 1, 140, const Color(0xFFC0F235), showCountry),
              if (top3 != null) _buildPodiumColumn(top3, 3, 95, Colors.brown[400]!, showCountry),
            ],
          ),
          const SizedBox(height: 20),

          // Liste des compétiteurs restants
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: remainingUsers.length,
            itemBuilder: (context, index) {
              final user = remainingUsers[index];
              final actualRank = index + 4;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: user['isMe'] ? const Color(0xFFC0F235).withOpacity(0.1) : const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: user['isMe'] ? const Color(0xFFC0F235) : Colors.transparent,
                    width: user['isMe'] ? 1 : 0,
                  ),
                ),
                child: Row(
                  children: [
                    Text('#$actualRank', style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Text(user['avatar'], style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            user['name'] + (user['isMe'] ? ' (Moi)' : ''),
                            style: TextStyle(
                              color: user['isMe'] ? const Color(0xFFC0F235) : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          if (showCountry && user['country'] != null) ...[
                            const SizedBox(width: 6),
                            Text(user['country'], style: const TextStyle(fontSize: 12)),
                          ]
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${user['points']} XP', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(user['level'], style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalStatsHeader(bool isRtl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[900]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem('5', widget.currentLanguage == 'AR' ? 'جلسات' : 'Séances', Icons.fitness_center),
          _buildStatItem('3.4k', 'Kcal', Icons.local_fire_department_rounded),
          _buildStatItem('240', 'Min', Icons.timer_rounded),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFC0F235), size: 20),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
      ],
    );
  }

  Widget _buildPodiumColumn(Map<String, dynamic> user, int rank, double height, Color color, bool showCountry) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Text(user['avatar'], style: const TextStyle(fontSize: 28)),
            if (showCountry && user['country'] != null)
              Positioned(right: -2, bottom: -2, child: Text(user['country'], style: const TextStyle(fontSize: 10))),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          user['name'],
          style: TextStyle(
            color: user['isMe'] ? const Color(0xFFC0F235) : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 85,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            border: Border.all(color: color, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color,
                child: Text(rank.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const SizedBox(height: 6),
              Text('${user['points']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              const Text('XP', style: TextStyle(color: Colors.white54, fontSize: 9)),
            ],
          ),
        ),
      ],
    );
  }
}