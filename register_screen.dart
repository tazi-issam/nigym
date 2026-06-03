import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  final String initialLanguage;
  const RegisterScreen({Key? key, required this.initialLanguage}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _currentLanguage;
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dictionnaire des traductions pour l'inscription
  final Map<String, Map<String, String>> _uiTexts = {
    'FR': {
      'title': 'Créer un compte',
      'subtitle': 'Rejoignez Ni-Gym et commencez votre transformation dès aujourd’hui.',
      'name': 'Nom complet',
      'email': 'Adresse e-mail',
      'password': 'Mot de passe',
      'btn': 'S’inscrire',
      'footer': 'Déjà un compte ? Se connecter',
      'errName': 'Veuillez entrer votre nom',
      'errEmail': 'Entrez un e-mail valide',
      'errPass': 'Le mot de passe doit faire 6 caractères minimum.'
    },
    'EN': {
      'title': 'Create Account',
      'subtitle': 'Join Ni-Gym and start your transformation today.',
      'name': 'Full Name',
      'email': 'Email Address',
      'password': 'Password',
      'btn': 'Sign Up',
      'footer': 'Already have an account? Sign In',
      'errName': 'Please enter your name',
      'errEmail': 'Enter a valid email address',
      'errPass': 'Password must be at least 6 characters long'
    },
    'AR': {
      'title': 'إنشاء حساب',
      'subtitle': 'انضم إلى Ni-Gym وابدأ رحلة التغيير اليوم.',
      'name': 'الاسم الكامل',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'btn': 'إنشاء الحساب',
      'footer': 'لديك حساب بالفعل؟ تسجيل الدخول',
      'errName': 'الرجاء إدخال الاسم الكامل',
      'errEmail': 'الرجاء إدخال بريد إلكتروني صحيح',
      'errPass': 'يجب أن تكون كلمة المرور 6 أحرف على الأقل'
    },
  };

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.initialLanguage; // Récupère la langue choisie sur l'onboarding
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      // Logique d'inscription (Firebase / Connexion API)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscription validée pour : ${_nameController.text}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = _currentLanguage == 'AR';
    final texts = _uiTexts[_currentLanguage]!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isRtl ? Icons.arrow_forward : Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [_buildLanguageDropdown()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Text(texts['title']!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  Text(texts['subtitle']!, style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.4)),
                  const SizedBox(height: 40),

                  // Champ Nom
                  _buildField(
                    controller: _nameController, 
                    label: texts['name']!, 
                    icon: Icons.person_outline, 
                    validator: (v) => v == null || v.isEmpty ? texts['errName'] : null
                  ),
                  const SizedBox(height: 20),

                  // Champ Email
                  _buildField(
                    controller: _emailController, 
                    label: texts['email']!, 
                    icon: Icons.mail_outline, 
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => v != null && v.contains('@') ? null : texts['errEmail']
                  ),
                  const SizedBox(height: 20),

                  // Champ Mot de passe
                  _buildField(
                    controller: _passwordController, 
                    label: texts['password']!, 
                    icon: Icons.lock_outline, 
                    isObscure: true,
                    validator: (v) => v != null && v.length >= 6 ? null : texts['errPass']
                  ),
                  const SizedBox(height: 40),

                  // Bouton d'inscription Vert Fluo
                  ElevatedButton(
                    onPressed: _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC0F235),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(texts['btn']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),

                  // Lien vers la Connexion (Sign In)
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (c) => LoginScreen(initialLanguage: _currentLanguage))
                      );
                    },
                    child: Text(texts['footer']!, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller, 
    required String label, 
    required IconData icon, 
    bool isObscure = false, 
    TextInputType keyboardType = TextInputType.text, 
    String? Function(String?)? validator
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: Icon(icon, color: Colors.grey[500]),
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFC0F235), width: 1.5)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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