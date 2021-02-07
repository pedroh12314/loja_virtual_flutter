import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/create_account.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Bem Vindo(a)"),
          leading: GestureDetector(
            child: FlatButton(
              onPressed: () {
                // Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(builder: (context) => EditProfile()));
              },
              child: Text(
                "Editar",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
              textColor: Colors.white,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CreateAccount()));
              },
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "Email inválido!";
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 17.0,
                    ),
                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida!";
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 37.0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty) {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Insira seu email acima para recurar sua senha"),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Confira o LINK em sua caixa de entrada no seu email cadastrado..."),
                                backgroundColor: Theme.of(context).primaryColor,
                                duration: Duration(seconds: 5),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Esqueceu sua senha?",
                          textAlign: TextAlign.right,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(
                      height: 17.0,
                    ),
                    SizedBox(
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        child: Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              );
          },
        ));
  }

  _onSuccess() {
    Navigator.of(context).pop();
  }

  _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao entrar!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
