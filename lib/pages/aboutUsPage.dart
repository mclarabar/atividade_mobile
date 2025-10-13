import 'package:flutter/material.dart';
import '../db/propriedades_dao.dart';
import '../domain/propriedade.dart';
import '../widget/card_propriedade.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late Future<List<Propriedade>> futurePropriedades;

  int selectIndex = 0;
  //List listaPropriedades = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    futurePropriedades = PropriedadesDao().listarPropriedades();

    /*Espera o Future concluir

    listaPropriedades = await PropriedadesDao().listarPropriedades();
    setState(() {});*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text(
            'CONHECENDO OS CRIADORES',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_circle_rounded),
                color: Colors.white),
          ],
        ),
        bottomNavigationBar: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 45,
                color: Colors.indigo[900],
              ),
            ),
            ClipOval(
              child: Container(
                height: 80,
                width: 1000,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '< Voltar',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 80.0)),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFC49CE8),
        body: buildFutureBuilder(),
      ),
    );
  }

  Padding buildBody(listaPropriedades) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 16),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: listaPropriedades.length,
            itemBuilder: (context, i) {
              return CardPropriedade(
                propriedade: listaPropriedades[i],
              );
            },
          ),
          Container(
            height: 200,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  'INTUITO DO PROJETO:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    ' Este aplicativo foi criado com o objetivo de oferecer suporte informativo, '
                    'educativo e preventivo a pessoas que convivem com o câncer de pulmão, além '
                    'de promover a conscientização sobre os riscos e formas de prevenção dessa '
                    'doença. Unindo tecnologia, ciência e acessibilidade, a proposta é transformar '
                    'o cuidado com a saúde em algo mais próximo, interativo e eficiente. Um dos '
                    'principais destaques do aplicativo é a ferramenta interativa de rastreio, que '
                    'une um quiz dinâmico com elementos de jogo. Nessa atividade, o usuário responde '
                    'a perguntas relacionadas à sua rotina, hábitos de vida e histórico familiar. Conforme '
                    'as respostas, o sistema identifica comportamentos de risco e os apresenta de forma '
                    'visual e lúdica, permitindo que o usuário compreenda de maneira leve, mas clara, '
                    'quais práticas podem favorecer ou prevenir o câncer de pulmão. O objetivo é promover '
                    'a reflexão e incentivar mudanças positivas no dia a dia de forma natural e engajadora. '
                    'Além disso, o aplicativo oferece um acervo completo de conteúdos informativos, com resumos '
                    'explicativos, flashcards para fixação de informações, artigos científicos atualizados, '
                    'vídeos educativos e outros formatos acessíveis. Esses materiais são voltados tanto para quem '
                    'está em tratamento quanto para quem deseja aprender mais sobre o tema — familiares, estudantes, '
                    'profissionais da saúde ou pessoas que buscam prevenção. Com uma abordagem acolhedora, interativa '
                    'e baseada em evidências, o aplicativo busca empoderar os usuários por meio do conhecimento, auxiliando '
                    'na compreensão do câncer de pulmão, promovendo hábitos saudáveis e contribuindo para o diagnóstico '
                    'precoce e o enfrentamento da doença. A saúde começa com a informação — e esse é o primeiro passo que '
                    'o aplicativo ajuda você a dar.',
                    textAlign: TextAlign.justify,
                    maxLines: 1000),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildFutureBuilder() {
    return FutureBuilder<List<Propriedade>>(
      future: futurePropriedades,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Propriedade> listaPropriedades = snapshot.requireData;
          return buildBody(listaPropriedades);
        } else {
          return Center(
              child: CircularProgressIndicator(
                padding: EdgeInsets.only(bottom: 0, top: 50),
                color: Color(0xFF981DE4),
              ));
        }
      },
    );
  }

  buildGridView(listaPropriedades) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: listaPropriedades.length,
      itemBuilder: (context, i) {
        return CardPropriedade(
          propriedade: listaPropriedades[i],
        );
      },
    );
  }
}
