--SQL
--1.	Thông tin về số lượng máy bảo trì thường xuyên nhất trong từng chi nhánh

SELECT ChiNhanh.MaCN, COUNT(BaoTri.MaMay) AS 'Số lượng máy bảo trì'
FROM ChiNhanh
LEFT JOIN BaoTri ON ChiNhanh.MaCN = BaoTri.MaCN
GROUP BY ChiNhanh.MaCN
ORDER BY COUNT(BaoTri.MaMay) DESC;

--2.	Thông báo số lượng máy đã bận hoặc máy trống trong zone

SELECT Z.TenZone,
       SUM(CASE WHEN M.Trạng_thái_bận = 'Bận' THEN 1 ELSE 0 END) AS Số_lượng_máy_bận,
       SUM(CASE WHEN M.Trạng_thái_bận = 'Trống' THEN 1 ELSE 0 END) AS Số_lượng_máy_trống
FROM Zone Z
JOIN TTMay M ON Z.LoaiZone = M.LoaiZone
GROUP BY Z.TenZone;

--3.	Hiển thị chi nhánh có doanh thu tốt nhất trong tháng

SELECT CN.MaCN, CN.TenCN, SUM(HD.TongTien) AS Doanh_thu_tháng
FROM ChiNhanh CN
JOIN TTMay M ON CN.MaCN = M.MaCN
JOIN Zone Z ON M.LoaiZone = Z.LoaiZone
JOIN HoaDon HD ON Z.LoaiZone = HD.LoaiZone
WHERE EXTRACT(MONTH FROM HD.Ngày_xuất) = EXTRACT(MONTH FROM SYSDATE)
GROUP BY CN.MaCN, CN.TenCN
ORDER BY Doanh_thu_tháng DESC
LIMIT 1;

--4.	Số giờ trung bình một khách ở 1 zone trong ngày

SELECT Z.LoaiZone, AVG(Z.MucGiaTheoGio) AS Số_giờ_trung_bình
FROM Zone Z
GROUP BY Z.LoaiZone;

--Thống kê chỗ được đặt trước trong tháng của từng chi nhánh.

SELECT CN.MaCN, CN.TenCN, COUNT(DC.MaDatCho) AS SoLuongDatCho
FROM ChiNhanh CN
JOIN TTMay M ON CN.MaCN = M.MaCN
JOIN Zone Z ON M.LoaiZone = Z.LoaiZone
JOIN DatCho DC ON Z.LoaiZone = DC.LoaiZone
WHERE EXTRACT(MONTH FROM DC.NgayDat) = EXTRACT(MONTH FROM SYSDATE)
GROUP BY CN.MaCN, CN.TenCN;

--Số lượng máy bảo trì thường xuyên nhất trong từng chi nhánh.

SELECT CN.MaCN, CN.TenCN, M.MaMay, COUNT(*) AS SoLuongBaoTri
FROM ChiNhanh CN
JOIN TTMay M ON CN.MaCN = M.MaCN
JOIN BaoTri BT ON M.MaMay = BT.MaMay
GROUP BY CN.MaCN, CN.TenCN, M.MaMay
ORDER BY SoLuongBaoTri DESC
LIMIT 1;


--PL/SQL
--1.	Tìm khu vực (zone) có lượng khách hàng đông nhất.
CDECLARE @ZoneName NVARCHAR(50);
DECLARE @CustomerCount INT;

DECLARE zone_cursor CURSOR FOR
SELECT Z.TenZone, COUNT(KH.TaiKhoan) AS 'Số lượng khách'
FROM Zone Z
JOIN TTMay M ON Z.LoaiZone = M.TTHoatDong
JOIN KhachHang KH ON M.MaMay = KH.TaiKhoan
GROUP BY Z.TenZone
ORDER BY COUNT(KH.TaiKhoan) DESC;

OPEN zone_cursor;

FETCH NEXT FROM zone_cursor INTO @ZoneName, @CustomerCount;

PRINT 'Zone có lượng khách đông nhất:';
PRINT 'Tên Zone: ' + @ZoneName;
PRINT 'Số lượng khách: ' + CONVERT(NVARCHAR(10), @CustomerCount);

CLOSE zone_cursor;
DEALLOCATE zone_cursor;


--2.	Cập nhật thông tin về số lượng máy đã đặt chỗ trong một chi nhánh
CREATE OR REPLACE PROCEDURE Cap_nhat_Thong_ke_May_Da_Dat_Cho IS
BEGIN
    FOR Rec IN (SELECT CN.MaCN, COUNT(*) AS So_luong_may_da_dat_cho
                FROM ChiNhanh CN
                JOIN TTMay M ON CN.MaCN = M.MaCN
                JOIN DatCho DC ON M.MaMay = DC.MaMay
                GROUP BY CN.MaCN)
    LOOP
        UPDATE Thống_kê_Chi_nhánh
        SET Số_lượng_máy_đã_đặt_chỗ = Rec.So_luong_may_da_dat_cho
        WHERE MaCN = Rec.MaCN;
    END LOOP;
    COMMIT;
END Cap_nhat_Thong_ke_May_Da_Dat_Cho;


--3.	Tạo một procedure để thống kê số lượng KH đặt chỗ theo mã nhân viên.

CREATE OR REPLACE FUNCTION LaySoLuongKHDatCho RETURN SYS_REFCURSOR IS
  cur_result SYS_REFCURSOR;
BEGIN
  OPEN cur_result FOR
    SELECT NV.MaNV, NV.TenNV, COUNT(DC.MaDC) AS SoLuongKHDatCho
    FROM NhanVien NV
    JOIN DatCho DC ON NV.MaNV = DC.MaNV
    GROUP BY NV.MaNV, NV.TenNV;

  RETURN cur_result;
END;

--4.	Nhập vào ngày và cho biết doanh thu của ngày đó theo chi nhánh

CREATE OR REPLACE PROCEDURE TinhDoanhThuNgay IS
  v_Ngay DATE;
BEGIN
  DBMS_OUTPUT.PUT('Nhập ngày (YYYY-MM-DD): ');
  ACCEPT v_Ngay DATE FORMAT 'YYYY-MM-DD';

  FOR rec IN (
    SELECT CN.MaCN, CN.TenCN, HD.NgayXuat AS Ngay, SUM(HD.TongTien) AS "Doanh thu"
    FROM ChiNhanh CN
    JOIN HoaDon HD ON CN.MaCN = HD.MaCN
    WHERE TO_DATE(HD.NgayXuat, 'YYYY-MM-DD') = v_Ngay
    GROUP BY CN.MaCN, CN.TenCN, HD.NgayXuat
    ORDER BY CN.MaCN, HD.NgayXuat
    DBMS_OUTPUT.PUT_LINE('Mã CN: ' || rec.MaCN || ', Tên CN: ' || rec.TenCN || ', Ngày: ' || rec.Ngay || ', Doanh thu: ' || rec.DoanhThu);
  END LOOP;
END;
