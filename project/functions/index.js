const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

const functions = require("firebase-functions");
const cors = require("cors");
const { OpenAI } = require("langchain/llms/openai");
const { ConversationalRetrievalQAChain } = require("langchain/chains");
const { HNSWLib } = require("langchain/vectorstores/hnswlib");
const { OpenAIEmbeddings } = require("langchain/embeddings/openai");
const { RecursiveCharacterTextSplitter } = require("langchain/text_splitter");
const { BufferMemory } = require("langchain/memory");
const fs = require("fs");

exports.run = functions.https.onRequest(async (req, res) => {
  // Enable CORS
  cors()(req, res, async () => {
    try {
      /* Initialize the LLM to use to answer the question */
      const model = new OpenAI({});
      /* Load in the file we want to do question answering over */
      const text = fs.readFileSync("state_of_the_union.txt", "utf8");
      /* Split the text into chunks */
      const textSplitter = new RecursiveCharacterTextSplitter({ chunkSize: 1000 });
      const docs = await textSplitter.createDocuments([text]);
      /* Create the vectorstore */
      const vectorStore = await HNSWLib.fromDocuments(docs, new OpenAIEmbeddings());
      /* Create the chain */
      const chain = ConversationalRetrievalQAChain.fromLLM(
        model,
        vectorStore.asRetriever(),
        {
          memory: new BufferMemory({
            memoryKey: "chat_history", // Must be set to "chat_history"
          }),
        }
      );
      /* Ask it a question */
      const question = "What did the president say about Justice Breyer?";
      const res = await chain.call({ question });
      console.log(res);
      /* Ask it a follow-up question */
      const followUpRes = await chain.call({
        question: "Was that nice?",
      });
      console.log(followUpRes);

      // Send response
      res.status(200).send("Success");
    } catch (error) {
      console.error(error);
      // Send error response
      res.status(500).send("Error");
    }
  });
});


