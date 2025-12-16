# 1. Chọn "nền móng" (Base Image)
# Dùng bản node:18-alpine vì nó siêu nhẹ (chỉ khoảng 40MB), chạy nhanh.
FROM node:18-alpine

# 2. Tạo thư mục làm việc bên trong Container
# Tức là mọi file code sẽ được bỏ vào thư mục /app này
WORKDIR /app

# 3. Copy file quản lý thư viện vào trước
# Tại sao copy cái này riêng? Để tận dụng cơ chế Cache của Docker -> Build nhanh hơn
COPY package*.json ./

# 4. Cài đặt các thư viện (như express...)
RUN npm install

# 5. Copy toàn bộ code còn lại từ máy bạn vào container
COPY . .

# 6. Mở cổng kết nối (Port)
# Phải trùng với port trong file index.js (3000)
EXPOSE 3000

# 7. Câu lệnh chạy ứng dụng khi container khởi động
CMD ["node", "index.js"]