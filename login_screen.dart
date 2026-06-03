import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  final String initialLanguage;
  const LoginScreen({Key? key, required this.initialLanguage}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _currentLanguage;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dictionnaire des traductions pour la connexion
  final Map<String, Map<String, String>> _uiTexts = {
    'FR': {
      'title': 'Connexion',
      'subtitle': 'Heureux de vous revoir sur Ni-Gym. Entrez vos identifiants.',
      'email': 'Adresse e-mail',
      'password': 'Mot de passe',
      'btn': 'Se connecter',
      'footer': 'Pas de compte ? S’inscrire',
      'errEmail': 'Entrez un e-mail valide',
      'errPass': 'Veuillez entrer votre mot de passe'
    },
    'EN': {
      'title': 'Welcome Back',
      'subtitle': 'Great to see you again at Ni-Gym. Enter your credentials.',
      'email': 'Email Address',
      'password': 'Password',
      'btn': 'Sign In',
      'footer': 'Don’t have an account? Sign Up',
      'errEmail': 'Enter a valid email address',
      'errPass': 'Please enter your password'
    },
    'AR': {
      'title': 'تسجيل الدخول',
      'subtitle': 'يسعدنا رؤيتك مجدداً في Ni-Gym. أدخل بياناتك.',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'btn': 'تسجيل الدخول',
      'footer': 'ليس لديك حساب؟ إنشاء حساب',
      'errEmail': 'الرجاء إدخال بريد إلكتروني صحيح',
      'errPass': 'الرجاء إدخال كلمة المرور'
    },
  };

  @override
  void initState() {
    super.initState();
    _currentLanguage = widget.initialLanguage;
  }

  void _handleSignIn() {
  if (_formKey.currentState!.validate()) {
    // Redirection immédiate vers l'écran d'accueil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(initialLanguage: _currentLanguage),
      ),
      (route) => false, // Supprime tout l'historique pour ne pas revenir en arrière au Onboarding en cliquant sur retour
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
                  const SizedBox(height: 40),
                  Text(texts['title']!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  Text(texts['subtitle']!, style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.4)),
                  const SizedBox(height: 50),

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
                    validator: (v) => v == null || v.isEmpty ? texts['errPass'] : null
                  ),
                  const SizedBox(height: 40),

                  // Bouton Connexion Vert Fluo
                  ElevatedButton(
                    onPressed: _handleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC0F235),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(texts['btn']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),

                  // Lien vers l'Inscription (Sign Up)
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (c) => RegisterScreen(initialLanguage: _currentLanguage))
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