

const pool = require('../config/db');

class EmergencyContact {
    static async getAllEmergencyContacts() {
        try {
            const [rows] = await pool.query('SELECT * FROM emergency_contacts');
            return rows;
        } catch (error) {
            throw error;
        }
    }

    static async getEmergencyContactById(id) {
        try {
            const [rows] = await pool.query('SELECT * FROM emergency_contacts WHERE id = ?', [id]);
            return rows[0];
        } catch (error) {
            throw error;
        }
    }

    static async createEmergencyContact(newContact) {
        try {
            const [result] = await pool.query('INSERT INTO emergency_contacts SET ?', newContact);
            return result.insertId;
        } catch (error) {
            throw error;
        }
    }

    static async updateEmergencyContact(id, updatedContact) {
        try {
            const [result] = await pool.query('UPDATE emergency_contacts SET ? WHERE id = ?', [updatedContact, id]);
            return result.affectedRows; // Number of affected rows (should be 1 if update was successful)
        } catch (error) {
            throw error;
        }
    }

    static async deleteEmergencyContact(id) {
        try {
            const [result] = await pool.query('DELETE FROM emergency_contacts WHERE id = ?', [id]);
            return result.affectedRows; // Number of affected rows (should be 1 if delete was successful)
        } catch (error) {
            throw error;
        }
    }
}

module.exports = EmergencyContact;
