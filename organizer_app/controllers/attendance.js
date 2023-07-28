/* eslint-disable linebreak-style */
/* eslint-disable no-restricted-syntax */
const Attendance = require('../models/Attendance');

// POST /add-attendance
async function addAttendance(req, res) {
  try {
    const user = req.user._id;
    const event = req.params.id;
    const newAttendance = new Attendance({ user, event });
    await newAttendance.save();
    return res.status(200).json({ success: true, message: 'Attendance added successfully!' });
  } catch (error) {
    return res.status(500).json({ success: false, message: `Error adding attendance! ${error}` });
  }
}

// POST /add-attendance
async function addAttendanceMobile(req, res) {
  try {
    const user = req.params.uid;
    const event = req.params.id;
    const newAttendance = new Attendance({ user, event });
    await newAttendance.save();
    return res.status(200).json({ success: true, message: 'Attendance added successfully!' });
  } catch (error) {
    return res.status(500).json({ success: false, message: `Error adding attendance! ${error}` });
  }
}

// Middleware to get attendance data and render the Pug template
async function getAttendance(req, res, next) {
  try {
    // Fetch attendance data from the MongoDB using the Mongoose model
    const attendanceData = await Attendance.find({ event: req.params.id }).populate('user');

    // Render the Pug template with the attendance data
    res.locals.attendanceData = attendanceData;
    next();
  } catch (err) {
    console.error(err);
    res.status(500).send('Internal Server Error');
  }
}

module.exports = {
  addAttendance,
  getAttendance,
  addAttendanceMobile,
};
