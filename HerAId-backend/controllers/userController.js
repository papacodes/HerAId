

const User = require('../models/User');

exports.updateUser = async (req, res) => {
    const userId = req.params.id; 
    const updatedUser = req.body; 

    try {
        const result = await User.updateUser(userId, updatedUser);
        if (result === 1) {
            res.status(200).json({ message: 'User updated successfully' });
        } else {
            res.status(404).json({ error: 'User not found or update failed' });
        }
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ error: 'Error updating user' });
    }
};

exports.deleteUser = async (req, res) => {
    const userId = req.params.id; 

    try {
        const result = await User.deleteUser(userId);
        if (result === 1) {
            res.status(200).json({ message: 'User deleted successfully' });
        } else {
            res.status(404).json({ error: 'User not found or delete failed' });
        }
    } catch (error) {
        console.error('Error deleting user:', error);
        res.status(500).json({ error: 'Error deleting user' });
    }
};
