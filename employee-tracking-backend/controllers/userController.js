const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const pool = require('../config/db'); // Adjust the path to your database connection
const path = require('path');
const fs = require('fs');
const User = require('../models/userModel'); // Ensure this is your User model

// Login function
exports.login = async (req, res) => {
    const { email, password } = req.body;

    try {
        // Check if user exists
        const [rows] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
        if (rows.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

        // Check password
        const user = rows[0];
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }

            // Generate token
            const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

        // Send response
        res.json({
            token: token,
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                phone: user.phone,
                password: user.password
            }
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

// Update profile function
exports.updateProfile = async (req, res) => {
    const userId = req.userId;
    const { name, phone, password } = req.body;

    try {
        // Hash the password if provided
        const hashedPassword = password ? await bcrypt.hash(password, 10) : null;

        // Update profile data
        const [result] = await pool.query(
            'UPDATE users SET name = ?, phone = ?, password = COALESCE(?, password) WHERE id = ?',
            [name, phone, hashedPassword, userId]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.json({ message: 'Profile updated successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
};

// Fetch user details function
exports.getUserDetails = async (req, res) => {
    const userId = req.userId;
    try {
      const [rows] = await pool.query('SELECT id, name, email, phone, password FROM users WHERE id = ?', [userId]);
      if (rows.length === 0) {
        return res.status(404).json({ message: 'User not found' });
      }
      res.json(rows[0]);
    } catch (error) {
      res.status(500).json({ message: 'Server error' });
    }

    // Upload profile image
exports.uploadProfileImage = async (req, res) => {
    try {
      const userId = req.userId;
      const filePath = req.file.path;
      const user = await User.findById(userId);
      
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      // Update the user's profile image path
      user.profileImagePath = filePath;
      await user.save();
  
      res.status(200).json({ message: 'Profile image uploaded successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Error uploading profile image', error });
    }
  };
  
  // Remove profile image
  exports.removeProfileImage = async (req, res) => {
    try {
      const userId = req.userId;
      const user = await User.findById(userId);
  
      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }
  
      // Delete the file from the server
      if (user.profileImagePath) {
        fs.unlinkSync(user.profileImagePath);
      }
  
      // Update the user's profile image path
      user.profileImagePath = null;
      await user.save();
  
      res.status(200).json({ message: 'Profile image removed successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Error removing profile image', error });
    }
  }
};

  