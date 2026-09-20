const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.json({
    status: 'online',
    message: 'Git Flow Enterprise POC API is live!',
    version: process.env.APP_VERSION || '1.0.0',
    environment: process.env.NODE_ENV || 'development'
  });
});

app.get('/healthz', (req, res) => res.status(200).send('OK'));
app.get('/ready', (req, res) => res.status(200).send('READY'));

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
