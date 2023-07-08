const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

exports.sendEmail = functions.https.onCall(async (data, context) => {
  const { recipient, subject, body } = data;

  const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
      user: "capi.crew@gmail.com", // Replace with your Gmail email address
      pass: "pe2doManelExplodiu", // Replace with your Gmail password or an app-specific password
    },
  });

  const mailOptions = {
    from: "capi.crew@gmail.com", // Replace with your Gmail email address
    to: recipient,
    subject: subject,
    text: body,
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log("Email sent successfully");
    return { success: true };
  } catch (error) {
    console.error("Error sending email:", error);
    throw new functions.https.HttpsError("internal", "Email sending failed");
  }
});

