# <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Cloud.png" alt="Cloud" width="40" height="40" /> ZUNRDP CLOUD INFRASTRUCTURE

<p align="center">
  <img src="https://img.shields.io/badge/Version-2.0.0-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Security-Firebase_Encrypted-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/OS-Windows_Server_2022-0078D4?style=for-the-badge&logo=windows" />
</p>

---

## 📖 GIỚI THIỆU
**ZunRDP Cloud** là giải pháp quản trị máy ảo (VPS) tự động hóa tối ưu trên nền tảng GitHub Actions. Hệ thống cho phép người dùng đăng ký, quản lý và sử dụng Windows VM với quyền **Administrator** cao nhất thông qua giao diện Web Panel hiện đại.

📍 **Truy cập ngay:** [https://vpsf0605-dev.github.io/zunrdp-admin/](https://vpsf0605-dev.github.io/zunrdp-admin/)

---

## 🛠️ TÍNH NĂNG ĐẶC SẮC
* 👑 **Full Admin Access:** Máy ảo được kích hoạt sẵn tài khoản `Administrator`.
* 🔐 **Key-Based Auth:** Hệ thống xác thực thông minh dựa trên mã Key nội bộ.
* 📈 **Live Monitoring:** Theo dõi hiệu năng CPU, RAM và trạng thái Online/Offline theo thời gian thực.
* ☁️ **High Speed:** Hạ tầng băng thông cao từ GitHub Actions, hỗ trợ Tailscale Network.

---

## 🔑 HƯỚNG DẪN KẾT NỐI (RDP)

Sau khi máy ảo chuyển sang trạng thái **Online** trên Panel, hãy sử dụng các thông tin sau để kết nối:



| Hạng mục | Thông tin chi tiết |
| :--- | :--- |
| **User (Tài khoản)** | `Administrator` |
| **Pass (Mật khẩu)** | `ZunRDP@123456` |
| **Port (Cổng)** | `3389` |
| **IP Address** | *Lấy từ mục IP trên Web Panel* |

---

## 🚀 QUY TRÌNH VẬN HÀNH



### 1️⃣ Đối với Thành viên
* **Đăng ký:** Tạo tài khoản tại trang login.
* **Xác thực:** Gửi tên tài khoản cho Admin để nhận **Mã Token** (Key).
* **Khởi tạo:** Dán Key vào ô xác thực trên Web để kích hoạt máy ảo.

### 2️⃣ Đối với Quản trị viên
* **Đăng nhập:** Truy cập bằng tài khoản Admin (Bảo mật).
* **Quản lý:** Nhấn vào biểu tượng vương miện để xem danh sách User và cấp mã Key.

---

## ⚙️ CẤU HÌNH HỆ THỐNG (DEVELOPER)
Để hệ thống tự động nhận diện và cấp quyền chính xác, cấu trúc dữ liệu được đồng bộ hóa như sau:

* **Firebase:** Lưu trữ tại node `/users` (Thông tin Key) và `/vms` (Thông tin máy ảo).
* **GitHub Actions:** Workflow xác thực Key và tìm `Owner` tương ứng từ Firebase trước khi cài đặt hệ điều hành.

---

## ⚠️ LƯU Ý BẢO MẬT
* Không chia sẻ **Mã Key** cá nhân cho bất kỳ ai.
* Tài khoản `Administrator` có toàn quyền thay đổi hệ thống, hãy cẩn trọng khi cài đặt phần mềm lạ.
* Máy ảo sẽ tự động hủy sau khi hết thời gian chạy quy định của GitHub (6 tiếng).

---

<p align="center">
  <b>Phát triển bởi ZunRdp</b><br>
  <i>"Đơn giản hóa hạ tầng Cloud của bạn"</i>
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/render?type=waving&color=0078D4&height=100&section=footer" />
</p>

