--SQL
--1.	Lấy danh sách các khách hàng có tổng số tiền chi tiêu lớn hơn trung bình của tất cả khách hàng.
SELECT *
FROM Khách_hàng
WHERE Tổng_số_tiền_chi_tiêu >  AVG(Tổng_số_tiền_chi_tiêu);

--2.	Lấy danh sách các chi nhánh có ít nhất một nhân viên nam và mô tả công việc của họ. 
SELECT DISTINCT CN.*, CV.Mô_tả_CV
FROM Chi_nhánh CN
JOIN Nhân_viên NV ON CN.Mã_CN = NV.Mã_CN
JOIN Vị_trí_CV CV ON NV.Mã_CV = CV.Mã_CV
WHERE NV.Giới_tính = 'Nam';

--3.	Hiển thị thông tin của tất cả các nhân viên có lương cao nhất trong từng bộ phận.
SELECT * 
FROM (SELECT NV.*, RANK() OVER (PARTITION BY NV.Mã_Bộ_phận ORDER BY Lương_Cơ_bản + Hệ_số_lương DESC) AS Rnk
    FROM Nhân_viên NV
    JOIN Lương L ON NV.Mã_NV = L.Mã_NV) 
WHERE Rnk = 1;

--4.	Lấy danh sách các chi nhánh và tổng doanh thu từ dịch vụ ăn uống của mỗi chi nhánh trong tháng hiện tại, sắp xếp theo tổng doanh thu giảm dần.
SELECT CN.*, SUM(DV.Giá_món) AS Tổng_doanh_thu
FROM Chi_nhánh CN
JOIN Máy M ON CN.Mã_CN = M.Mã_CN
JOIN Zone Z ON M.Mã_Zone = Z.Mã_Zone
JOIN Dịch_vụ_ăn_uống DV ON Z.Mã_Zone = DV.Mã_Zone
JOIN Hoá_đơn HD ON DV.Mã_món = HD.Mã_món
WHERE EXTRACT(MONTH FROM HD.Ngày_xuất) = EXTRACT(MONTH FROM SYSDATE)
GROUP BY CN.Mã_CN, CN.Tên_CN
ORDER BY Tổng_doanh_thu DESC;

--PL/SQL
--1.	Thêm máy mới vào hệ thống
CREATE OR REPLACE PROCEDURE Them_May(
    p_Ma_May IN VARCHAR2,
    p_Trang_thai_hoat_dong IN VARCHAR2,
    p_Trang_thai_ban IN VARCHAR2) IS
BEGIN
    INSERT INTO Máy(Mã_Máy, Trạng_thái_hoạt_động, Trạng_thái_bận)
    VALUES (p_Ma_May, p_Trang_thai_hoat_dong, p_Trang_thai_ban);
    COMMIT;
END Them_May;

--2.	Tạo một function để lấy số lượng máy hoạt động tại một chi nhánh cụ thể.
CREATE OR REPLACE FUNCTION Dem_So_May_Hoat_Dong(
    p_Ma_CN IN VARCHAR2) RETURN NUMBER IS
    v_So_May NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_So_May
    FROM Máy M
    JOIN Zone Z ON M.Mã_Zone = Z.Mã_Zone
    WHERE Z.Mã_CN = p_Ma_CN
    AND M.Trạng_thái_hoạt_động = 'Hoạt động';

    RETURN v_So_May;
END Dem_So_May_Hoat_Dong;

--3.	Tạo một procedure để cập nhật trạng thái của các máy dựa trên sự kiện bảo trì và trạng thái sửa của các thiết bị liên quan.
CREATE OR REPLACE PROCEDURE Cap_nhat_Trang_thai_May IS
BEGIN
    FOR Rec IN (SELECT M.*, BT.Trạng_thái_sửa
                FROM Máy M
                JOIN Bảo_trì BT ON M.Mã_máy = BT.Mã_máy)
    LOOP
        IF Rec.Trạng_thái_sửa = 'Đang sửa' THEN
            UPDATE Máy
            SET Trạng_thái_hoạt_động = 'Đang sửa'
            WHERE Mã_máy = Rec.Mã_máy;
        ELSE
            UPDATE Máy
            SET Trạng_thái_hoạt_động = 'Hoạt động'
            WHERE Mã_máy = Rec.Mã_máy;
        END IF;
    END LOOP;
    COMMIT;
END Cap_nhat_Trang_thai_May;

--4.	Tạo một procedure để tính tổng số lượng máy đang sửa trong mỗi chi nhánh và cập nhật thông tin này vào bảng thống kê.
CREATE OR REPLACE PROCEDURE Cap_nhat_Thong_ke_May_Dang_Sua IS
BEGIN
    FOR Rec IN (SELECT CN.Mã_CN, COUNT(*) AS So_luong_may_dang_sua
                FROM Chi_nhánh CN
                JOIN Máy M ON CN.Mã_CN = M.Mã_CN
                JOIN Bảo_trì BT ON M.Mã_máy = BT.Mã_máy
                WHERE BT.Trạng_thái_sửa = 'Đang sửa'
                GROUP BY CN.Mã_CN)
    LOOP
        UPDATE Thống_kê_Chi_nhánh
        SET Số_lượng_máy_đang_sửa = Rec.So_luong_may_dang_sua
        WHERE Mã_CN = Rec.Mã_CN;
    END LOOP;
    COMMIT;
END Cap_nhat_Thong_ke_May_Dang_Sua;
