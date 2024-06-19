

const EmergencyContact = require('../models/EmergencyContact');

exports.updateEmergencyContact = async (req, res) => {
    const contactId = req.params.id; 
    const updatedContact = req.body; 

    try {
        const result = await EmergencyContact.updateEmergencyContact(contactId, updatedContact);
        if (result === 1) {
            res.status(200).json({ message: 'Emergency contact updated successfully' });
        } else {
            res.status(404).json({ error: 'Emergency contact not found or update failed' });
        }
    } catch (error) {
        console.error('Error updating emergency contact:', error);
        res.status(500).json({ error: 'Error updating emergency contact' });
    }
};

exports.deleteEmergencyContact = async (req, res) => {
    const contactId = req.params.id; 

    try {
        const result = await EmergencyContact.deleteEmergencyContact(contactId);
        if (result === 1) {
            res.status(200).json({ message: 'Emergency contact deleted successfully' });
        } else {
            res.status(404).json({ error: 'Emergency contact not found or delete failed' });
        }
    } catch (error) {
        console.error('Error deleting emergency contact:', error);
        res.status(500).json({ error: 'Error deleting emergency contact' });
    }
};
