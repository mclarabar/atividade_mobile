import 'package:flutter/material.dart';
import '../services/fake_api_service.dart';
import '../services/news_api_service.dart';
import '../domain/cancer_article.dart';
import 'news_section.dart';
import 'statistics_section.dart';
import 'project_intent.dart';
import 'fake_api_section.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late Future<List<Map<String, dynamic>>> futureCriadores;
  late Future<List<CancerArticle>> futureNews;

  @override
  void initState() {
    super.initState();
    futureCriadores = FakeApiService().fetchCreatorsOnline();
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
            const Text(
              'CRIADORES',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            FutureBuilder<List<Map<String, dynamic>>>(
              future: futureCriadores,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                final criadores = snapshot.data ?? [];

                return SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: criadores.length,
                    itemBuilder: (context, index) {
                      final c = criadores[index];
                      final isNetworkImage = c['image'].toString().startsWith('http');

                      return Container(
                        width: 140,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundImage: isNetworkImage
                                  ? NetworkImage(c['image'])
                                  : AssetImage(c['image']) as ImageProvider,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              c['nome'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            NewsSection(futureNews: futureNews),

            const SizedBox(height: 24),

            const StatisticsSection(),
            const SizedBox(height: 24),
            const FakeApiSection(),
            const SizedBox(height: 24),
            const ProjectIntentSection(),
          ],
        ),
      ),
    );
  }
}
