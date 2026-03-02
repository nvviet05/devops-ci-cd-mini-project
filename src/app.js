const express = require("express");

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;
const APP_VERSION = process.env.APP_VERSION || "1.0.0";

app.get("/health", (req, res) => {
    res.status(200).json({
        status: "ok",
        service: "devops-ci-cd-mini-project",
        timestamp: new Date().toISOString()
    });
});

app.get("/api/version", (req, res) => {
    res.status(200).json({
        version: APP_VERSION
    });
});

app.post("/api/echo", (req, res) => {
    res.status(200).json({
        received: req.body
    });
});

if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
    });
}

module.exports = app;
