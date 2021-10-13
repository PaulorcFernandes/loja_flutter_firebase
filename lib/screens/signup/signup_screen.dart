import 'package:flutter/material.dart';
import 'package:loja_flutter_firebase/helpers/validators.dart';
import 'package:loja_flutter_firebase/models/user.dart';
import 'package:loja_flutter_firebase/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final User user = User();

  /* inicio style  button*/
  final ButtonStyle styleButton = ElevatedButton.styleFrom(
    primary: const Color.fromARGB(255, 4, 125, 141),
  );
  /* fim style button*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldStateKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 4, 125, 141),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: ListView(
                  padding: EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Nome Completo',
                      ),
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Campo Obrigatorio';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome com sobrenome';
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Campo Obrigatorio';
                        } else if (!emailValid(email)) {
                          return 'E-mail invalido';
                        }
                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      obscureText: true,
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return 'Campo Obrigatorio';
                        } else if (pass.length > 6) {
                          return 'Senha curta, deve ter no minimo 6 digitos';
                        }
                        return null;
                      },
                      onSaved: (pass) {},
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Repita a senha',
                      ),
                      obscureText: true,
                      validator: (confirmPass) {
                        if (confirmPass.isEmpty) {
                          return 'Campo Obrigatorio';
                        } else if (confirmPass.length > 6) {
                          return 'Senha curta, deve ter no minimo 6 digitos';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: styleButton,
                        onPressed: () {
                          formKey.currentState.validate();
                          if (user.password != user.confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('As senhas devem ser iguais.'),
                                  backgroundColor: Colors.red),
                            );
                            return;
                          }
                          context.read<UserManager>().signUp(
                              user: user,
                              onSuccess: () {},
                              onFail: (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Falha ao cadastrar: $e'),
                                      backgroundColor: Colors.red),
                                );
                              });
                        },
                        child: Text(
                          'Cria conta',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ));
  }
}
