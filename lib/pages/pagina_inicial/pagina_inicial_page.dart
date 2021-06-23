import 'package:alugueja/components/main_drawer.dart';
import 'package:alugueja/components/notificacao.dart';
import 'package:alugueja/pages/add_publicacao/add_publicacao_page.dart';
import 'package:alugueja/pages/feed_publicacao/feed_publicacao_page.dart';
import 'package:alugueja/pages/mensagem/mensagem_page.dart';
import 'package:alugueja/pages/pesquisa/pesquisar_page.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class PaginaInicialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'AlugueJá',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          actions: [
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: quintaCor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PesquisarPage(),
                    ),
                  );
                },
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home, color: Colors.white),
                text: 'Início',
              ),
              Tab(
                icon: Icon(Icons.add, color: Colors.white),
                text: 'Publicar',
              ),
              Tab(
                icon: Icon(Icons.notifications, color: Colors.white),
                text: 'Notificação',
              ),
              Tab(
                icon: Icon(Icons.message, color: Colors.white),
                text: 'Mensagem',
              ),
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: [
            FeedPublicacaoPage(),
            AddPublicacaoPage(),
            Notificacao(),
            MensagemPage(),
          ],
        ),
      ),
    );
  }
}
