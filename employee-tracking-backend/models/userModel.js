const mysql = require('mysql2/promise');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: 'password@2022',
    database: 'employee_tracking',
});

const findUserByEmail = async (email) => {
    const connection = await pool.getConnection();
    const [rows] = await connection.execute('SELECT * FROM users WHERE email = ?', [email]);
    connection.release();
    return rows[0];
};

const findUserById = async (id) => {
    const connection = await pool.getConnection();
    const [rows] = await connection.execute('SELECT * FROM users WHERE id = ?', [id]);
    connection.release();
    return rows[0];
};

const updateUserProfile = async ({ id, name, phone, password }) => {
    const connection = await pool.getConnection();
    let query = 'UPDATE users SET name = ?, phone = ?';
    let values = [name, phone];

    if (password) {
        const hashedPassword = await bcrypt.hash(password, 12);
        query += ', password = ?';
        values.push(hashedPassword);
    }

    query += ' WHERE id = ?';
    values.push(id);

    await connection.execute(query, values);
    connection.release();
};

module.exports = {
    findUserByEmail,
    findUserById,
    updateUserProfile
};
