/* eslint-disable linebreak-style */
const Event = require('../models/Event');

// GET /create-event
function getCreateEvent(req, res) {
  return res.render('create-event', { title: 'Create Event' });
}

// POST /create-event
async function createEvent(req, res) {
  const { eventName, date, location } = req.body;
  const newEvent = new Event({ eventName, date, location });
  try {
    await newEvent.save();
    req.flash('success', { msg: 'Event created successfully!' });
    return res.redirect('/events');
  } catch (error) {
    console.log(error);
    req.flash('errors', { msg: 'Error creating event!' });
    return res.redirect('/events');
  }
}

// GET /events
async function getEvents(req, res) {
  try {
    const events = await Event.find();
    return res.render('events', { title: 'Events', events });
  } catch (error) {
    console.log(error);
    req.flash('errors', { msg: 'Error fetching events!' });
    return res.redirect('/events');
  }
}

// GET /events/:id
async function getEvent(req, res) {
  try {
    const event = await Event.findById(req.params.id);
    res.render('event', {
      title: 'Event',
      event,
      attendance: res.locals.attendanceData,
      qrCode: res.locals.qrCode
    });
  } catch (error) {
    console.log(error);
    req.flash('errors', { msg: 'Error fetching event!' });
    return res.redirect('/events');
  }
}

// GET /events/:id/edit
async function getEditEvent(req, res) {
  try {
    const event = await Event.findById(req.params.id);
    return res.render('edit-event', { title: 'Edit Event', event });
  } catch (error) {
    console.log(error);
    req.flash('errors', { msg: 'Error fetching event!' });
    return res.redirect('/events');
  }
}

// POST /events/:id/edit
async function editEvent(req, res) {
  try {
    const event = await Event.findById(req.params.id);
    event.name = req.body.eventName;
    event.date = req.body.date;
    event.location = req.body.location;
    await event.save();
    req.flash('success', { msg: 'Event updated successfully!' });
    return res.redirect(`/events/${req.params.id}`);
  } catch (error) {
    console.log(error);
    req.flash('errors', { msg: 'Error updating event!' });
    return res.redirect(`/events/${req.params.id}`);
  }
}

// POST /events/:id/delete
async function deleteEvent(req, res) {
  try {
    await Event.findByIdAndDelete(req.params.id);
    req.flash('success', { msg: 'Event deleted successfully!' });
    return res.redirect('/events');
  } catch (error) {
    console.log(error);
    req.flash('errors', 'Error deleting event!');
    return res.redirect(`/events/${req.params.id}`);
  }
}

// Generate a QR code for the event that contains http://localhost:8080/events/${req.params.id}/add-attendance
function generateQRCode(req, res, next) {
  const qrCode = `https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=http://localhost:8080/events/${req.params.id}/add-attendance`;
  res.locals.qrCode = qrCode;
  next();
}

module.exports = {
  getCreateEvent,
  createEvent,
  getEvents,
  getEvent,
  generateQRCode,
  getEditEvent,
  editEvent,
  deleteEvent,
};
