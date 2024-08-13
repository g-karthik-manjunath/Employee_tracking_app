const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const dotenv = require('dotenv');
const userRoutes = require('./routes/userRoutes');

dotenv.config();

const app = express();

// Configure CORS to allow requests from specific origins
const corsOptions = {
  origin: ['http://localhost:5000', 'http://192.168.0.122'], // Add your mobile device's IP and any other allowed origins
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

// Apply CORS middleware with specified options
app.use(cors(corsOptions));

app.use(bodyParser.json());

// Define your routes
app.use('/api', userRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
