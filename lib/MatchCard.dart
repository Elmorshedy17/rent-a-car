class MatchCard {
  String name;
  String available;
  String imgSrc;
  double price;
  int poeple;
  double marginTop = 0;
  String desc;

  MatchCard(String name, String available, String imgSrc, double price,
      int poeple, double marginTop, String desc) {
    this.name = name;
    this.available = available;
    this.imgSrc = imgSrc;
    this.price = price;
    this.poeple = poeple;
    this.marginTop = marginTop;
    this.desc = desc;
  }
}
