-- 1 danh sách máy đang bảo trì --
SELECT *
FROM THIETBI
INNER JOIN BAOTRI ON THIETBI.MATB = BAOTRI.MABT
WHERE DBMS_LOB.COMPARE(BAOTRI.TINHTRANG, '0') = 0;
-- 2 doanh thu từng chi nhánh trong năm
SELECT CN.MaCN, CN.TenCN, SUM(HD.TongTien) AS DoanhThu
FROM ChiNhanh CN
JOIN NhanVien NV ON CN.MaCN = NV.MaCN
JOIN HoaDon HD ON NV.MaNV = HD.MaNV
GROUP BY CN.MaCN, CN.TenCN;
-- 3 danh sách lương nhân viên
SELECT Nhanvien.MANV,NHANVIEN.TenNV,(LUONG.LUONGCOBAN*LUONG.LUONGCOBAN+LUONG.PHUCAP) 
from NHANVIEN INNER join LUONG  on NHANVIEN.BacLuong = LUONG.BACLUONG;


-- PL/SQL

-- 1. hàm đưa ra kahcsh hàng tiêu nhiều nhất 2022

CREATE OR REPLACE FUNCTION KhachTieuNhieuNhat
RETURN SYS_REFCURSOR
IS
    CURSOR KCTNN IS
        SELECT KHACHHANG.TAIKHOAN, KHACHHANG.TENKH, SUM(HOADON.TONGTIEN) AS TotalSpending
        FROM KHACHHANG JOIN HOADON  ON KHACHHANG.TAIKHOAN = HOADON.TAIKHOAN
        WHERE EXTRACT(YEAR FROM HOADON.NGAYXUAT) = 2022
        GROUP BY KHACHHANG.TAIKHOAN, KhachHang.TENKH
        ORDER BY TotalSpending DESC;

    KH SYS_REFCURSOR;

BEGIN
    OPEN KH FOR
        SELECT * FROM KCTNN;
    RETURN KH;
END KhachTieuNhieuNhat;


DROP FUNCTION KhachTieuNhieuNhat;


SHOW ERRORS FUNCTION KhachTieuNhieuNhat;

-- 2. Lượt khách sử dụng theo Zone theo từng tháng


CREATE OR REPLACE PROCEDURE LDTZ (
    l_year IN NUMBER
) AS
    counts NUMBER; 
BEGIN
    FOR zones IN (SELECT LoaiZone FROM Zone) LOOP
        FOR months IN 1..12 LOOP
            counts := 0;
            SELECT COUNT(*)
            INTO   counts
            FROM   CTHoaDonInternet c
                   JOIN HoaDon h ON c.MaHD = h.MaHD
                   JOIN TTMay t ON c.MaMay = t.MaMay AND c.MaCN = t.MaCN
            WHERE  EXTRACT(YEAR FROM h.NgayXuat) = l_year
                   AND EXTRACT(MONTH FROM h.NgayXuat) = months
                   AND t.LoaiZone = zones.LoaiZone;
            -- In thông tin lượt khách sử dụng
            DBMS_OUTPUT.PUT_LINE('Zone: ' || zones.LoaiZone || ', Tháng ' || months || ': ' || counts || ' lượt');
        END LOOP;
    END LOOP;
END;
/


SET SERVEROUTPUT ON;
EXEC LDTZ(2022);


SHOW ERRORS PROCEDURE LDTZ
drop PROCEDURE LDTZ

-- 3. số lượng khách tham gia từng sự kiện tổng hợp 

CREATE OR REPLACE PROCEDURE LKTG AS
BEGIN
    FOR events IN (SELECT * FROM SuKien) LOOP

        DECLARE
            counts NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO   counts
            FROM   ThamGiaSuKien
            WHERE  MaSK = events.MaSK;

            DBMS_OUTPUT.PUT_LINE('Sự kiện: ' || events.TenSK || ', Số lượng khách tham gia: ' || counts);
        END;
    END LOOP;
END;

-- 3. số lượng khách tham gia từng sự kiện tổng hợp theo năm

CREATE OR REPLACE PROCEDURE LKTGTN (
    p_year IN NUMBER
) AS
BEGIN
    FOR events IN (SELECT * FROM SuKien WHERE EXTRACT(YEAR FROM NgayBD) = p_year) LOOP

        DECLARE
            counts NUMBER;
        BEGIN
            SELECT COUNT(*)
            INTO   counts
            FROM   ThamGiaSuKien
            WHERE  MaSK = events.MaSK;

            -- In thông tin số lượng khách tham gia
            DBMS_OUTPUT.PUT_LINE('Sự kiện: ' || events.TenSK || ', Số lượng khách tham gia trong năm ' || p_year || ': ' || counts);
        END;
    END LOOP;
END;


SET SERVEROUTPUT ON;
EXEC LKTGTN(2022);

drop PROCEDURE LKTG