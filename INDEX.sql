-------------
--- INDEX ---
-------------

CREATE INDEX id_MatKhau ON KhachHang(MatKhau);
CREATE INDEX id_TenKH ON KhachHang(TenKH);
CREATE INDEX id_SoTienDangCo ON KhachHang(SoTienDangCo);
CREATE INDEX id_SoTienChiTieu ON KhachHang(SoTienChiTieu);
CREATE INDEX id_TenZone ON Zone(TenZone);
CREATE INDEX id_TTHoatDong ON TTMay(TTHoatDong);
CREATE INDEX id_TTBan ON TTMay(TTBan);
CREATE INDEX id_TenMon ON DVAnUong(TenMon);