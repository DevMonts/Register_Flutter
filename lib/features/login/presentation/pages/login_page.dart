import 'package:flutter/material.dart';
import 'package:group_system_app/common/constants/colors.dart';
import 'package:group_system_app/common/constants/input_style.dart';
import 'package:group_system_app/common/constants/validators.dart';
import 'package:group_system_app/common/constants/text.dart';
import 'package:group_system_app/common/widgets/button.dart';
import 'package:group_system_app/features/login/logic/providers/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void validateForm() {
    if (_formKey.currentState!.validate()) {
      handleForm();
    }
  }

  Future<void> handleForm() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    try {
      await loginProvider.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: AppTextStyles.title,
                ),
                Text(
                  "Digite suas credenciais",
                  style: AppTextStyles.body,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: AppInputDecoration.primaryInput.copyWith(
                    labelText: "Email",
                    hintText: "Insira o seu email!",
                  ),
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: AppInputDecoration.primaryInput.copyWith(
                    labelText: "Senha",
                    hintText: "Insira a sua senha!",
                    suffixIcon: _obscureText
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.visibility_off),
                          )
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.visibility),
                          ),
                  ),
                  obscureText: _obscureText,
                  validator: validatePassword,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  child: loginProvider.isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Entrar",
                          style: AppTextStyles.button.copyWith(
                            color: Colors.white,
                          ),
                        ),
                  onPressed: () {
                    validateForm();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Cadastre-se",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
