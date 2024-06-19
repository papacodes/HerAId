

const pool = require('../config/db');

class User {
    static async getAllUsers() {
        try {
            const [rows] = await pool.query('SELECT * FROM users');
            return rows;
        } catch (error) {
            throw error;
        }
    }

    static async getUserById(id) {
        try {
            const [rows] = await pool.query('SELECT * FROM users WHERE id = ?', [id]);
            return rows[0];
        } catch (error) {
            throw error;
        }
    }

    static async createUser(newUser) {
        try {
            const [result] = await pool.query('INSERT INTO users SET ?', newUser);
            return result.insertId;
        } catch (error) {
            throw error;
        }
    }

    static async updateUser(id, updatedUser) {
        try {
            const [result] = await pool.query('UPDATE users SET ? WHERE id = ?', [updatedUser, id]);
            return result.affectedRows; // Number of affected rows (should be 1 if update was successful)
        } catch (error) {
            throw error;
        }
    }

    static async deleteUser(id) {
        try {
            const [result] = await pool.query('DELETE FROM users WHERE id = ?', [id]);
            return result.affectedRows; // Number of affected rows (should be 1 if delete was successful)
        } catch (error) {
            throw error;
        }
    }
}

module.exports = User;
