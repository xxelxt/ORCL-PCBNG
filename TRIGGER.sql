---------------
--- TRIGGER ---
---------------

CREATE OR REPLACE TRIGGER tr_KTTuoiNhanVien
BEFORE INSERT OR UPDATE ON NhanVien
FOR EACH ROW
DECLARE
    employeeAge NUMBER;
BEGIN
    employeeAge := TRUNC(MONTHS_BETWEEN(SYSDATE, :NEW.NgaySinh) / 12);

    IF employeeAge < 18 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nhan vien phai tren 18 tuoi.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_KTSDTNhanVien
BEFORE INSERT OR UPDATE ON NhanVien
FOR EACH ROW
DECLARE
    prefix CHAR(2);
BEGIN
    prefix := SUBSTR(:NEW.SDTNV, 1, 2);

    IF prefix NOT IN ('03', '05', '07', '08', '09') THEN
        RAISE_APPLICATION_ERROR(-20001, 'So dien thoai khong hop le.');
    END IF;

    IF LENGTH(:NEW.SDTNV) > 10 THEN
        RAISE_APPLICATION_ERROR(-20002, 'So dien thoai khong qua 10 chu so');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_KTSDTKhachHang
BEFORE INSERT OR UPDATE ON KhachHang
FOR EACH ROW
DECLARE
    prefix CHAR(2);
BEGIN
    prefix := SUBSTR(:NEW.SDTKH, 1, 2);

    IF prefix NOT IN ('03', '05', '07', '08', '09') THEN
        RAISE_APPLICATION_ERROR(-20001, 'So dien thoai khong hop le.');
    END IF;

    IF LENGTH(:NEW.SDTKH) > 10 THEN
        RAISE_APPLICATION_ERROR(-20002, 'So dien thoai khong qua 10 chu so');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_KTEmailNhanVien
BEFORE INSERT OR UPDATE ON NhanVien
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.EmailNV, '^[A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email nhan vien khong dung dinh dang.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_KTEmailKhachHang
BEFORE INSERT OR UPDATE ON KhachHang
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.EmailKH, '^[A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Email khach hang khong dung dinh dang');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_TTGioiHanKhachHang
BEFORE INSERT OR UPDATE ON KhachHang
FOR EACH ROW
BEGIN
    IF EXTRACT(YEAR FROM :NEW.NgaySinh) > EXTRACT(YEAR FROM SYSDATE) - 18 THEN
        :NEW.TTGioiHan := 1;
    ELSE
        :NEW.TTGioiHan := 0;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_CapNhatChiTieu_Insert
AFTER INSERT ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE
        v_TongTien NUMBER;
    BEGIN
        v_TongTien := :NEW.TongTien;

        UPDATE KhachHang
        SET SoTienChiTieu = SoTienChiTieu + v_TongTien
        WHERE TaiKhoan = :NEW.TaiKhoan;
    END;
END;
/

CREATE OR REPLACE TRIGGER tr_CapNhatChiTieu_Delete
AFTER DELETE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE
        v_TongTien NUMBER;
    BEGIN
        v_TongTien := :OLD.TongTien;

        UPDATE KhachHang
        SET SoTienChiTieu = SoTienChiTieu - v_TongTien
        WHERE TaiKhoan = :OLD.TaiKhoan;
    END;
END;
/

CREATE OR REPLACE TRIGGER tr_CapNhatChiTieu_Update
AFTER UPDATE ON HoaDon
FOR EACH ROW
BEGIN
    DECLARE
        v_TongTienCu NUMBER;
        v_TongTienMoi NUMBER;
    BEGIN
        v_TongTienCu := :OLD.TongTien;
        v_TongTienMoi := :NEW.TongTien;

        UPDATE KhachHang
        SET SoTienChiTieu = SoTienChiTieu - v_TongTienCu + v_TongTienMoi
        WHERE TaiKhoan = :NEW.TaiKhoan;
    END;
END;
/