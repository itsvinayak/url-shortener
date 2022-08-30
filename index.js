const express = require('express');
const uuid = require('uuid');
const redis = require('redis');
const VALID_URL_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/;

const app = express();
app.use(express.urlencoded({ extended: true }));
app.use(express.json());


const client = redis.createClient({
  url: 'redis://redis:6379'
});

client.on('connect', () => console.log('Redis client connected'));
client.on('error', (err) => console.log('Redis error: ', err));
client.connect();


app.get('/', (req, res) => {
  res.status(200).send(`
    <center>
      <h1>URL shortener example</h1>
      <form action="/shorten" method="POST">
        <input type="text" name="url" placeholder="Enter URL to shorten">
        <button type="submit">Shorten</button>
      </form>
    </center>
  `);
});

app.post('/shorten', async (req, res) => {
  const { url } = req.body;
  const id = uuid.v4();
  let redisRes = await client.set(id, url);
  if (!VALID_URL_REGEX.test(url)) {
    return res.status(400).send('Invalid URL');
  } else if (redisRes !== 'OK') {
    return res.status(500).send('<center><h1>Error saving URL</h1></center>');
  }
  return res.status(200).send(`
    <center>
      <h1>URL shortener example</h1>
      <p>Your shortened URL is: <a href="/url/${id}">/${id}</a></p>
      <p><a>Full Url : ${req.protocol + '://' + req.get('host') + '/url/' + id}</a></p>
    </center>
  `);
});

app.get('/url/:id', async (req, res) => {
  const { id } = req.params;
  let redisRes = await client.get(id);
  if (!redisRes) {
    return res.status(404).send('<center><h1>URL not found</h1></center>');
  }
  return res.redirect(redisRes);
});

app.listen(8080, () => console.log('Server started on port 8080'));