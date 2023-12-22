-----------
--- SQL ---
-----------

--- 1. Hiển thị các món ăn thuộc phân loại Đồ uống

select DV.TenMon, PL.TenPL
from DVAnUong DV
join PLDVAnUong PL on DV.MaPL = PL.MaPL
where PL.TenPL = 'Đồ uống';

--- 2. Hiển thị danh sách nhân viên đang làm việc và chi nhánh, bộ phận, vị trí và mức lương hiện tại

select NV.MaNV, NV.TenNV, CN.TenCN AS ChiNhanh, BP.TenBP AS BoPhan, CV.TenCV AS ViTri, (L.HeSoLuong * L.LuongCoBan + L.PhuCap) as Luong 
from NhanVien NV
join ChiNhanh CN on NV.MaCN = CN.MaCN
join BoPhan BP on NV.MaBP = BP.MaBP
join ViTriCV CV on NV.MaCV = CV.MaCV
join Luong L on NV.BacLuong = L.BacLuong
where NV.NgayNghiViec is NULL;

--- 3. Zone được sử dụng nhiều nhất

WITH ZoneUsage AS (
    select Zone.LoaiZone, count(CTI.SoGio) as SoLanSuDung, RANK() OVER (order by count(CTI.SoGio) desc) as RankOrder
    from Zone
    join TTMay on Zone.LoaiZone = TTMay.LoaiZone
    join CTHoaDonInternet CTI on TTMay.MaMay = CTI.MaMay
    group by Zone.LoaiZone
)
SELECT LoaiZone, SoLanSuDung
FROM ZoneUsage
WHERE RankOrder = 1;

--- 4. Khách hàng có hạng từ Bạc trở lên

select KH.TaiKhoan, KH.TenKH, HTK.TenHangTK, KH.SoTienChiTieu, KH.SoTienDangCo
from KhachHang KH
join HangTK HTK on KH.MaHangTK = HTK.MaHangTK
where HTK.TenHangTK not like 'Thường'
order by KH.SoTienChiTieu desc;

--- 5. Thống kê số lần thực hiện bảo trì máy của mỗi chi nhánh

select CN.MaCN, count(BT.MaMay) as SoLanBaoTri
from ChiNhanh CN
join BaoTri BT on CN.MaCN = BT.MaCN
group by CN.MaCN
order by count(BT.MaMay) desc;

--- 6. Số giờ trung bình mà khách hàng chơi ở mỗi Zone

select Z.LoaiZone, Z.TenZone, avg(CI.SoGio) as SoGioTrungBinh
from Zone Z
join TTMay TM on Z.LoaiZone = TM.LoaiZone
join CTHoaDonInternet CI on TM.MaMay = CI.MaMay and TM.MaCN = CI.MaCN
group by Z.LoaiZone, Z.TenZone
order by avg(CI.SoGio) desc;

--- 7. Món ăn được gọi nhiều nhất mỗi tháng

WITH RankedMonAn AS (
    select DV.TenMon, count(CTAU.MaMon) as SoLanGoi, extract(month from H.NgayXuat) as Thang,
        RANK() OVER (PARTITION BY extract(month from H.NgayXuat) order by(CTAU.MaMon) desc) as RankGoiNhieuNhat
    from CTHoaDonAnUong CTAU
    join DVAnUong DV ON CTAU.MaMon = DV.MaMon
    join HoaDon H ON CTAU.MaHD = H.MaHD
    group by CTAU.MaMon, DV.TenMon, EXTRACT(MONTH FROM H.NgayXuat)
)
SELECT Thang, TenMon, SoLanGoi
FROM RankedMonAn
WHERE RankGoiNhieuNhat = 1;

--- 8. Doanh thu các chi nhánh trong năm 2023

select CN.TenCN, sum(HD.TongTien) as DoanhThu
from ChiNhanh CN
join NhanVien NV on CN.MaCN = NV.MaCN
join HoaDon HD on NV.MaNV = HD.MaNV
where extract(year from HD.NgayXuat) = 2023
group by CN.TenCN
order by sum(HD.TongTien) desc;

--- 9. Khách hàng đến từ 2 lần trở lên trong tháng 12 năm 2023

select KH.TaiKhoan, KH.TenKH, count(HD.MaHD) as SoLanDenChoi
from KhachHang KH
join HoaDon HD on KH.TaiKhoan = HD.TaiKhoan
where extract(month from HD.NgayXuat) = 12 and extract(year from HD.NgayXuat) = 2023 
group by KH.TaiKhoan, KH.TenKH
having count(HD.MaHD) >= 2;

--- 10. Khách hàng có số dư tài khoản ít hơn 100000

select KH.TaiKhoan, KH.TenKH, KH.SoTienDangCo
from KhachHang KH
where KH.SoTienDangCo < 100000
order by KH.SoTienDangCo desc;

--- 11. Khách hàng có mức chi tiêu trên chi tiêu trung bình

select KH.TaiKhoan, KH.TenKH, sum(HD.TongTien) as TongTienChiTieu
from KhachHang KH
join HoaDon HD on KH.TaiKhoan = HD.TaiKhoan
group by KH.TaiKhoan, KH.TenKH
having sum(HD.TongTien) > (select avg(TongTien) from HoaDon);

--- 12. Xét tiền thưởng cho nhân viên đã làm ở công ty trên 1 năm

select MaNV, TenNV,
    CASE
        WHEN (extract(year from sysdate) - extract(year from NgayVaoLam)) < 1 THEN '0'
        ELSE '2000000'
    END AS TienThuong
from NhanVien;