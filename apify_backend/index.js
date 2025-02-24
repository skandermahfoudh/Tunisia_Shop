import express from 'express';
import axios from 'axios';
import dotenv from 'dotenv';
import cron from 'node-cron';
import cors from 'cors';

dotenv.config();

const app = express();
app.use(cors());

let cachedData = [];

// Function to fetch data from Apify
const fetchApifyData = async () => {
  try {
    const url = `https://api.apify.com/v2/datasets/${process.env.DATASET_ID}/items?token=${process.env.APIFY_TOKEN}&format=json`;
    const response = await axios.get(url);
    cachedData = response.data;
    console.log('✅ Data fetched from Apify.');
  } catch (error) {
    console.error('❌ Failed to fetch data from Apify:', error.message);
  }
};

// Schedule task to run once a day at midnight
cron.schedule('0 0 * * *', () => {
  console.log('🕛 Running scheduled fetch...');
  fetchApifyData();
});

// Initial fetch on server start
fetchApifyData();

// Endpoint to get data
app.get('/data', (req, res) => {
  res.json(cachedData);
});

// Start server
const PORT = process.env.PORT || 3000;
app.listen(3000, '0.0.0.0', () => {
    console.log('Server running on port 3000');
  });
  
