import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('byaz_track.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS loans (
        id TEXT PRIMARY KEY,
        transaction_type TEXT,
        principal_amount INTEGER,
        start_date TEXT,
        interest_type TEXT,
        rate_value REAL,
        party_name TEXT,
        notes TEXT,
        created_at TEXT,
        updated_at TEXT,
        sync_status TEXT,
        loan_status TEXT,
        last_collected_date TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS payments (
        id TEXT PRIMARY KEY,
        loan_id TEXT,
        amount REAL,
        payment_date TEXT,
        created_at TEXT,
        FOREIGN KEY (loan_id) REFERENCES loans (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        "ALTER TABLE loans ADD COLUMN loan_status TEXT DEFAULT 'active'",
      );
      await db.execute("ALTER TABLE loans ADD COLUMN last_collected_date TEXT");
    }
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS payments (
          id TEXT PRIMARY KEY,
          loan_id TEXT,
          amount REAL,
          payment_date TEXT,
          created_at TEXT,
          FOREIGN KEY (loan_id) REFERENCES loans (id) ON DELETE CASCADE
        )
      ''');
    }
  }

  Future<int> deleteLoan(String loanId) async {
    final db = await instance.database;
    return await db.delete('loans', where: 'id = ?', whereArgs: [loanId]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }

  Future<int> settleLoan(String loanId) async {
    final db = await instance.database;
    return await db.update(
      'loans',
      {'loan_status': 'settled'},
      where: 'id = ?',
      whereArgs: [loanId],
    );
  }

  // --- Payment Methods ---

  Future<int> insertPayment(Map<String, dynamic> payment) async {
    final db = await instance.database;
    return await db.insert('payments', payment);
  }

  Future<List<Map<String, dynamic>>> getPaymentsForLoan(String loanId) async {
    final db = await instance.database;
    return await db.query(
      'payments',
      where: 'loan_id = ?',
      whereArgs: [loanId],
      orderBy: 'payment_date DESC',
    );
  }
}
