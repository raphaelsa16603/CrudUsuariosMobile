import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Recuperar dados de uma base de dados externa
    final Users users = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Usuários'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // users.put(User(
                  //     name: 'Raphael', email: 'raphael@email', avatarUrl: ''));
                  Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
                })
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          //itemBuilder: (ctx, i) => Text(users.values.elementAt(i).name),
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i)),
        ));
  }
}
