class Item {
  String imagePath;
  double price;
  String location;
  String title;
  String name;

  Item(
      {required this.imagePath,
      required this.price,
      this.location = "Shop Name",
      required this.title,
      required this.name});
}

final List<Item> items = [
  Item(
    name: "K552 Mechanical Gaming Keyboard",
    imagePath: "assets/image/keyboard.jpg",
    price: 11.99,
    title:
        "K552 Mechanical Gaming Keyboard Rainbow LED Backlit Wired with Anti-Dust Proof Switches for Windows PC (Black, 87 Keys Blue Switches)",
  ),
  Item(
      name: "Wireless Keyboard and Mouse",
      imagePath: "assets/image/package1.jpg",
      price: 14.99,
      title:
          "2.4G Mechanical Feel Rechargeable Wireless Keyboard and Mouse Set, 3000 mAh Capacity, LED Backlit Metal Panel Waterproof Ergonomic USB Gaming Keyboard Anti-Ghosting+ 2400 DPI 6 Buttons Gaming Mouse"),
  Item(
      name: "Mouse Gaming K213",
      imagePath: "assets/image/mouse1.jpeg",
      price: 9.99,
      title:
          "The mouse brings excellent power-saving capabilities to the forefront with a multi-stage power saving mode that will ensure you have power when your game depends on it. An excellent ergonomic design underscores the sturdy construction and virtually noiseless mouse clicks."),
  Item(
      name: "Mouse Gaming K210",
      imagePath: "assets/image/mouse2.jpg",
      price: 8.99,
      title:
          "The mouse brings excellent power-saving capabilities to the forefront with a multi-stage power saving mode that will ensure you have power when your game depends on it. An excellent ergonomic design underscores the sturdy construction and virtually noiseless mouse clicks."),
  Item(
      name: "Gaming Mouse Pad P1",
      imagePath: "assets/image/pad1.jpeg",
      price: 4.99,
      title:
          "New Extended Gaming Mouse Pad Large Size Desk Keyboard Mat Soft Thick"),
  Item(
      name: "Gaming Mouse Pad P2",
      imagePath: "assets/image/pad2.jpg",
      price: 2.99,
      title:
          "New Extended Gaming Mouse Pad Large Size Desk Keyboard Mat Soft Thick"),
  Item(
      name: "wireless headphone HD-560 - Black",
      imagePath: "assets/image/headphones1.jpeg",
      price: 13.99,
      title:
          "Sennheiser Consumer Audio HD 560 S Over-The-Ear Audiophile Headphones - Neutral Frequency Response, E.A.R. Technology for Wide Sound Field, Open-Back Earcups, Detachable Cable, (Black) (HD 560S)"),
  Item(
      name: "wireless headphone HD-563 - Blue",
      imagePath: "assets/image/headphones2.jpeg",
      price: 13.99,
      title:
          "High Quality Noise Canceling Headphone Blue Color Headsets For Computer With Microphone"),
];
