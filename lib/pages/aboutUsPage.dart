import 'package:flutter/material.dart';
import 'package:page_creators/pages/project_intent.dart';
import 'package:page_creators/pages/statistics_section.dart';
import '../db/propriedades_dao.dart';
import '../domain/cancer_article.dart';
import '../domain/propriedade.dart';
import '../services/news_api_service.dart';
import 'creators_section.dart';
import 'news_section.dart';
import 'fake_api_section.dart';
import 'statistics_section.dart';



class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late Future<List<Propriedade>> futurePropriedades;
  late Future<List<CancerArticle>> futureNews;

  @override
  void initState() {
    super.initState();
    futurePropriedades = PropriedadesDao().listarPropriedades();
    futureNews = NewsApiService().fetchCancerNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: const Text(
            'SOBRE O PROJETO',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color(0xFFC49CE8),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            CreatorsSection(futurePropriedades: futurePropriedades),
            const SizedBox(height: 24),
            NewsSection(futureNews: futureNews),
            const SizedBox(height: 24),
            const StatisticsSection(),
            const SizedBox(height: 24),
            const FakeApiSection(),
            const SizedBox(height: 24),
            const ProjectIntentSection(),
            const FakeApiSection(),
            const StatisticsSection(),

          ],
        ),
      ),
    );
  }
}
