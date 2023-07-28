/* eslint-disable linebreak-style */
const mongoose = require('mongoose');

const attendanceSchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  event: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Event',
    required: true,
  },
  timestamp: {
    type: Date,
    default: Date.now,
  },
  // You can add more fields as per your requirements (e.g., check-in time, check-out time, etc.)
});

const Attendance = mongoose.model('Attendance', attendanceSchema);

module.exports = Attendance;
