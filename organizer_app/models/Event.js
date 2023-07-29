/* eslint-disable linebreak-style */
const mongoose = require('mongoose');

const eventSchema = new mongoose.Schema({
  eventName: {
    type: String,
    required: true,
  },
  date: {
    type: Date,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
  // You can add more fields as per your requirements (e.g., description, organizer, etc.)
});

const Event = mongoose.model('Event', eventSchema);

module.exports = Event;
