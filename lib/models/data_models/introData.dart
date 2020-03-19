class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  final String title;
  final String category;
  final String imageUrl;
}

final sampleItems = <IntroItem>[
  new IntroItem(
    title: 'Search Sensor Location',
    category:
        'Search for the available sensors', //get to know what are the available sensors in here'
    imageUrl: 'assets/intro_images/1.png',
  ),
  new IntroItem(
    title: 'About',
    category: 'Get to know about the Infineon Sensor Application',
    imageUrl: 'assets/intro_images/2.png',
  ),
  new IntroItem(
    title: 'Settings ',
    category: 'Configure setting for this app',
    imageUrl: 'assets/intro_images/3.png',
  ),
];
