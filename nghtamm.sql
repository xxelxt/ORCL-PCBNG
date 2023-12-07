-- SQL
-- 1 - Tong doanh thu trong ngay (VD: 11/7/2023)
select sum(TongTien) as DoanhThuNgay 
from HoaDon 
where NgayXuat = to_date('2023-11-07', 'YYYY-MM-DD');

-- 2 - Truy van danh sach nhan vien va chuc vu cua ho
select NhanVien.TenNV, ViTriCV.TenCV 
from NhanVien 
join ViTriCV on NhanVien.MaCV = ViTriCV.MaCV;

-- 3 - Truy van thong tin hoa don trong ngay cu the (VD: 11/7/2023)
select HoaDon.MaHD, HoaDon.TaiKhoan, HoaDon.TongTien, NhanVien.MaNV, NhanVien.TenNV
from HoaDon
join NhanVien on HoaDon.MaNV = HoaDon.MaNV
where HoaDon.NgayXuat = to_date('2023-11-07', 'YYYY-MM-DD');

-- PL/SQL
-- 1 - Cap nhat so tien trong tai khoan cua khach hang 
create or replace procedure UpdateSoTienTaiKhoan
is
    tk char(30);
    tiennap number;
begin
    update KhachHang
    set SoTienDangCo = SoTienDangCo + tiennap
    where TaiKhoan = tk;
end;

-- 2 - Kiem tra may con dang hoat dong hay khong
create or replace function KiemTraTinhTrangMay
return boolean
is
    idmay char(10);
    status number;
begin
    select TTHoatDong into status
    from TTMay
    where MaMay = idmay;
    return status = 1;
end;

-- 3 - Cap nhat trang thai may sau khi bao tri 
create or replace trigger UpdateTinhTrangMay
after update of TTSua on BaoTri
for each row
when (new.TTSua = 0)
begin
    update TTMay
    set TTHoatDong = 1
    where MaMay = :new.MaMay;
end;