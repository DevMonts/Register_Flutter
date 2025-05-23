import 'package:flutter/material.dart';
import 'package:group_system_app/common/constants/colors.dart';
import 'package:group_system_app/common/constants/input_style.dart';
import 'package:group_system_app/common/constants/text.dart';
import 'package:group_system_app/common/constants/validators.dart';
import 'package:group_system_app/common/widgets/button.dart';
import 'package:group_system_app/features/register/data/model/register_model.dart';
import 'package:group_system_app/features/register/logic/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void validateForm() {
    if (_formKey.currentState!.validate()) {
      handleForm();
    }
  }

  void handleForm() async {
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    final registerModel = RegisterModel(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    try {
      await registerProvider.register(registerModel);
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      showMessagePopup(context, "Sucesso!", "Usuário cadastrado com sucesso!");
      Navigator.pushNamed(context, "/login");
    } catch (e) {
      showMessagePopup(context, "Erro ao cadastrar", "Usuário já existe");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cadastro",
                  style: AppTextStyles.title,
                ),
                Text(
                  "Crie sua conta",
                  style: AppTextStyles.body,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: AppInputDecoration.primaryInput.copyWith(
                    labelText: "Nome",
                    hintText: "Digite seu nome",
                  ),
                  validator: validateString,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: AppInputDecoration.primaryInput.copyWith(
                    labelText: "Email",
                    hintText: "Digite seu email",
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
                    hintText: "Crie uma senha",
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
                  child: Text(
                    "Cadastre-se",
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
                    Navigator.pop(context);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Faça Login",
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
