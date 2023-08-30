class Product {
  final String title;
  final String description;
  Product({
    required this.title,
    required this.description,
  });

  static Future<List<Product>> generateFakeProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    return List.generate(
        10,
        (index) => Product(
            title: 'Product ${characters[index % characters.length]}$index',
            description: 'Description $index'));
  }
}