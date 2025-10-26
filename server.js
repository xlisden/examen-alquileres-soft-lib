
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 3000;

const edificiosRoutes = require('./routes/edificiosRoutes');

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/edificios', edificiosRoutes);

app.get('/', (req, res) => {
    res.json({
        mensaje:"API"
    });
});

app.listen(PORT, () => {
    console.log('http://localhost:' + PORT);    
});
