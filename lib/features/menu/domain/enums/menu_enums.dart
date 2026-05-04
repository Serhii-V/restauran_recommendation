enum MenuCategory {
  all('All'),
  snacks('Snacks'),
  mainCourse('Main Course'),
  bowls('Bowls'),
  drinks('Drinks'),
  desserts('Desserts');

  final String label;
  const MenuCategory(this.label);
}

enum SpiceLevel { none, mild, medium, hot }

enum PortionSize { snack, light, regular, filling, feast }

enum MealStyle { classic, adventurous }

enum PrepTime { quick, normal, long }

enum HealthGoal { highProtein, lowSugar, balanced, tasty }
