import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usiamo LayoutBuilder per adattare il layout in base alla larghezza dello schermo
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Layout per desktop
          return _buildDesktopLayout(context);
        } else {
          // Layout per mobile
          return _buildMobileLayout(context);
        }
      },
    );
  }

  // Layout per schermi grandi
  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            _buildHeaderSection(context),
            const SizedBox(height: 80),
            _buildAboutSection(context),
            const SizedBox(height: 80),
            _buildSkillsSection(context),
            const SizedBox(height: 80),
            _buildProjectsSection(context),
            const SizedBox(height: 80),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }

  // Layout per schermi piccoli
  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildHeaderSection(context),
            const SizedBox(height: 40),
            _buildAboutSection(context),
            const SizedBox(height: 40),
            _buildSkillsSection(context),
            const SizedBox(height: 40),
            _buildProjectsSection(context),
            const SizedBox(height: 40),
            _buildContactSection(context),
          ],
        ),
      ),
    );
  }
  
  // Widget dell'AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Il Mio Portfolio'),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
  
  // Widget per la sezione di intestazione
  Widget _buildHeaderSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ciao, sono [Il tuo nome]',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Sono uno sviluppatore Flutter',
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {}, // Funzione per scaricare il CV
                child: const Text('Scarica il mio CV'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 50),
        CircleAvatar(
          radius: 150,
          backgroundImage: AssetImage('assets/profile_pic.png'),
        ),
      ],
    );
  }
  
  // Widget per la sezione "Chi sono"
  Widget _buildAboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Chi sono', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          const Text(
            'Inserisci qui una breve descrizione su di te, le tue passioni, la tua esperienza e il tuo approccio al lavoro. Sii conciso e d\'impatto!',
            style: TextStyle(fontSize: 18, height: 1.5),
          ),
        ],
      ),
    );
  }
  
  // Widget per la sezione "Competenze"
  Widget _buildSkillsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Competenze', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: const [
              _SkillChip(label: 'Flutter'),
              _SkillChip(label: 'Dart'),
              _SkillChip(label: 'Firebase'),
              _SkillChip(label: 'UI/UX Design'),
              _SkillChip(label: 'Git'),
            ],
          ),
        ],
      ),
    );
  }
  
  // Widget per la sezione "Progetti"
  Widget _buildProjectsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('I Miei Progetti', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          // Usiamo un GridView.builder per un layout responsive e dinamico
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, // Sostituisci con il numero dei tuoi progetti
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Numero di colonne su desktop
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return _ProjectCard(
                title: 'Progetto ${index + 1}',
                description: 'Breve descrizione del progetto.',
                imagePath: 'assets/project${index + 1}.png',
                link: 'https://github.com/tuo-username', // Sostituisci con i tuoi link
              );
            },
          ),
        ],
      ),
    );
  }
  
  // Widget per la sezione "Contatti"
  Widget _buildContactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contatti', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 20),
          _ContactLink(
            icon: Icons.email,
            label: 'la-tua-email@esempio.com',
            url: 'mailto:la-tua-email@esempio.com',
          ),
          _ContactLink(
            icon: Icons.link,
            label: 'github.com/tuo-username',
            url: 'https://github.com/tuo-username',
          ),
        ],
      ),
    );
  }
}

// Widget per i chip delle competenze
class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

// Widget per la scheda di un progetto
class _ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String link;

  const _ProjectCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(link)),
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 5),
                  Text(description, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget per i link di contatto
class _ContactLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final String url;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 10),
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
