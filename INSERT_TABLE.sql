-------------------
--- INSERT DATA ---
-------------------

INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Trương Công Giai', '1 Trương Công Giai, Cầu Giấy, Hà Nội', '0123456789');
INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Khâm Thiên', '195 Khâm Thiên, Đống Đa, Hà Nội', '0987654321');
INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Thái Hà', '47 Thái Hà, Đống Đa, Hà Nội', '0123456789');

INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Giám đốc', 'Chủ kinh doanh');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Quản lý', 'Quản lý chi nhánh');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Nhân viên quầy', 'Nhân viên hỗ trợ');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Nhân viên bếp', 'Nhân viên bar');

INSERT INTO BoPhan (TenBP) VALUES ('Quản lý chung');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận internet');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận quầy bar và bếp');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận dịch vụ khác');

INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (1, 1.0, 5000000, 0);
INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (2, 1.2, 6000000, 0);
INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (3, 1.5, 7500000, 0);
INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (4, 1.8, 9000000, 0);
INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (5, 2.0, 10000000, 0);
INSERT INTO Luong (BacLuong, HeSoLuong, LuongCoBan, PhuCap)
VALUES (6, 2.2, 11000000, 0);

INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Thường', 0, 0);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Bạc', 5000000, 5);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Vàng', 1000000, 10);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Bạch kim', 1500000, 15);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Kim cương', 2000000, 20);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Vô địch', 3000000, 25);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong)
VALUES ('Nguyễn Văn A', 1, TO_DATE('1995-01-15', 'YYYY-MM-DD'), '123456789012', '0987654321', 'nv001@spartacus.vn', '123 Chùa Bộc, Haf', NULL, TO_DATE('2022-09-15', 'YYYY-MM-DD'), 'CV1', 'CN1', 'BP1', 5);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Trần Thị B', 0, TO_DATE('2000-05-20', 'YYYY-MM-DD'), '987654321098', '0123456789', 'nv002@spartacus.vn', '456 Chùa Bộc, Hanoi', NULL, TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'CV2', 'CN1', 'BP1', 4);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Lê Văn C', 1, TO_DATE('1998-08-10', 'YYYY-MM-DD'), '765432109876', '0368741250', 'nv003@spartacus.vn', '789 Chùa Bộc, Hanoi', NULL, TO_DATE('2022-12-01', 'YYYY-MM-DD'), 'CV2', 'CN2', 'BP1', 4);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Phạm Văn D', 1, TO_DATE('2001-03-25', 'YYYY-MM-DD'), '543210987654', '0123456789', 'nv004@spartacus.vn', '567 Thái Hà, Hanoi', NULL, TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'CV2', 'CN3', 'BP1', 3);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Trần Văn E', 0, TO_DATE('1999-12-12', 'YYYY-MM-DD'), '876543210987', '0987654321', 'nv005@spartacus.vn', '789 Thái Hà, Hanoi', NULL, TO_DATE('2022-10-01', 'YYYY-MM-DD'), 'CV3', 'CN1', 'BP2', 3);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Lê Thị G', 0, TO_DATE('1998-06-08', 'YYYY-MM-DD'), '654321098765', '0368741250', 'nv006@spartacus.vn', '234 Thái Hà, Hanoi', NULL, TO_DATE('2022-12-01', 'YYYY-MM-DD'), 'CV3', 'CN2', 'BP2', 2);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Nguyễn Văn H', 1, TO_DATE('1997-09-30', 'YYYY-MM-DD'), '345678901234', '0123456789', 'nv007@spartacus.vn', '678 Đường Láng, Hanoi', NULL, TO_DATE('2023-05-15', 'YYYY-MM-DD'), 'CV3', 'CN3', 'BP2', 3);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Phạm Thị I', 0, TO_DATE('1999-02-18', 'YYYY-MM-DD'), '234567890123', '0368741250', 'nv008@spartacus.vn', '345 Đường Láng, Hanoi', NULL, TO_DATE('2022-10-04', 'YYYY-MM-DD'), 'CV4', 'CN1', 'BP4', 2);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Hà Văn K', 1, TO_DATE('1997-07-05', 'YYYY-MM-DD'), '456789012345', '0987654321', 'nv009@spartacus.vn', '456 Đường Láng, Hanoi', NULL, TO_DATE('2022-12-15', 'YYYY-MM-DD'), 'CV4', 'CN2', 'BP4', 2);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Lê Thị L', 0, TO_DATE('2001-04-22', 'YYYY-MM-DD'), '567890123456', '0368741250', 'nv010@spartacus.vn', '567 Đường Láng, Hanoi', NULL, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'CV4', 'CN3', 'BP4', 2);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Trần Văn M', 0, TO_DATE('2000-12-12', 'YYYY-MM-DD'), '876543289017', '0987645123', 'nv011@spartacus.vn', '123 Phạm Ngọc Thạch, Hanoi', NULL, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'CV3', 'CN1', 'BP3', 2);

INSERT INTO NhanVien (TenNV, GioiTinh, NgaySinh, SoCCCD, SDTNV, EmailNV, DiaChiNV, AnhNV, NgayVaoLam, MaCV, MaCN, MaBP, BacLuong) 
VALUES ('Lê Thị N', 0, TO_DATE('2001-06-08', 'YYYY-MM-DD'), '654321096875', '0368745210', 'nv012@spartacus.vn', '234 Phạm Ngọc Thạch, Hanoi', NULL, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'CV3', 'CN2', 'BP3', 2);

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Nguyễn Văn A', 0, TO_DATE('2000-01-15', 'YYYY-MM-DD'), '123456789012', '0987654321', 'nguyenvana@email.com', '123 Đường Chính, Hà Nội', 0, 235000, 1015000, NULL, 'HTK3');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Trần Thị B', 1, TO_DATE('2001-05-20', 'YYYY-MM-DD'), '987654321098', '0123456789', 'tranthib@email.com', '456 Phố Láng, Hà Nội', 0, 80000, 742000, NULL, 'HTK2');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Lê Văn C', 0, TO_DATE('1999-08-10', 'YYYY-MM-DD'), '765432109876', '0368741250', 'levanc@email.com', '789 Phố Trúc Bạch, Hà Nội', 0, 125000, 500000, NULL, 'HTK2');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Phạm Văn D', 0, TO_DATE('2002-03-25', 'YYYY-MM-DD'), '543210987654', '0123456789', 'phamvand@email.com', '567 Phố Sồi, Hà Nội', 0, 25000, 425000, NULL, 'HTK1');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Trần Văn E', 0, TO_DATE('2003-12-12', 'YYYY-MM-DD'), '876543210987', '0987654321', 'tranve@email.com', '789 Phố Thông, Hà Nội', 0, 10000, 340000, NULL, 'HTK1');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Lê Thị G', 1, TO_DATE('2005-06-08', 'YYYY-MM-DD'), '654321098765', '0368741250', 'lethif@email.com', '234 Phố Cổ, Hà Nội', 1, 5000, 165000, NULL, 'HTK1');

INSERT INTO KhachHang (MatKhau, TenKH, GioiTinh, NgaySinh, SoCCCD, SDTKH, EmailKH, DiaChiKH, TTGioiHan, SoTienDangCo, SoTienChiTieu, AnhKH, MaHangTK) 
VALUES ('spartacus', 'Nguyễn Văn H', 0, TO_DATE('2004-09-30', 'YYYY-MM-DD'), '345678901234', '0123456789', 'nguyenvang@email.com', '678 Phố Nhà Thờ, Hà Nội', 0, 90000, 241000, NULL, 'HTK1');

INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk1', 'NV1', 500000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk2', 'NV2', 300000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk3', 'NV3', 125000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk1', 'NV5', 300000);

INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk2', 'NV6', 200000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk4', 'NV7', 300000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk5', 'NV3', 250000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk6', 'NV4', 170000);

INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk1', 'NV5', 250000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk2', 'NV6', 100000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk7', 'NV7', 250000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk3', 'NV5', 500000);

INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk2', 'NV6', 100000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk1', 'NV6', 200000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk5', 'NV5', 100000);
INSERT INTO GDNapTien (TaiKhoan, MaNV, SoTienNap) VALUES ('tk4', 'NV7', 150000);

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('VIP', 'VIP Zone', 12000, 'Main: MSI H410M PRO 
CPU: Intel Core i5-10400 Socket Intel LGA 1200 
RAM: GSKILL F4-2666C195-AGNT 
VGA: MSI GTX 1660 VENTUS XS OC 
Monitor: HRC M27GF 27inch FHD 144Hz 
Keyboard: Steelseries Apex 3 
Mouse: Steelseries Rival 3 
Headset: Dune E92571 RR Black Rock 
Desk: 800 x 600');

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('STREAMING', 'Streaming Zone', 20000, 'Main: MSI H410M PRO 
CPU: Intel Core i5-10400 Socket Intel LGA 1200 
RAM: GSKILL F4-2666C195-AGNT 
VGA: MSI GTX 1660 VENTUS XS OC 
Monitor: HRC M27GF 27inch FHD 144Hz 
Keyboard: Steelseries Apex 3 
Mouse: Steelseries Rival 3 
Headset: Dune E92571 RR Black Rock 
Desk: 800 x 600');

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('COUPLE', 'Couple Zone', 16000, 'Main: MSI H410M PRO 
CPU: Intel Core i5-10400 Socket Intel LGA 1200 
RAM: GSKILL F4-2666C195-AGNT 
VGA: MSI GTX 1660 VENTUS XS OC 
Monitor: HRC M27GF 27inch FHD 144Hz 
Keyboard: Steelseries Apex 3 
Mouse: Steelseries Rival 3 
Headset: Dune E92571 RR Black Rock 
Desk: 800 x 600');

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('FPS', 'FPS Zone', 10000, 'Main: MSI H410M PRO 
CPU: Intel Core i5-10400 Socket Intel LGA 1200 
RAM: GSKILL F4-2666C195-AGNT 
VGA: MSI GTX 1660 VENTUS XS OC 
Monitor: HRC M27GF 27inch FHD 144Hz 
Keyboard: Steelseries Apex 3 
Mouse: Steelseries Rival 3 
Headset: Dune E92571 RR Black Rock 
Desk: 800 x 600');

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('STANDARD', 'Standard Zone', 8000, 'PlayStation: PS4 Pro
Gamepad: Sony DualShock 4/Black 
TV: Smart tivi LG 49 inch 4K 49UM7300PTA');

INSERT INTO Zone (LoaiZone, TenZone, MucGiaTheoGio, TSKT)
VALUES
('PES', 'PES Zone', 20000, 'Main: MSI H410M PRO 
CPU: Intel Core i5-10400 Socket Intel LGA 1200 
RAM: GSKILL F4-2666C195-AGNT 
VGA: MSI GTX 1660 VENTUS XS OC 
Monitor: HRC M27GF 27inch FHD 144Hz 
Keyboard: Steelseries Apex 3 
Mouse: Steelseries Rival 3 
Headset: Dune E92571 RR Black Rock 
Desk: 800 x 600');

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP001', 'CN1', 'VIP', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP002', 'CN1', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP003', 'CN1', 'VIP', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP004', 'CN1', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP005', 'CN1', 'VIP', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR001', 'CN1', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR002', 'CN1', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR003', 'CN1', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR004', 'CN1', 'STREAMING', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR005', 'CN1', 'STREAMING', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU001', 'CN1', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU002', 'CN1', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU003', 'CN1', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU004', 'CN1', 'COUPLE', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU005', 'CN1', 'COUPLE', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS001', 'CN1', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS002', 'CN1', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS003', 'CN1', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS004', 'CN1', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS005', 'CN1', 'FPS', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA001', 'CN1', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA002', 'CN1', 'STANDARD', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA003', 'CN1', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA004', 'CN1', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA005', 'CN1', 'STANDARD', 1, 1);


INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP001', 'CN2', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP002', 'CN2', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP003', 'CN2', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP004', 'CN2', 'VIP', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP005', 'CN2', 'VIP', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR001', 'CN2', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR002', 'CN2', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR003', 'CN2', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR004', 'CN2', 'STREAMING', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR005', 'CN2', 'STREAMING', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU001', 'CN2', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU002', 'CN2', 'COUPLE', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU003', 'CN2', 'COUPLE', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU004', 'CN2', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU005', 'CN2', 'COUPLE', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS001', 'CN2', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS002', 'CN2', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS003', 'CN2', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS004', 'CN2', 'FPS', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS005', 'CN2', 'FPS', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA001', 'CN2', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA002', 'CN2', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA003', 'CN2', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA004', 'CN2', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA005', 'CN2', 'STANDARD', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('PES001', 'CN2', 'PES', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('PES002', 'CN2', 'PES', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('PES003', 'CN2', 'PES', 1, 0);


INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP001', 'CN3', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP002', 'CN3', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP003', 'CN3', 'VIP', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP004', 'CN3', 'VIP', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('VIP005', 'CN3', 'VIP', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR001', 'CN3', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR002', 'CN3', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR003', 'CN3', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR004', 'CN3', 'STREAMING', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STR005', 'CN3', 'STREAMING', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU001', 'CN3', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU002', 'CN3', 'COUPLE', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU003', 'CN3', 'COUPLE', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU004', 'CN3', 'COUPLE', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('COU005', 'CN3', 'COUPLE', 1, 0);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS001', 'CN3', 'FPS', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS002', 'CN3', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS003', 'CN3', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS004', 'CN3', 'FPS', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('FPS005', 'CN3', 'FPS', 1, 1);

INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA001', 'CN3', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA002', 'CN3', 'STANDARD', 1, 0);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA003', 'CN3', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA004', 'CN3', 'STANDARD', 1, 1);
INSERT INTO TTMay (MaMay, MaCN, LoaiZone, TTHoatDong, TTBan) VALUES ('STA005', 'CN3', 'STANDARD', 1, 1);

INSERT INTO PLDVAnUong (TenPL) VALUES ('Đồ uống');
INSERT INTO PLDVAnUong (TenPL) VALUES ('Đồ ăn');
INSERT INTO PLDVAnUong (TenPL) VALUES ('Combo');

INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Coca Cola', 15000, NULL, 'PL1');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Pepsi', 15000, NULL, 'PL1');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('7Up', 15000, NULL, 'PL1');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Sting', 15000, NULL, 'PL1');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Red Bull', 15000, NULL, 'PL1');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Nước lọc', 10000, NULL, 'PL1');

INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Mì bò', 40000, NULL, 'PL2');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Mì hải sản', 40000, NULL, 'PL2');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Mì tokbokki', 45000, NULL, 'PL2');

INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Combo mì bò', 55000, NULL, 'PL3');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Combo mì hải sản', 55000, NULL, 'PL3');
INSERT INTO DVAnUong (TenMon, GiaMon, AnhMon, MaPL) VALUES ('Combo mì tokbokki', 60000, NULL, 'PL3');

INSERT INTO DVKhac (TenDV, MucGiaTheoGio) VALUES ('Billards', 20000);
INSERT INTO DVKhac (TenDV, MucGiaTheoGio) VALUES ('Karaoke', 30000);

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk1', 'NV1', TO_DATE('2022-10-08', 'YYYY-MM-DD'), 75000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk2', 'NV6', TO_DATE('2022-12-02', 'YYYY-MM-DD'), 69000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk5', 'NV5', TO_DATE('2022-11-03', 'YYYY-MM-DD'), 40000, NULL);

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk4', 'NV7', TO_DATE('2023-03-04', 'YYYY-MM-DD'), 87000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk3', 'NV5', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 30000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk2', 'NV6', TO_DATE('2023-02-23', 'YYYY-MM-DD'), 88000, NULL);

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk1', 'NV6', TO_DATE('2023-06-05', 'YYYY-MM-DD'), 135000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk7', 'NV7', TO_DATE('2022-11-27', 'YYYY-MM-DD'), 51000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk6', 'NV4', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 32000, NULL);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD1', 'STR002', 'CN1', 2, 20000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD2', 'FPS001', 'CN2', 3, 10000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD3', 'STA001', 'CN1', 5, 8000, 0);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD4', 'COU003', 'CN3', 2, 16000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD5', 'FPS002', 'CN1', 3, 10000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD6', 'VIP001', 'CN2', 4, 12000, 0);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD7', 'PES002', 'CN2', 3, 20000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD8', 'VIP002', 'CN3', 3, 12000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD9', 'STA002', 'CN3', 2, 12000, 0);

INSERT INTO CTHoaDonDVKhac (MaHD, MaDV, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD7', 'DVK1', 2, 20000, 0);
INSERT INTO CTHoaDonDVKhac (MaHD, MaDV, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD2', 'DVK2', 1, 30000, 20);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD1', 'DVAU2', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD2', 'DVAU1', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD4', 'DVAU10', 1, 55000, 0);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD6', 'DVAU8', 1, 40000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD7', 'DVAU6', 2, 10000, 0);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD7', 'DVAU2', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD8', 'DVAU4', 1, 15000, 0);

INSERT INTO ThietBi (TenTB) VALUES ('Main');
INSERT INTO ThietBi (TenTB) VALUES ('CPU');
INSERT INTO ThietBi (TenTB) VALUES ('RAM');

INSERT INTO ThietBi (TenTB) VALUES ('VGA');
INSERT INTO ThietBi (TenTB) VALUES ('Monitor');
INSERT INTO ThietBi (TenTB) VALUES ('Keyboard');

INSERT INTO ThietBi (TenTB) VALUES ('Mouse');
INSERT INTO ThietBi (TenTB) VALUES ('Headset');
INSERT INTO ThietBi (TenTB) VALUES ('Desk');

INSERT INTO ThietBi (TenTB) VALUES ('PlayStation');
INSERT INTO ThietBi (TenTB) VALUES ('Gamepad');
INSERT INTO ThietBi (TenTB) VALUES ('TV');

INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'VIP003', 'TB3', 'Lỗi RAM', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN2', 'STR002', 'TB3', 'Lỗi RAM', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'STA005', 'TB4', 'Lỗi VGA', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'COU001', 'TB4', 'Lỗi VGA', NULL, 0);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN3', 'STA002', 'TB6', 'Bàn phím bị kẹt', NULL, 1);

INSERT INTO SuKien (TenSK, MoTaSK, NgayBD, NgayKT, TTToChuc, MaCN) VALUES ('Spartacus Cyber Cup TFT T9', 'Giải Teamfight Tactics Tier C', TO_DATE('2023-09-14', 'YYYY-MM-DD'), TO_DATE('2023-09-24', 'YYYY-MM-DD'), 1, 'CN1');
INSERT INTO SuKien (TenSK, MoTaSK, NgayBD, NgayKT, TTToChuc, MaCN) VALUES ('Valorant Campus Cyber Cup 2023', 'Sân chơi dành riêng cho các bạn học sinh đam mê eSports với tổng giá trị giải thưởng lên đến 8 triệu VNĐ', TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-04', 'YYYY-MM-DD'), 1, 'CN2');

INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk1', 'Giảm 50% giá đến ngày 17/1/2024');
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk2', NULL);
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk4', NULL);

INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk2', NULL);
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk3', 'Tặng 2 triệu vật phẩm trong game Valorant');
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk5', 'Tặng 1 triệu vật phẩm trong game Valorant');

INSERT INTO DatCho (TaiKhoan, MaNV, NgayDat, NgayDen, YeuCau) VALUES ('tk1', 'NV5', TO_DATE('2023-12-13', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 'Đặt 1 máy Streaming tại CN1');
INSERT INTO DatCho (TaiKhoan, MaNV, NgayDat, NgayDen, YeuCau) VALUES ('tk2', 'NV6', TO_DATE('2023-12-15', 'YYYY-MM-DD'), TO_DATE('2023-12-17', 'YYYY-MM-DD'), 'Đặt 1 máy PES tại CN2');
INSERT INTO DatCho (TaiKhoan, MaNV, NgayDat, NgayDen, YeuCau) VALUES ('tk3', 'NV5', TO_DATE('2023-12-16', 'YYYY-MM-DD'), TO_DATE('2023-12-18', 'YYYY-MM-DD'), 'Đặt 1 máy Streaming tại CN3');
INSERT INTO DatCho (TaiKhoan, MaNV, NgayDat, NgayDen, YeuCau) VALUES ('tk4', 'NV7', TO_DATE('2023-12-17', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'Đặt 2 máy VIP tại CN1');

SELECT * FROM ChiNhanh;
SELECT * FROM ViTriCV;
SELECT * FROM BoPhan;
SELECT * FROM Luong;
SELECT * FROM HangTK;
SELECT * FROM NhanVien;
SELECT * FROM KhachHang;
SELECT * FROM GDNapTien;
SELECT * FROM Zone;
SELECT * FROM TTMay;
SELECT * FROM PLDVAnUong;
SELECT * FROM DVKhac;
SELECT * FROM DVAnUong;
SELECT * FROM HoaDon;
SELECT * FROM CTHoaDonInternet;
SELECT * FROM CTHoaDonDVKhac;
SELECT * FROM CTHoaDonAnUong;
SELECT * FROM ThietBi;
SELECT * FROM BaoTri;
SELECT * FROM SuKien;
SELECT * FROM ThamGiaSuKien;
SELECT * FROM DatCho;