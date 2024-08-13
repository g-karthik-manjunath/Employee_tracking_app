const express = require('express');
const multer = require('multer'); // Add this line
const { login, refreshToken, updateProfile, getUserDetails, uploadProfileImage, removeProfileImage } = require('../controllers/userController');
const authMiddleware = require('../middleware/authMiddleware');
const router = express.Router();

// Multer configuration for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/'); // Directory where the images will be stored
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname); // Ensure unique file names
  }
});

const upload = multer({ storage: storage });

router.post('/login', login);
router.put('/profile', authMiddleware.verifyToken, updateProfile);
router.get('/user-details', authMiddleware.verifyToken, getUserDetails);
router.post('/upload-profile-image', authMiddleware.verifyToken, upload.single('profileImage'), uploadProfileImage); // Add this line
router.delete('/remove-profile-image', authMiddleware.verifyToken, removeProfileImage); // Add this line
router.post('/refresh-token', refreshToken);

module.exports = router;
