import 'package:flutter/material.dart';
import 'package:loja_virtual_nova/models/user_model.dart';
import 'package:loja_virtual_nova/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _adressController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Voltar",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading == true)
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
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty)
                          return "Campo inválido!";
                        else
                          return null;
                      },
                    ),
                    SizedBox(
                      height: 17.0,
                    ),
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
                      controller: _adressController,
                      decoration: InputDecoration(hintText: "Endereço"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty)
                          return "Endereço inválido!";
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
                          return "Mínimo 6 dígitos";
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 37.0,
                    ),
                    SizedBox(
                      height: 45.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "address": _adressController.text
                            };
                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                        child: Text(
                          "Cadastrar-se",
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

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
