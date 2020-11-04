import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final User usuario = ModalRoute.of(context).settings.arguments;
    _loadFormData(usuario);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de usuário"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValid = _form.currentState.validate();
                if (isValid) {
                  _form.currentState.save();
                  Provider.of<Users>(context, listen: false).put(
                    User(
                        id: _formData['id'],
                        name: _formData['name'],
                        email: _formData['email'],
                        avatarUrl: _formData['avatarUrl']),
                  );
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
              key: _form,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: _formData['name'],
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Erro: campo nome é obrigatório!';
                      }
                      if (value.trim().length < 3) {
                        return 'Erro: O nome é muito pequeno menor que 3 caracteres!';
                      }
                      return null;
                    },
                    onSaved: (newValue) => _formData['name'] = newValue,
                  ),
                  TextFormField(
                    initialValue: _formData['email'],
                    decoration: InputDecoration(labelText: 'E-mail'),
                    onSaved: (newValue) => _formData['email'] = newValue,
                  ),
                  TextFormField(
                    initialValue: _formData['avatarUrl'],
                    decoration: InputDecoration(labelText: 'Url do Avatar'),
                    onSaved: (newValue) => _formData['avatarUrl'] = newValue,
                  )
                ],
              ))),
    );
  }
}
