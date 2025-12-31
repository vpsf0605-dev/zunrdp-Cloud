# <img src="https://raw.githubusercontent.com/Tarikul-Islam-Anik/Animated-Fluent-Emojis/master/Emojis/Objects/Cloud.png" alt="Cloud" width="40" height="40" /> ZUNRDP CLOUD INFRASTRUCTURE

<p align="center">
  <img src="https://img.shields.io/badge/Version-2.0.0-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Security-Firebase_Encrypted-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/OS-Windows_Server_2025-0078D4?style=for-the-badge&logo=windows" />
</p>

---

## 📖 GIỚI THIỆU
**ZunRDP Cloud** là giải pháp quản trị máy ảo (VPS) tự động hóa tối ưu trên nền tảng GitHub Actions. Hệ thống cho phép người dùng đăng ký và sử dụng Windows VM với quyền **Administrator** thông qua giao diện Web Panel.

📍 **Panel Link:** [https://vpsf0605-dev.github.io/zunrdp-admin/](https://vpsf0605-dev.github.io/zunrdp-admin/)

---

## 🛠️ HƯỚNG DẪN CÀI ĐẶT TAILSCALE KEY (CHO ADMIN)
Để máy ảo có thể kết nối mạng và hiển thị IP, bạn cần cấu hình mã khóa xác thực Tailscale vào GitHub:

### Bước 1: Lấy Auth Key từ Tailscale
1. Truy cập vào **[Tailscale Admin Console](https://login.tailscale.com/admin/settings/keys)**.
2. Nhấn nút **Generate auth key...**.
3. **Cấu hình quan trọng:**
   - **Reusable:** Bật (Để dùng được cho nhiều máy ảo).
   - **Ephemeral:** Bật (Để máy tự động xóa khỏi danh sách khi tắt).
   - **Pre-authorized:** Bật.
4. Nhấn **Generate Key** và Copy mã có dạng `tskey-auth-XXXXXXXX`.

### Bước 2: Thêm vào GitHub Secrets
1. Mở Repository của bạn trên GitHub.
2. Vào mục **Settings** -> **Secrets and variables** -> **Actions**.
3. Nhấn **New repository secret**.
4. Ô **Name**: Nhập chính xác `TAILSCALE_AUTHKEY`.
5. Ô **Secret**: Dán mã Key bạn vừa copy ở Bước 1.
6. Nhấn **Add secret**.

---

## 🔑 THÔNG TIN KẾT NỐI (RDP)

| Hạng mục | Thông tin chi tiết |
| :--- | :--- |
| **User (Tài khoản)** | `Administrator` |
| **Pass (Mật khẩu)** | `ZunRDP@123456` |
| **IP Address** | *Lấy từ mục IP trên Web Panel* |

---

## 🚀 QUY TRÌNH VẬN HÀNH

### 1️⃣ Đối với Thành viên
* **Đăng ký:** Tạo tài khoản tại trang login.
* **Xác thực:** Nhận **Mã Token** (Key) từ Admin.
* **Khởi tạo:** Dán Key vào ô xác thực trên Web để kích hoạt máy ảo.

### 2️⃣ Đối với Quản trị viên
* **Quản lý:** Truy cập mục Admin (biểu tượng vương miện) để cấp mã Key cho User.
* **Giám sát:** Kiểm tra trạng thái máy ảo thông qua Firebase và Tailscale Dashboard.

---

## ⚙️ CẤU TRÚC HỆ THỐNG
* **Frontend:** React-style HTML/TailwindCSS.
* **Backend:** Firebase Realtime Database.
* **Automation:** GitHub Actions Workflow.
* **Connectivity:** Tailscale VPN (Bypass NAT/Firewall).

---

## ⚠️ LƯU Ý BẢO MẬT
* Không chia sẻ mã `TAILSCALE_AUTHKEY` cho người lạ.
* Máy ảo sẽ tự động xóa sau 6 giờ chạy để đảm bảo an toàn tài nguyên.
* Luôn sử dụng mật khẩu mạnh cho các tài khoản đăng ký.

---

<p align="center">
  <b>Phát triển bởi ZunRdp</b><br>
  <i>"Hệ thống Cloud VPS tự động hóa hàng đầu"</i>
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/render?type=waving&color=0078D4&height=100&section=footer" />
</p>

