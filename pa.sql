--sql
--1. Tổng số tiền chi tiêu của một khách hàng trong một khoảng thời gian
SELECT KH.TenKH, SUM(HD.TongTien) AS TongChiTieu
FROM KhachHang KH
JOIN HoaDon HD ON KH.TaiKhoan = HD.TaiKhoan
WHERE HD.NgayXuat BETWEEN 'NgayBatDau' AND 'NgayKetThuc'
GROUP BY KH.TaiKhoan;
--2. Danh sách các máy đang sửa chữa và thông tin bảo trì
SELECT BT.*, TTM.TenMay
FROM BaoTri BT
JOIN TrangThaiMay TTM ON BT.MaMay = TTM.MaMay
WHERE BT.TTSua = '1';
--3. Danh sách các hóa đơn có chứa dịch vụ ăn uống và thông tin chi tiết
SELECT HD.*, CTHoaDonAnUong.*
FROM HoaDon HD
JOIN CTHoaDonAnUong ON HD.MaHD = CTHoaDonAnUong.MaHD;
--4. Danh sách các sự kiện diễn ra trong chi nhánh 1 
SELECT *
FROM SuKien 
WHERE MaCN = 'CN1';

--pl/sql
--1. Cập nhật thông tin của một nhân viên
CREATE OR REPLACE PROCEDURE CapNhatThongTinNhanVien(
    p_MaNV IN NUMBER,
    p_TenNV IN VARCHAR2,
    p_DiaChi IN VARCHAR2,
    p_SDT IN VARCHAR2
)
IS
BEGIN
    UPDATE NhanVien
    SET TenNV = p_TenNV, DiaChiNV = p_DiaChi, SDTNV = p_SDT
    WHERE MaNV = p_MaNV;
    COMMIT;
END CapNhatThongTinNhanVien;

--2. Tổng số tiền chi tiêu của một khách hàng
CREATE OR REPLACE FUNCTION TongChiTieu(
    p_TaiKhoan IN VARCHAR2
) RETURN NUMBER
IS
    v_TongTien NUMBER;
BEGIN
    SELECT SUM(TongTien)
    INTO v_TongTien
    FROM HoaDon
    WHERE TaiKhoan = p_TaiKhoan;

    RETURN NVL(v_TongTien, 0);
END TongChiTieu;

--3. Thêm một khách hàng mới
CREATE OR REPLACE PROCEDURE ThemKhachHang(
    p_TaiKhoan IN VARCHAR2,
    p_Ten IN VARCHAR2,
    p_Email IN VARCHAR2,
    p_SDT IN VARCHAR2
)
IS
BEGIN
    INSERT INTO KhachHang(TaiKhoan, TenKH, EmailKH, SDTKH)
    VALUES(p_TaiKhoan, p_Ten, p_Email, p_SDT);
    COMMIT;
END ThemKhachHang;

--4. Đếm số lượng máy đang sửa chữa trong một chi nhánh
CREATE OR REPLACE FUNCTION DemSoMayDangSuaChua(
    p_MaCN IN NUMBER
) RETURN NUMBER
IS
    v_SoMayDangSua NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_SoMayDangSua
    FROM BaoTri
    WHERE MaCN = p_MaCN AND TTSua = '1';

    RETURN v_SoMayDangSua;
END DemSoMayDangSuaChua;
