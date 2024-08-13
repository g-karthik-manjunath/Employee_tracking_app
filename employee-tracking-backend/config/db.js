const mysql = require('mysql2');
const dotenv = require('dotenv');

// Load environment variables from .env file
dotenv.config();

// Create a connection pool
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

// Test the connection
promisePool.getConnection()
  .then(connection => {
    console.log('Database connected successfully');
    connection.release(); // Release the connection back to the pool
  })
  .catch(err => {
    console.error('Error connecting to the database:', err);
  });

module.exports = promisePool;
