enum DietaryPreference {
  vegan('Vegan'),
  vegetarian('Vegetarian'),
  pescatarian('Pescatarian'),
  keto('Keto'),
  paleo('Paleo'),
  lowCarb('Low Carb'),
  dairyFree('Dairy-Free'),
  glutenFree('Gluten-Free'),
  halal('Halal'),
  kosher('Kosher');

  final String label;
  const DietaryPreference(this.label);
}

enum MajorAllergen {
  milkDairy('Milk / Dairy'),
  eggs('Eggs'),
  wheat('Wheat'),
  gluten('Gluten'),
  soy('Soy'),
  peanuts('Peanuts'),
  treeNuts('Tree Nuts'),
  fish('Fish'),
  shellfish('Shellfish'),
  sesame('Sesame'),
  corn('Corn');

  final String label;
  const MajorAllergen(this.label);
}
