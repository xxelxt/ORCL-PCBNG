--------------
--- PL/SQL ---
--------------

--- 1. Nạp tiền vào tài khoản khách hàng và chèn bản ghi vào bảng GDNapTien

CREATE OR REPLACE FUNCTION f_UpdateSoTienTaiKhoan (
    p_tk IN KhachHang.TaiKhoan%TYPE,
    p_nv IN NhanVien.MaNV%TYPE,
    p_sotien IN NUMBER
)
RETURN CLOB
IS
    v_result CLOB;
BEGIN
    UPDATE KhachHang
    SET SoTienDangCo = SoTienDangCo + p_sotien
    WHERE TaiKhoan = p_tk;

    INSERT INTO GDNapTien (MaGD, TaiKhoan, MaNV, SoTienNap)
    VALUES ('GD' || LPAD(MaGD_Seq.NEXTVAL, 5, '0'), p_tk, p_nv, p_sotien);

    COMMIT;
    
    v_result := 'Cập nhật thành công.';
    RETURN v_result;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        v_result := 'Đã xảy ra lỗi: ' || SQLERRM;
        RETURN v_result;
END;
/

ACCEPT taikhoan CHAR PROMPT 'Nhập tài khoản: ';
ACCEPT manv CHAR PROMPT 'Nhập mã nhân viên: ';
ACCEPT sotien NUMBER PROMPT 'Nhập số tiền nạp: ';

DECLARE
    v_result CLOB;
    v_tk KhachHang.TaiKhoan%TYPE := '&taikhoan';
    v_nv NhanVien.MaNV%TYPE := '&manv';
    v_sotien NUMBER := &sotien;
    v_sodu NUMBER;
BEGIN
    v_result := f_UpdateSoTienTaiKhoan(v_tk, v_nv, v_sotien);

    SELECT SoTienDangCo INTO v_sodu
    FROM KhachHang
    WHERE TaiKhoan = v_tk;

    dbms_output.put_line('Kết quả: ' || v_result);
    dbms_output.put_line('Số dư tài khoản ' || v_tk || ' sau khi nạp: ' || v_sodu);
END;
/

--- 2. Tính doanh thu trong khoảng thời gian nhập từ bàn phím

CREATE OR REPLACE FUNCTION f_DoanhThuTheoKhoang (
    ThangNam1 IN DATE,
    ThangNam2 IN DATE
) 
RETURN NUMBER
IS
    DoanhThu NUMBER;
BEGIN
    SELECT NVL(SUM(TongTien), 0)
    INTO DoanhThu
    FROM HoaDon
    WHERE NgayXuat BETWEEN ThangNam1 AND ThangNam2;

    RETURN DoanhThu;
END;
/

ACCEPT thangnam1 CHAR PROMPT 'Nhập thời điểm bắt đầu (YYYY-MM-DD): ';
ACCEPT thangnam2 CHAR PROMPT 'Nhập thời điểm kết thúc (YYYY-MM-DD): ';

DECLARE
    DTResult NUMBER;
    TGBatDau DATE := TO_DATE('&thangnam1', 'YYYY-MM-DD');
    TGKetThuc DATE := TO_DATE('&thangnam2', 'YYYY-MM-DD');
BEGIN
    DTResult := f_DoanhThuTheoKhoang(TGBatDau, TGKetThuc);
    dbms_output.put_line('Tổng doanh thu của hệ thống từ ' || TO_CHAR(TGBatDau, 'YYYY-MM-DD') || ' đến ' || TO_CHAR(TGKetThuc, 'YYYY-MM-DD') || ': ' || DTResult);
END;
/

--- 3. Tính doanh thu của ngày nhập từ bàn phím

CREATE OR REPLACE FUNCTION f_DoanhThu1Ngay (
    p_Ngay IN DATE
)
RETURN NUMBER
IS
    TongDoanhThu NUMBER;
BEGIN
    SELECT NVL(SUM(TongTien), 0)
    INTO TongDoanhThu
    FROM HoaDon
    WHERE TRUNC(NgayXuat) = TRUNC(p_Ngay);

    RETURN TongDoanhThu;
END;
/

ACCEPT ngay CHAR PROMPT 'Nhập ngày (YYYY-MM-DD): ';

DECLARE
    DTResult NUMBER;
    NgayInput DATE := TO_DATE('&ngay', 'YYYY-MM-DD');
BEGIN
    DTResult := f_DoanhThu1Ngay(NgayInput);
    dbms_output.put_line('Tổng doanh thu ngày ' || TO_CHAR(NgayInput, 'DD-MM-YYYY') || ': ' || DTResult);
END;
/

--- 4. Top 5 khách hàng chi tiêu nhiều nhất theo năm nhập từ bàn phím

CREATE OR REPLACE FUNCTION f_Top5KHChiTieu(
    p_nam NUMBER
)
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        WITH Top5Customers AS (
            SELECT KH.TaiKhoan, KH.TenKH, SUM(HD.TongTien) as TongTienChiTieu,
                RANK() OVER (ORDER BY SUM(HD.TongTien) DESC) AS SpendingRank
            FROM KhachHang KH
            JOIN HoaDon HD ON KH.TaiKhoan = HD.TaiKhoan
            WHERE EXTRACT(YEAR FROM HD.NgayXuat) = p_nam
            GROUP BY KH.TaiKhoan, KH.TenKH
        )
        SELECT *
        FROM Top5Customers
        WHERE SpendingRank <= 5;

    RETURN v_cursor;
END;
/

ACCEPT Nam NUMBER PROMPT 'Nhập năm để tìm top khách hàng chi tiêu nhiều nhất: ';

DECLARE
    v_cursor SYS_REFCURSOR;
    v_taikhoan KHACHHANG.TAIKHOAN%TYPE;
    v_tenkh KHACHHANG.TENKH%TYPE;
    v_totalspending NUMBER;
    v_spendingrank NUMBER;
    v_nam NUMBER := &Nam;
BEGIN
    v_cursor := f_Top5KHChiTieu(v_nam);
    dbms_output.put_line('Khách hàng chi tiêu nhiều nhất ' || v_nam || ':' || CHR(10));
    LOOP
        FETCH v_cursor INTO v_taikhoan, v_tenkh, v_totalspending, v_spendingrank;
        EXIT WHEN v_cursor%NOTFOUND;
  
        dbms_output.put_line(v_spendingrank || '. ' || v_taikhoan || ' - ' || v_tenkh || ' - ' || v_totalspending);
    END LOOP;

    CLOSE v_cursor;
END;
/

--- 5. Nhập mã sự kiện và hiển thị số người tham gia

CREATE OR REPLACE FUNCTION f_ThamGiaSuKien(
    p_MaSK IN SuKien.MaSK%TYPE
)
RETURN NUMBER
IS
    p_counts NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO p_counts
    FROM ThamGiaSuKien
    WHERE MaSK = p_MaSK;
    RETURN p_counts;
END;
/

ACCEPT MaSK CHAR PROMPT 'Nhập mã sự kiện: ';

DECLARE
    v_MaSK SuKien.MaSK%TYPE := '&MaSK';
    v_TenSK SuKien.TenSK%TYPE;
    v_count NUMBER;
BEGIN
    v_count := f_ThamGiaSuKien(v_MaSK);

    SELECT TenSK
    INTO v_TenSK
    FROM SuKien
    WHERE MaSK = v_MaSK;

    dbms_output.put_line('Tên sự kiện có mã ' || v_MaSK || ': ' || v_TenSK);
    dbms_output.put_line('Số lượng người tham gia: ' || v_count);
END;
/

--- 6. Nhập mã chi nhánh và mã máy, cập nhật trạng thái hoạt động của máy

CREATE OR REPLACE FUNCTION f_ToggleTTHoatDong (
    p_MaCN IN TTMay.MaCN%TYPE,
    p_MaMay IN TTMay.MaMay%TYPE
)
RETURN CLOB
IS
    v_TTHoatDong NUMBER;
    v_return CLOB;
BEGIN
    SELECT TTHoatDong INTO v_TTHoatDong
    FROM TTMay
    WHERE MaCN = p_MaCN AND MaMay = p_MaMay;

    v_TTHoatDong := CASE WHEN v_TTHoatDong = 0 THEN 1 ELSE 0 END;

    UPDATE TTMay
    SET TTHoatDong = v_TTHoatDong
    WHERE MaCN = p_MaCN AND MaMay = p_MaMay;

    IF v_TTHoatDong = 1 THEN
        v_return := 'Máy ' || p_MaMay || ' tại chi nhánh ' || p_MaCN || ' đang hoạt động.';
    ELSE
        v_return := 'Máy ' || p_MaMay || ' tại chi nhánh ' || p_MaCN || ' đã dừng hoạt động.';
    END IF;

    RETURN v_return;
END;
/

ACCEPT MaCN CHAR PROMPT 'Nhập mã chi nhánh: ';
ACCEPT MaMay CHAR PROMPT 'Nhập mã máy: ';

DECLARE
    v_result CLOB;
BEGIN
    v_result := f_ToggleTTHoatDong('&MaCN', '&MaMay');
    dbms_output.put_line(v_result);
END;
/

--- 7. Nhập mã chi nhánh và mã máy, cập nhật trạng thái bận của máy

CREATE OR REPLACE FUNCTION f_ToggleTTBan (
    p_MaCN IN TTMay.MaCN%TYPE,
    p_MaMay IN TTMay.MaMay%TYPE
)
RETURN CLOB
IS
    v_TTBan NUMBER;
    v_return CLOB;
BEGIN
    SELECT TTBan INTO v_TTBan
    FROM TTMay
    WHERE MaCN = p_MaCN AND MaMay = p_MaMay;

    v_TTBan := CASE WHEN v_TTBan = 0 THEN 1 ELSE 0 END;

    UPDATE TTMay
    SET TTBan = v_TTBan
    WHERE MaCN = p_MaCN AND MaMay = p_MaMay;

    IF v_TTBan = 1 THEN
        v_return := 'Máy ' || p_MaMay || ' tại chi nhánh ' || p_MaCN || ' đã bận.';
    ELSE
        v_return := 'Máy ' || p_MaMay || ' tại chi nhánh ' || p_MaCN || ' đã trống.';
    END IF;

    RETURN v_return;
END;
/

ACCEPT MaCN CHAR PROMPT 'Nhập mã chi nhánh: ';
ACCEPT MaMay CHAR PROMPT 'Nhập mã máy: ';

DECLARE
    v_result CLOB;
BEGIN
    v_result := f_ToggleTTBan('&MaCN', '&MaMay');
    dbms_output.put_line(v_result);
END;
/

--- 8. Nhập mã chi nhánh và loại zone, hiển thị danh sách máy trống

CREATE OR REPLACE FUNCTION f_DSMayTrongCN (
    p_MaCN IN TTMay.MaCN%TYPE,
    p_LoaiZone IN TTMay.LoaiZone%TYPE
)
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT MaMay
        FROM TTMay
        WHERE MaCN = p_MaCN AND LoaiZone = p_LoaiZone AND TTBan = 0;
    RETURN v_cursor;
END;
/

ACCEPT maCN CHAR PROMPT 'Nhập mã chi nhánh: ';
ACCEPT loaiZone CHAR PROMPT 'Nhập loại Zone: ';

DECLARE
    v_MaCN TTMay.MaCN%TYPE := '&maCN';
    v_LoaiZone TTMay.LoaiZone%TYPE := '&loaiZone';
    v_machine TTMay.MaMay%TYPE;
    v_cursor SYS_REFCURSOR;
    v_hasMachines BOOLEAN := FALSE;
BEGIN
    v_cursor := f_DSMayTrongCN(v_MaCN, v_LoaiZone);
    dbms_output.put_line('Danh sách máy Zone ' || v_LoaiZone || ' tại chi nhánh ' || v_MaCN || ' đang trống:');

    LOOP
        FETCH v_cursor INTO v_machine;
        EXIT WHEN v_cursor%NOTFOUND;

        dbms_output.put_line(v_machine);
        v_hasMachines := TRUE;
    END LOOP;

    CLOSE v_cursor;

    IF NOT v_hasMachines THEN
        dbms_output.put_line('Không có máy nào trống.');
    END IF;
END;
/

--- 9. Nhập mã chi nhánh, hiển thị danh sách máy ngừng hoạt động

CREATE OR REPLACE FUNCTION f_DSMayDungHDCN (
    p_MaCN IN TTMay.MaCN%TYPE
)
RETURN SYS_REFCURSOR
IS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
        SELECT MaMay
        FROM TTMay
        WHERE MaCN = p_MaCN AND TTHoatDong = 0;
    RETURN v_cursor;
END;
/

ACCEPT maCN CHAR PROMPT 'Nhập mã chi nhánh: ';

DECLARE
    v_MaCN TTMay.MaCN%TYPE := '&maCN';
    v_machine TTMay.MaMay%TYPE;
    v_cursor SYS_REFCURSOR;
    v_inactive_count NUMBER := 0;
BEGIN
    v_cursor := f_DSMayDungHDCN(v_MaCN);
    dbms_output.put_line('Danh sách máy tại chi nhánh ' || v_MaCN || ' đang ngừng hoạt động:');

    LOOP
        FETCH v_cursor INTO v_machine;
        EXIT WHEN v_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_machine);
        v_inactive_count := v_inactive_count + 1;
    END LOOP;

    CLOSE v_cursor;

    IF v_inactive_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Không có máy nào');
    END IF;
END;
/

--- 10. Thêm bảo trì và chuyển trạng thái máy về không hoạt động

CREATE OR REPLACE FUNCTION f_ThemBaoTri (
    p_MaChiNhanh IN VARCHAR2,
    p_MaMay IN VARCHAR2,
    p_MaThietBi IN VARCHAR2,
    p_TrangThai IN CLOB,
    p_GhiChu IN CLOB
)
RETURN CLOB
IS
    v_result CLOB;
BEGIN
    INSERT INTO BaoTri(MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua)
    VALUES (p_MaChiNhanh, p_MaMay, p_MaThietBi, p_TrangThai, p_GhiChu, 0);

    UPDATE TTMay
    SET TTHoatDong = 0
    WHERE MaCN = p_MaChiNhanh AND MaMay = p_MaMay;

    COMMIT;

    v_result := 'Thêm bảo trì thành công.';
    RETURN v_result;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        v_result := 'Đã xảy ra lỗi: ' || SQLERRM;
        RETURN v_result;
END;
/

ACCEPT v_MaChiNhanh CHAR PROMPT 'Nhập mã chi nhánh: ';
ACCEPT v_MaMay CHAR PROMPT 'Nhập mã máy: ';
ACCEPT v_MaThietBi CHAR PROMPT 'Nhập mã thiết bị: ';
ACCEPT v_TrangThai CHAR PROMPT 'Nhập trạng thái: ';
ACCEPT v_GhiChu CHAR PROMPT 'Nhập ghi chú: ';

DECLARE
    v_result CLOB;
BEGIN
    v_result := f_ThemBaoTri('&v_MaChiNhanh', '&v_MaMay', '&v_MaThietBi', '&v_TrangThai', '&v_GhiChu');

    dbms_output.put_line('Kết quả: ' || v_result);
END;
/

--- 11. Hoàn thành bảo trì và set trạng thái máy hoạt động trở lại

CREATE OR REPLACE FUNCTION f_CapNhatTTSua (
    p_MaBaoTri IN VARCHAR2,
    p_MaCN IN VARCHAR2,
    p_MaMay IN VARCHAR2
)
RETURN CLOB
IS
    v_result CLOB;
BEGIN
    UPDATE BaoTri
    SET TTSua = 1
    WHERE MaBT = p_MaBaoTri AND TTSua = 0;

    UPDATE ttmay
    SET TTHoatDong = 1
    WHERE MaCN = p_MaCN AND MaMay = p_MaMay;

    COMMIT;

    v_result := 'Cập nhật bảo trì và trạng thái hoạt động thành công.';
    RETURN v_result;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        v_result := 'Đã xảy ra lỗi: ' || SQLERRM;
        RETURN v_result;
END;
/

ACCEPT v_MaBaoTri CHAR PROMPT 'Nhập mã bảo trì: ';
ACCEPT v_MaChiNhanh CHAR PROMPT 'Nhập mã chi nhánh: ';
ACCEPT v_MaMay CHAR PROMPT 'Nhập mã máy: ';

DECLARE
    v_MaBaoTri VARCHAR2(50) := '&v_MaBaoTri';
    v_MaCN VARCHAR2(50) := '&v_MaChiNhanh';
    v_MaMay VARCHAR2(50) := '&v_MaMay';
    v_result CLOB;
BEGIN
    v_result := f_CapNhatTTSua(v_MaBaoTri, v_MaCN, v_MaMay);
    dbms_output.put_line('Kết quả: ' || v_result);
END;
/

--- 12. Nhập sự kiện mới

CREATE OR REPLACE FUNCTION f_ThemSuKien (
    p_TenSK NVARCHAR2,
    p_MoTaSK CLOB,
    p_NgayBD DATE,
    p_NgayKT DATE,
    p_MaCN VARCHAR2
)
RETURN VARCHAR2
IS
    v_MaSK VARCHAR2(10);
    v_TenSK NVARCHAR2(100) := p_TenSK;
    v_MoTaSK CLOB := p_MoTaSK;
    v_NgayBD DATE := p_NgayBD;
    v_NgayKT DATE := p_NgayKT;
    v_TTToChuc NUMBER(1) := 0;
    v_MaCN VARCHAR2(10) := p_MaCN;
BEGIN
    v_MaSK := 'SK' || LPAD(MaSK_Seq.NEXTVAL, 4, '0');

    INSERT INTO SuKien (MaSK, TenSK, MoTaSK, NgayBD, NgayKT, TTToChuc, MaCN)
    VALUES (v_MaSK, v_TenSK, v_MoTaSK, v_NgayBD, v_NgayKT, v_TTToChuc, v_MaCN);

    COMMIT;
    RETURN 'Thêm sự kiện thành công.';
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'Đã xảy ra lỗi: ' || SQLERRM;
END;
/

ACCEPT NhapTenSK CHAR PROMPT 'Nhập tên sự kiện: ';
ACCEPT NhapMoTaSK CHAR PROMPT 'Nhập mô tả sự kiện: ';
ACCEPT NhapNgayBD CHAR PROMPT 'Nhập ngày bắt đầu (YYYY-MM-DD): ';
ACCEPT NhapNgayKT CHAR PROMPT 'Nhập ngày kết thúc (YYYY-MM-DD): ';
ACCEPT NhapMaCN CHAR PROMPT 'Nhập mã chi nhánh: ';

DECLARE
    v_TenSK NVARCHAR2(100) := '&NhapTenSK';
    v_MoTaSK CLOB := '&NhapMoTaSK';
    v_NgayBD DATE := TO_DATE('&NhapNgayBD', 'YYYY-MM-DD');
    v_NgayKT DATE := TO_DATE('&NhapNgayKT', 'YYYY-MM-DD');
    v_MaCN VARCHAR2(10) := '&NhapMaCN';
    v_result CLOB;
BEGIN
    v_result := f_ThemSuKien(v_TenSK, v_MoTaSK, v_NgayBD, v_NgayKT, v_MaCN);

    dbms_output.put_line('Kết quả: ' || v_result);
END;
/

--- 13. Nhập đặt chỗ mới

CREATE OR REPLACE FUNCTION f_ThemDatCho (
    p_TaiKhoan VARCHAR2,
    p_MaNV VARCHAR2,
    p_NgayDen DATE,
    p_YeuCau CLOB
)
RETURN VARCHAR2
IS
    v_MaDC VARCHAR2(10);
    v_NgayDat DATE := SYSDATE;
    v_NgayDen DATE := p_NgayDen;
    v_TaiKhoan VARCHAR2(30) := p_TaiKhoan;
    v_MaNV VARCHAR2(10) := p_MaNV;
    v_YeuCau CLOB := p_YeuCau;
BEGIN
    v_MaDC := 'DC' || LPAD(MaDC_Seq.NEXTVAL, 4, '0');

    INSERT INTO DatCho (MaDC, TaiKhoan, MaNV, NgayDat, NgayDen, YeuCau)
    VALUES (v_MaDC, v_TaiKhoan, v_MaNV, v_NgayDat, v_NgayDen, v_YeuCau);

    COMMIT;
    RETURN 'Thêm đặt chỗ thành công.';
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RETURN 'Đã xảy ra lỗi: ' || SQLERRM;
END;
/

ACCEPT NhapTaiKhoan CHAR PROMPT 'Nhập tài khoản: ';
ACCEPT NhapMaNV CHAR PROMPT 'Nhập mã nhân viên: ';
ACCEPT NhapYeuCau CHAR PROMPT 'Nhập yêu cầu: ';
ACCEPT NhapNgayDen CHAR PROMPT 'Nhập ngày đến (YYYY-MM-DD): ';

DECLARE
    v_TaiKhoan VARCHAR2(30) := '&NhapTaiKhoan';
    v_MaNV VARCHAR2(10) := '&NhapMaNV';
    v_YeuCau CLOB := '&NhapYeuCau';
    v_NgayDen DATE := TO_DATE('&NhapNgayDen', 'YYYY-MM-DD');
    v_result CLOB;
BEGIN
    v_result := f_ThemDatCho(v_TaiKhoan, v_MaNV, v_NgayDen, v_YeuCau);

    dbms_output.put_line('Kết quả: ' || v_Result);
END;
/

--- 14. Chi nhánh có doanh thu cao nhất tháng năm nhập từ bàn phím

CREATE OR REPLACE PROCEDURE p_CNDoanhThuCaoNhat(
    p_Nam IN NUMBER,
    p_Thang IN NUMBER
)
IS
    v_TenCN ChiNhanh.TenCN%TYPE;
    v_DoanhThuThang NUMBER;
    v_RecordFound BOOLEAN := FALSE;
BEGIN
    FOR c_rec IN (
        SELECT CN.TenCN, SUM(HD.TongTien) AS DoanhThuThang
        FROM ChiNhanh CN
        JOIN CTHoaDonInternet CTI ON CN.MaCN = CTI.MaCN
        JOIN HoaDon HD ON CTI.MaHD = HD.MaHD
        WHERE EXTRACT(MONTH FROM HD.NgayXuat) = p_Thang AND EXTRACT(YEAR FROM HD.NgayXuat) = p_Nam
        GROUP BY CN.TenCN
        ORDER BY SUM(HD.TongTien) DESC
    ) LOOP
        v_TenCN := c_rec.TenCN;
        v_DoanhThuThang := c_rec.DoanhThuThang;

        dbms_output.put_line('Chi nhánh có doanh thu cao nhất trong tháng: ' || v_TenCN);
        dbms_output.put_line('Doanh thu tháng: ' || TO_CHAR(v_DoanhThuThang));

        v_RecordFound := TRUE;
        EXIT;
    END LOOP;

    IF NOT v_RecordFound THEN
        dbms_output.put_line('Không có dữ liệu về doanh thu.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Đã xảy ra lỗi: ' || SQLERRM);
END;
/

ACCEPT NhapNam NUMBER PROMPT 'Nhập năm: ';
ACCEPT NhapThang NUMBER PROMPT 'Nhập tháng: ';

DECLARE
    v_Nam NUMBER := &NhapNam;
    v_Thang NUMBER := &NhapThang;
BEGIN
    p_CNDoanhThuCaoNhat(v_Nam, v_Thang);
END;
/

--- 15. Cập nhật hạng tài khoản (daily)

CREATE OR REPLACE PROCEDURE p_CapNhatHangTK AS
BEGIN
    FOR rec IN (SELECT * FROM KhachHang KH) LOOP
        IF rec.SoTienChiTieu >= 3000000 THEN
            UPDATE KhachHang
            SET MaHangTK = 'HTK6'
            WHERE TaiKhoan = rec.TaiKhoan;
        ELSIF rec.SoTienChiTieu >= 2000000 THEN
            UPDATE KhachHang
            SET MaHangTK = 'HTK5'
            WHERE TaiKhoan = rec.TaiKhoan;
        ELSIF rec.SoTienChiTieu >= 1500000 THEN
            UPDATE KhachHang
            SET MaHangTK = 'HTK4'
            WHERE TaiKhoan = rec.TaiKhoan;
        ELSIF rec.SoTienChiTieu >= 1000000 THEN
            UPDATE KhachHang
            SET MaHangTK = 'HTK3'
            WHERE TaiKhoan = rec.TaiKhoan;
        ELSIF rec.SoTienChiTieu >= 5000000 THEN
            UPDATE KhachHang
            SET MaHangTK = 'HTK2'
            WHERE TaiKhoan = rec.TaiKhoan;
        ELSE
            UPDATE KhachHang
            SET MaHangTK = 'HTK1'
            WHERE TaiKhoan = rec.TaiKhoan;
        END IF;
    END LOOP;
    COMMIT;
    dbms_output.put_line('Cập nhật hạng tài khoản thành công.');
END;
/

-- Tạo một job để thực hiện procedure hàng ngày lúc 2 giờ sáng
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name        => 'CapNhatHangTK_JOB',
        job_type        => 'PLSQL_BLOCK',
        job_action      => 'EXEC p_CapNhatHangTK;',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=2; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE
    );
END;
/

BEGIN
    DBMS_SCHEDULER.drop_job('CapNhatHangTK_JOB');
END;
/

--- 16. Truy vấn hoá đơn

CREATE OR REPLACE FUNCTION f_ChiTietHoaDon (
    p_MaHD CHAR
) RETURN CLOB AS
    v_Result CLOB;
    v_TongTienInternet NUMBER := 0;
    v_TongTienDVKhac NUMBER := 0;
    v_TongTienAnUong NUMBER := 0;
BEGIN
    v_Result := '';

    FOR HoaDonInfo IN (
        SELECT *
        FROM HoaDon
        WHERE MaHD = p_MaHD
    ) LOOP
        v_Result := v_Result || 'Thông tin hoá đơn ' || p_MaHD || CHR(10);
        v_Result := v_Result || 'Tài khoản: ' || HoaDonInfo.TaiKhoan || CHR(10);
        v_Result := v_Result || 'Nhân viên xuất: ' || HoaDonInfo.MaNV || CHR(10);
        v_Result := v_Result || 'Ngày xuất: ' || TO_CHAR(HoaDonInfo.NgayXuat, 'DD-MM-YYYY') || CHR(10);
        v_Result := v_Result || 'Tổng tiền: ' || TO_CHAR(HoaDonInfo.TongTien) || CHR(10);
        v_Result := v_Result || 'Ghi chú: ' || NVL(HoaDonInfo.GhiChu, 'Không có') || CHR(10) || CHR(10);
    END LOOP;

    v_Result := v_Result || 'Chi tiết dịch vụ Internet:' || CHR(10);
    FOR InternetInfo IN (
        SELECT *
        FROM CTHoaDonInternet
        WHERE MaHD = p_MaHD
    ) LOOP
        v_Result := v_Result || 'Mã máy: ' || InternetInfo.MaMay || ' | Mã chi nhánh: ' || InternetInfo.MaCN || ' | Số giờ: ' || TO_CHAR(InternetInfo.SoGio) || ' | Đơn giá theo giờ: ' || TO_CHAR(InternetInfo.DonGiaTheoGio) || ' | Chiết khấu: ' || InternetInfo.ChietKhau || CHR(10);
        v_TongTienInternet := v_TongTienInternet + (InternetInfo.SoGio * InternetInfo.DonGiaTheoGio * (1 - InternetInfo.ChietKhau));
    END LOOP;
    
    v_Result := v_Result || 'Chi tiết dịch vụ ăn uống:' || CHR(10);
    FOR AnUongInfo IN (
        SELECT *
        FROM CTHoaDonAnUong
        WHERE MaHD = p_MaHD
    ) LOOP
        v_Result := v_Result || 'Mã món: ' || AnUongInfo.MaMon || ' | SL: ' || TO_CHAR(AnUongInfo.SoLuong) || ' | Đơn giá: ' || TO_CHAR(AnUongInfo.DonGia) || ' | Chiết khấu: ' || AnUongInfo.ChietKhau || CHR(10);
        v_TongTienAnUong := v_TongTienAnUong + (AnUongInfo.SoLuong * AnUongInfo.DonGia * (1 - AnUongInfo.ChietKhau));
    END LOOP;

    v_Result := v_Result || 'Chi tiết dịch vụ khác:' || CHR(10);
    FOR DVKhacInfo IN (
        SELECT *
        FROM CTHoaDonDVKhac
        WHERE MaHD = p_MaHD
    ) LOOP
        v_Result := v_Result || 'Mã DV khác: ' || DVKhacInfo.MaDV || ' | Số giờ: ' || TO_CHAR(DVKhacInfo.SoGio) || 'Đơn giá theo giờ: ' || TO_CHAR(DVKhacInfo.DonGiaTheoGio) || ' | Chiết khấu: ' || DVKhacInfo.ChietKhau || CHR(10);
        v_TongTienDVKhac := v_TongTienDVKhac + (DVKhacInfo.SoGio * DVKhacInfo.DonGiaTheoGio * (1 - DVKhacInfo.ChietKhau));
    END LOOP;

    v_Result := v_Result || CHR(10) || 'Tổng tiền dịch vụ Internet: ' || TO_CHAR(v_TongTienInternet) || CHR(10);
    v_Result := v_Result || 'Tổng tiền dịch vụ ăn uống: ' || TO_CHAR(v_TongTienAnUong) || CHR(10);
    v_Result := v_Result || 'Tổng tiền dịch vụ khác: ' || TO_CHAR(v_TongTienDVKhac);

    RETURN v_Result;
END;
/

ACCEPT v_MaHD CHAR PROMPT 'Nhập mã hoá đơn: ';

DECLARE
    v_result CLOB;
    v_MaHD VARCHAR2(10) := '&v_MaHD';
BEGIN
    v_result := f_ChiTietHoaDon(v_MaHD);
    dbms_output.put_line(v_result);
END;
/