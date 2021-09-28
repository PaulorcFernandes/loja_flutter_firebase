import 'package:flutter/material.dart';
import 'package:loja_flutter_firebase/models/user.dart';
import 'package:provider/provider.dart';
import 'package:loja_flutter_firebase/helpers/validators.dart';
import 'package:loja_flutter_firebase/models/user_manager.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /* inicio style */
    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      primary: const Color.fromARGB(255, 4, 125, 141),
    );
    /* fim style */
    return Scaffold(
      key: scaffoldStateKey,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        actions: <Widget>[
          ElevatedButton(onPressed: (){

          },
          child: Text(
            'CRIAR CONTA', 
            style: TextStyle(
              fontSize: 14,
              color: Colors.white
            ),
          ),
        )
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(
                builder: (_, userManager, child) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'E-mail', 
                          suffixIcon: Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email)) {
                            return 'E-mail invalido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        enabled: !userManager.loading,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          suffixIcon: Icon(Icons.lock),  
                        ),
                        autocorrect: false,
                        obscureText: true,
                        validator: (pass) {
                          if (pass.isEmpty || pass.length < 6) {
                            return 'Senha invalida';
                          }
                          return null;
                        },
                      ),
                      child,
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton(
                          style: userManager.loading ? null : styleButton,
                          onPressed: userManager.loading ? null : () {
                            if (formKey.currentState.validate()) {
                              userManager.signIn(
                                  user: User(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                  onFail: (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red),
                                    );
                                  },
                                  onSuccess: () {
                                    //TODO: fechar login
                                  });
                            }
                          },
                          child: userManager.loading ? 
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(Color.fromARGB(255, 4, 125, 141),),
                              ) : Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text('Esqueci minha senha',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {},
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
