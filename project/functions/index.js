const { onRequest } = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const cors = require("cors")({ origin: true });

// Sample data for answering questions
const data = {
  question1: "Answer to question 1",
  question2: "Answer to question 2",
  // Add more questions and answers as needed
};

// Function to answer questions
exports.answerQuestion = functions.https.onRequest((request, response) => {
  cors(request, response, () => {
    // Parse the question from the request body
    const { question } = request.body;

    // Check if the question exists in the data
    if (data.hasOwnProperty(question)) {
      // If the question exists, return the corresponding answer
      response.json({ answer: data[question] });
    } else {
      // If the question doesn't exist, return an error message
      response.status(404).json({ error: "Question not found" });
    }
  });
});
