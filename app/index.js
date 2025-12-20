const express = require('express');
const os = require('os');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    const serverName = os.hostname();

    res.send(`
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>DevOps Demo</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(135deg, #1d2671, #c33764);
            color: #ffffff;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: rgba(0, 0, 0, 0.35);
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.4);
            max-width: 500px;
            text-align: center;
        }

        h1 {
            margin-bottom: 10px;
            font-size: 28px;
        }

        .subtitle {
            font-size: 16px;
            opacity: 0.9;
            margin-bottom: 25px;
        }

        .info {
            text-align: left;
            margin-top: 20px;
            font-size: 15px;
        }

        .info p {
            margin: 8px 0;
        }

        .badge {
            display: inline-block;
            padding: 4px 10px;
            background-color: #00d4ff;
            color: #000;
            border-radius: 6px;
            font-weight: bold;
            font-size: 13px;
        }

        footer {
            margin-top: 25px;
            font-size: 12px;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>🚀 DevOps & Linux Demo</h1>
        <div class="subtitle">
            CI/CD • Docker • Monitoring
        </div>

        <div class="info">
            <p><b>👤 Sinh viên:</b> Viet, Lam, Khai, Tu</p>
            <p><b>🖥 Server / Container:</b> <span class="badge">${serverName}</span></p>
            <p><b>📦 Phiên bản:</b> v1.8</p>
            <p><b>⚙️ Triển khai:</b> Jenkins + Docker</p>
        </div>

        <footer>
            Hệ thống mô phỏng môi trường Production (Distributed Architecture)
        </footer>
    </div>
</body>
</html>
    `);
});

app.listen(port, () => {
    console.log(`App running on port ${port}`);
});

