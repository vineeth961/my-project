import express from "express";
const app = express();

app.get("/", (req, res) => {
  res.send("Backend API is working!");
});

app.listen(3000, () => console.log("Backend running on port 3000"));

