import 'package:flutter/material.dart';
import '../services/fake_api_service.dart';
import 'creators_gallery_page.dart';

class FakeApiSection extends StatelessWidget {
  const FakeApiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: FakeApiService().fetchCreatorsFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
        } else if (snapshot.hasError) {
          return Text('Erro ao carregar dados: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhum dado encontrado no banco local.');
        }

        final criadores = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nossa Equipe',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3A0CA3),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatorsGalleryPage (criadores: criadores),
                      ),
                    );
                  },
                  child: const Text(
                    'Ver todos ›',
                    style: TextStyle(
                      color: Color(0xFF5E17EB),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...criadores.take(4).map((c) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E8FF),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(c['image']),
                  radius: 28,
                ),
                title: Text(
                  c['nome'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5E17EB),
                  ),
                ),
                subtitle: const Text(
                  'Integrante do Projeto Safe Lung',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            )),
          ],
        );
      },
    );
  }
}
