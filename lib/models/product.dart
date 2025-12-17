class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath; // ASSET
  final String partNumber;
  final List<String> compatibleVehicles;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.partNumber,
    required this.compatibleVehicles,
    required this.category,
  });
}

final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'Filtro de Aceite Sintético',
    description:
        'Filtro de alto rendimiento diseñado para aceites sintéticos.',
    price: 15.50,
    imagePath: 'assets/images/BIELETACLIO.jpg',
    partNumber: 'FA-1001-SYN',
    compatibleVehicles: [
      'Toyota Corolla 2010-2020',
      'Honda Civic 2012-2018',
    ],
    category: 'Motor',
  ),
  Product(
    id: '2',
    name: 'Pastillas de Freno Cerámicas',
    description:
        'Reduce el polvo y el ruido, excelente rendimiento.',
    price: 45.99,
    // si quiere poner imagenes diferentes solo cambie el nombre del archivo y asegurese de que este en la carpeta assets/images pero recuerde debe de cambiar el nombre del archivo de imagenes para que no tenga espacios
    imagePath: 'assets/images/BIELETACLIO.jpg',
    partNumber: 'PF-2050-CER',
    compatibleVehicles: [
      'Ford Focus 2015-2021',
      'Mazda 3 2014-2019',
    ],
    category: 'Frenos',
  ),
  Product(
    id: '3',
    name: 'Amortiguador Trasero Gas',
    description:
        'Manejo estable y cómodo en todo terreno.',
    price: 78.00,
    imagePath: 'assets/images/amortiguador.jpg',
    partNumber: 'AM-5012-GAS',
    compatibleVehicles: [
      'Nissan Sentra 2008-2016',
    ],
    category: 'Suspensión',
  ),
];
