/* eslint-disable linebreak-style */
/* eslint-disable no-restricted-syntax */
const Attendance = require('../models/Attendance');
const Event = require('../models/Event');

// POST /add-attendance
async function addAttendance(req, res) {
  try {
    const user = req.user._id;
    const event = req.params.id;
    if (event.status === 'completed') {
      return res.status(204).json({ success: true, message: 'Event completed!' });
    }
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
    const eventId = req.params.id;
    const event = await Event.findById(eventId);
    const attendance = await Attendance.findOne({ user, event });
    if (event.status === 'completed') {
      return res.status(204).json({ success: true, message: 'Event is closed!' });
    }
    if (attendance) {
      return res.status(202).json({ success: true, message: 'Already registered!' });
    }
    const newAttendance = new Attendance({ user, event });
    await newAttendance.save();
    return res.status(200).json({ success: true, message: 'Attendance added successfully!' });
  } catch (error) {
    return res.status(500).json({ success: false, message: `Error adding attendance! ${error}` });
  }
}

// Middleware to get attendance data and render the Pug template
async function getEventAttendance(req, res, next) {
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

// Retriev the attendance data for a particular user
async function getAttendanceForUser(req, res) {
  try {
    const attendanceData = await Attendance.find({ user: req.params.id }).populate('event');
    return res.status(200).json({ success: true, attendanceData });
  } catch (err) {
    console.error(err);
    return res.status(400).json({ success: false, err });
  }
}

module.exports = {
  addAttendance,
  getEventAttendance,
  addAttendanceMobile,
  getAttendanceForUser,
};
