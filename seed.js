const bcrypt = require('bcryptjs');
const mysql = require('mysql2');

// Database connection configuration
const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'password@2022',
    database: 'employee_tracking',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Create a promise-based pool
const promisePool = pool.promise();

// Hash the password
const password = 'yourpassword';
const hashedPassword = bcrypt.hashSync(password, 10);

async function seedDatabase() {
    try {
        const [results] = await promisePool.query(
            'INSERT INTO users (name, email, password, phone) VALUES (?, ?, ?, ?)',
            ['karthik', 'karthik@gmail.com', hashedPassword, '6360350343']
        );
        console.log('User inserted with ID:', results.insertId);
    } catch (error) {
        console.error('Error inserting user:', error);
    } finally {
        pool.end();
    }
}

// Run the seed function
seedDatabase();
