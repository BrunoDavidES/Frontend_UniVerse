const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const nodemailer = require("nodemailer");
const cors = require("cors")({ origin: true });

// Gmail configuration
const gmailEmail = "capi.crew@gmail.com";
const gmailPassword = "pe2doManelExplodiu";

// Create a transporter
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: gmailEmail,
    pass: gmailPassword,
  },
});

// Function to send an email
exports.sendEmail = functions.https.onRequest((request, response) => {
    cors(request, response, () => {
    // Email details (subject, recipient, message)
    const subject = "Test Email";
    const recipient = "g.cerveira@campus.fct.unl.pt";
    const message = "This is a test email sent from Firebase Cloud Functions.";

    // Email options
    const mailOptions = {
    from: gmailEmail,
    to: recipient,
    subject: subject,
    text: message,
    };

    // Send the email
    transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      console.error("Error sending email:", error);
      response.status(500).send("Error sending email");
    } else {
      console.log("Email sent successfully:", info.response);
      response.send("Email sent successfully");
    }
    });
  });
});

