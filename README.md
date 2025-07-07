# Flutter SQLite Joins Demo

A Flutter application demonstrating different types of SQL joins using SQLite database with practical examples of Teachers and Department tables.

## Features

- **Multiple Join Types**: INNER, LEFT, and CROSS joins
- **Real-time Data Display**: Interactive dropdown to switch between join types
- **SQLite Integration**: Local database with sample data
- **Clean UI**: Modern Material Design interface
- **Database Management**: Singleton pattern for database operations

## Screenshots

| INNER JOIN | LEFT JOIN | CROSS JOIN |
|------------|-----------|------------|
| Shows only matching records | Shows all teachers with departments | Shows all combinations |

## Database Schema

### Teachers Table
```sql
CREATE TABLE Teachers (
  id INTEGER PRIMARY KEY,
  name TEXT,
  salary REAL
)
```

### Department Table
```sql
CREATE TABLE Department (
  emp_id INTEGER,
  dept TEXT
)
```

### Sample Data
- **Teachers**: Alice (40000), Bob (45000), Charlie (42000)
- **Departments**: Math (emp_id: 1), Science (emp_id: 2), English (emp_id: 4)

## Join Types Explained

### INNER JOIN
- Returns only records that have matching values in both tables
- Result: Shows teachers who have assigned departments

### LEFT JOIN
- Returns all records from the left table (Teachers) and matched records from the right table (Department)
- Result: Shows all teachers, with NULL for those without departments

### CROSS JOIN
- Returns the Cartesian product of both tables
- Result: Shows every possible combination of teachers and departments

## Project Structure

```
lib/
├── main.dart           # Main app entry point and UI
├── db_helper.dart      # Database helper class
└── README.md          # This file
```

## Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path: ^1.8.3
```

## Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-sqlite-joins
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Code Architecture

### DBHelper Class
- **Singleton Pattern**: Ensures single database instance
- **Database Initialization**: Creates tables and inserts sample data
- **Query Methods**: Handles different join operations

### Key Methods

#### `fetchJoinData(String joinType)`
Executes SQL queries based on the selected join type:
- **INNER**: `SELECT t.name, t.salary, d.dept FROM Teachers t INNER JOIN Department d ON t.id = d.emp_id`
- **LEFT**: `SELECT t.name, t.salary, d.dept FROM Teachers t LEFT JOIN Department d ON t.id = d.emp_id`
- **CROSS**: `SELECT t.name, t.salary, d.dept FROM Teachers t CROSS JOIN Department d`

### UI Components
- **Dropdown**: Select join type
- **ListView**: Display query results
- **Material Design**: Clean and responsive interface

## Expected Results

### INNER JOIN
```
Alice | Math | 40000
Bob | Science | 45000
```

### LEFT JOIN
```
Alice | Math | 40000
Bob | Science | 45000
Charlie | NULL | 42000
```

### CROSS JOIN
```
Alice | Math | 40000
Alice | Science | 40000
Alice | English | 40000
Bob | Math | 45000
Bob | Science | 45000
Bob | English | 45000
Charlie | Math | 42000
Charlie | Science | 42000
Charlie | English | 42000
```

## Key Learning Points

1. **SQLite Integration**: How to set up and use SQLite in Flutter
2. **Database Design**: Proper table relationships and foreign keys
3. **SQL Joins**: Understanding different join types with practical examples
4. **State Management**: Using StatefulWidget for dynamic data updates
5. **Singleton Pattern**: Efficient database connection management

## Troubleshooting

### Common Issues

1. **Database not created**: Ensure sqflite dependency is properly added
2. **Empty results**: Check if sample data is being inserted correctly
3. **Join errors**: Verify table and column names in SQL queries

### Debug Tips
- Use `print()` statements to check fetched data
- Verify database path using `getDatabasesPath()`
- Test queries in a SQLite browser for validation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Additional Resources

- [Flutter SQLite Tutorial](https://flutter.dev/docs/cookbook/persistence/sqlite)
- [SQL JOIN Types](https://www.w3schools.com/sql/sql_join.asp)
- [Flutter State Management](https://flutter.dev/docs/development/data-and-backend/state-mgmt)

## Author

Created as a learning project for understanding SQL joins in Flutter applications.

---

⭐ If you found this helpful, please give it a star!
