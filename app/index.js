const express = require('express');
const os = require('os');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    // Lấy tên máy (Hostname) để biết code đang chạy trên container nào
    const serverName = os.hostname();
    res.send(`
        <h1>Xin chào thầy và các bạn!</h1>
        <p>Viet XINCHAO LAMNGOO</p>
        <p>Code đang chạy trên Server: <b>${serverName}</b></p>
        <p>Phiên bản: v1.0</p>
    `);
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});
