# 🛡️ HƯỚNG DẪN CẤU HÌNH TAILSCALE TOKEN

Để các máy ảo (ZUN-WIN, ZUN-UBUNTU) có thể hiển thị IP và trạng thái lên trang quản trị ZUNRDP, bạn cần nhập mã kết nối (Auth Key) của Tailscale vào GitHub.

---

### Bước 1: Lấy Auth Key từ Tailscale
1. Truy cập vào **[Tailscale Admin Console](https://login.tailscale.com/admin/settings/keys)**.
2. Nhấn nút **Generate auth key...**.
3. **Cấu hình quan trọng:**
   - **Reusable:** Bật (Để dùng được cho nhiều máy ảo cùng lúc).
   - **Ephemeral:** Bật (Để máy tự xóa khỏi danh sách khi bạn ngắt máy).
   - **Pre-authorized:** Bật.
4. Nhấn **Generate key** và **SAO CHÉP** mã có dạng `tskey-auth-xxxx...`.

---

### Bước 2: Nhập Token vào GitHub (Secrets)
Để bảo mật, bạn không dán trực tiếp mã vào code mà phải dán vào phần ẩn của GitHub:
1. Truy cập vào kho lưu trữ (Repository) của bạn trên GitHub (Ví dụ: `zunrdp-Cloud`).
2. Nhấn vào mục **Settings** (Bánh răng) trên thanh menu.
3. Ở cột bên trái, tìm mục **Secrets and variables** -> Chọn **Actions**.
4. Nhấn nút **New repository secret** (Nút màu xanh).
5. Nhập thông tin như sau:
   - **Name:** `TAILSCALE_AUTH_KEY`
   - **Secret:** (Dán mã `tskey-auth-xxxx...` bạn vừa copy ở Bước 1 vào đây).
6. Nhấn **Add secret** để lưu lại.

---

### Bước 3: Kiểm tra kết nối
1. Sau khi nhập Secret, bạn quay lại tab **Actions** và chạy thử một Workflow (Ví dụ: chạy máy Windows).
2. Máy ảo sẽ tự động dùng mã này để đăng nhập vào mạng Tailscale.
3. Khi máy ảo hiện thông báo "Success", địa chỉ IP của máy sẽ tự động được gửi về trang quản trị `zunrdp-admin` của bạn.

---

### ⚠️ Lưu ý bảo mật
* **Tuyệt đối không** chia sẻ mã `tskey` này cho người khác.
* Nếu mã hết hạn (thường là 90 ngày), bạn chỉ cần vào Tailscale tạo mã mới và cập nhật lại vào mục **Secrets** trên GitHub là xong.
* 
