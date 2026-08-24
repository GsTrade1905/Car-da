import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CarsidaApp());
}

class CarsidaApp extends StatelessWidget {
  const CarsidaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Çarşıda',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF57C00),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFBF7),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Category {
  final String name;
  final IconData icon;
  const Category(this.name, this.icon);
}

class Business {
  final String name;
  final String category;
  final double rating;
  final double distanceKm;
  final bool isOpen;
  final String address;
  final String phone;
  final String whatsapp;
  final String hours;
  final double lat;
  final double lng;

  const Business({
    required this.name,
    required this.category,
    required this.rating,
    required this.distanceKm,
    required this.isOpen,
    required this.address,
    required this.phone,
    required this.whatsapp,
    required this.hours,
    required this.lat,
    required this.lng,
  });
}

const categories = <Category>[
  Category('Kasap', Icons.set_meal_outlined),
  Category('Manav', Icons.eco_outlined),
  Category('Market', Icons.shopping_cart_outlined),
  Category('Fırın', Icons.bakery_dining_outlined),
  Category('Restoran', Icons.restaurant_outlined),
  Category('Berber', Icons.content_cut_outlined),
  Category('Kuaför', Icons.face_retouching_natural_outlined),
  Category('Tesisatçı', Icons.plumbing_outlined),
  Category('Elektrikçi', Icons.electrical_services_outlined),
  Category('Oto Servis', Icons.car_repair_outlined),
  Category('Pet Shop', Icons.pets_outlined),
  Category('Nalbur', Icons.handyman_outlined),
];

const demoBusinesses = <Business>[
  Business(
    name: 'Merkez Kasabı',
    category: 'Kasap',
    rating: 4.8,
    distanceKm: 0.35,
    isOpen: true,
    address: 'Merkez Mahallesi, No: 12',
    phone: '+905551112233',
    whatsapp: '905551112233',
    hours: '08:00 - 21:00',
    lat: 37.8600,
    lng: 27.2600,
  ),
  Business(
    name: 'Çınar Manav',
    category: 'Manav',
    rating: 4.6,
    distanceKm: 0.62,
    isOpen: true,
    address: 'Çınar Sokak, No: 8',
    phone: '+905552223344',
    whatsapp: '905552223344',
    hours: '07:30 - 22:00',
    lat: 37.8612,
    lng: 27.2570,
  ),
  Business(
    name: 'Mahalle Market',
    category: 'Market',
    rating: 4.5,
    distanceKm: 0.78,
    isOpen: true,
    address: 'Atatürk Caddesi, No: 26',
    phone: '+905553334455',
    whatsapp: '905553334455',
    hours: '08:00 - 23:00',
    lat: 37.8578,
    lng: 27.2640,
  ),
  Business(
    name: 'Usta Elektrik',
    category: 'Elektrikçi',
    rating: 4.9,
    distanceKm: 1.10,
    isOpen: false,
    address: 'Sanayi Sitesi, Blok B',
    phone: '+905554445566',
    whatsapp: '905554445566',
    hours: '09:00 - 19:00',
    lat: 37.8520,
    lng: 27.2700,
  ),
  Business(
    name: 'Çarşı Berber',
    category: 'Berber',
    rating: 4.7,
    distanceKm: 1.35,
    isOpen: true,
    address: 'Çarşı İçi, No: 4',
    phone: '+905555556677',
    whatsapp: '905555556677',
    hours: '09:00 - 21:00',
    lat: 37.8630,
    lng: 27.2510,
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();
  String query = '';

  List<Business> get filteredBusinesses {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return demoBusinesses;
    return demoBusinesses.where((business) {
      return business.name.toLowerCase().contains(q) ||
          business.category.toLowerCase().contains(q);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCategory(String category) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BusinessListPage(
          title: category,
          businesses: demoBusinesses
              .where((business) => business.category == category)
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFBF7),
        surfaceTintColor: Colors.transparent,
        title: const Row(
          children: [
            Icon(Icons.storefront_rounded, color: Color(0xFFF57C00)),
            SizedBox(width: 8),
            Text('ÇARŞIDA', style: TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 30),
          children: [
            const Text(
              'Mahallendeki her şey burada.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Row(
              children: [
                Icon(Icons.location_on_outlined, size: 18),
                SizedBox(width: 4),
                Text('Konum: Yakınımda'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                hintText: 'Kasap, manav, elektrikçi ara...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Kategoriler', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                TextButton(onPressed: () {}, child: const Text('Tümü')),
              ],
            ),
            const SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 12,
                crossAxisSpacing: 10,
                childAspectRatio: .85,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => _openCategory(category.name),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFFFE0C2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category.icon, color: const Color(0xFFF57C00), size: 30),
                        const SizedBox(height: 8),
                        Text(
                          category.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 26),
            const Text('Yakındaki Esnaflar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            if (filteredBusinesses.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: Center(child: Text('Aramana uygun esnaf bulunamadı.')),
              )
            else
              ...filteredBusinesses.map((business) => BusinessCard(business: business)),
          ],
        ),
      ),
    );
  }
}

class BusinessListPage extends StatelessWidget {
  final String title;
  final List<Business> businesses;

  const BusinessListPage({super.key, required this.title, required this.businesses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: businesses.isEmpty
          ? const Center(child: Text('Bu kategoride demo işletme henüz yok.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: businesses.length,
              itemBuilder: (_, index) => BusinessCard(business: businesses[index]),
            ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final Business business;
  const BusinessCard({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFFFE0C2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => BusinessDetailPage(business: business)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0E0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.storefront, color: Color(0xFFF57C00), size: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(business.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 5),
                    Text('${business.category} • ${business.distanceKm.toStringAsFixed(2)} km'),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
                        Text(' ${business.rating.toStringAsFixed(1)}  '),
                        Text(
                          business.isOpen ? 'Açık' : 'Kapalı',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: business.isOpen ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessDetailPage extends StatelessWidget {
  final Business business;
  const BusinessDetailPage({super.key, required this.business});

  Future<void> _launch(String rawUrl) async {
    final uri = Uri.parse(rawUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(business.name)),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8D2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.storefront_rounded, size: 88, color: Color(0xFFF57C00)),
          ),
          const SizedBox(height: 18),
          Text(business.name, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              Chip(label: Text(business.category)),
              Chip(avatar: const Icon(Icons.star_rounded, size: 18), label: Text('${business.rating}')),
              Chip(label: Text('${business.distanceKm.toStringAsFixed(2)} km')),
              Chip(label: Text(business.isOpen ? 'Açık' : 'Kapalı')),
            ],
          ),
          const SizedBox(height: 20),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Adres'),
            subtitle: Text(business.address),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule_outlined),
            title: const Text('Çalışma saatleri'),
            subtitle: Text(business.hours),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _launch('tel:${business.phone}'),
                  icon: const Icon(Icons.call),
                  label: const Text('Ara'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: FilledButton.tonalIcon(
                  onPressed: () => _launch('https://wa.me/${business.whatsapp}'),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => _launch(
              'https://www.google.com/maps/search/?api=1&query=${business.lat},${business.lng}',
            ),
            icon: const Icon(Icons.directions),
            label: const Text('Yol Tarifi'),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.verified_user_outlined),
            label: const Text('Bu işletmenin sahibi benim'),
          ),
        ],
      ),
    );
  }
}
