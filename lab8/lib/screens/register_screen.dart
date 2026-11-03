import 'package:flutter/material.dart';
import 'home_screen.dart';

/// 1. Екран реєстрації RegisterScreen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // 2. Глобальний ключ для валідації Form
  final _formKey = GlobalKey<FormState>();

  // 6. TextEditingController для зчитування введених значень
  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Вибір дати народження через календар з автозаповненням
  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final formatted =
          '${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}';
      setState(() {
        _birthDateController.text = formatted;
      });
    }
  }

  // Обробка натискання кнопки «Зареєструватися»
  void _submitForm() {
    // 13. Перевірка, що перехід виконується лише після успішної валідації
    if (_formKey.currentState!.validate()) {
      final userName = _nameController.text.trim();

      // 8, 9, 11. Навігація з RegisterScreen на HomeScreen з передачею імені користувача
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(userName: userName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Реєстрація користувача'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Icon(
                  Icons.person_add_alt_1,
                  size: 64,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Створіть свій обліковий запис',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                // 3.1. Поле: ім’я користувача
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ім’я користувача *',
                    hintText: 'Введіть ваше ім’я',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  // 5. Валідація: не порожнє, не менше 2-3 символів
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, введіть ім’я користувача';
                    }
                    if (value.trim().length < 3) {
                      return 'Ім’я повинно містити не менше 3 символів';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3.2. Поле: дата народження
                TextFormField(
                  controller: _birthDateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Дата народження *',
                    hintText: 'ДД.ММ.РРРР',
                    prefixIcon: const Icon(Icons.cake),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectBirthDate(context),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  // 5. Валідація дати народження
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, вкажіть дату народження';
                    }
                    final parts = value.split('.');
                    if (parts.length != 3) {
                      return 'Неправильний формат дати (очікується ДД.ММ.РРРР)';
                    }
                    final day = int.tryParse(parts[0]);
                    final month = int.tryParse(parts[1]);
                    final year = int.tryParse(parts[2]);
                    if (day == null ||
                        month == null ||
                        year == null ||
                        day < 1 ||
                        day > 31 ||
                        month < 1 ||
                        month > 12 ||
                        year < 1900 ||
                        year > DateTime.now().year) {
                      return 'Введіть коректну дату народження';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3.3. Поле: email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email *',
                    hintText: 'example@domain.com',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  // 5. Валідація email: не порожній, містить @
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Будь ласка, введіть email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Email повинен містити символ @ та домен';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3.4. Поле: пароль
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Пароль *',
                    hintText: 'Не менше 6 символів',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  // 5. Валідація пароля: не менше 6 символів
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка, введіть пароль';
                    }
                    if (value.length < 6) {
                      return 'Пароль повинен містити не менше 6 символів';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 3.5. Поле: підтвердження пароля
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Підтвердження пароля *',
                    hintText: 'Повторіть введений пароль',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  // 5. Валідація підтвердження: повинно збігатися з паролем
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Будь ласка, підтвердіть пароль';
                    }
                    if (value != _passwordController.text) {
                      return 'Паролі не збігаються';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                // 7. Кнопка «Зареєструватися»
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Зареєструватися',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
