--- PCBANG ORACLE DATABASE ---

-------------------------------------------------
--- CREATE SEQUENCE, TABLE AND INSERT RECORDS ---
-------------------------------------------------

--- TABLE ChiNhanh ---

CREATE TABLE ChiNhanh (
    MaCN VARCHAR2(10) PRIMARY KEY,
    TenCN NVARCHAR2(50) NOT NULL,
    DiaChiCN NVARCHAR2(100) NOT NULL,
    SDTCN CHAR(10) NOT NULL CHECK (REGEXP_LIKE(SDTCN, '^[0-9]*$'))
);

CREATE SEQUENCE MaCN_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER ChiNhanh_BI
BEFORE INSERT ON ChiNhanh
FOR EACH ROW
BEGIN
    SELECT 'CN' || TO_CHAR(MaCN_Seq.NEXTVAL) INTO :NEW.MaCN FROM dual;
END;
/

INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Trương Công Giai', '1 Trương Công Giai, Cầu Giấy, Hà Nội', '0123456789');
INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Khâm Thiên', '195 Khâm Thiên, Đống Đa, Hà Nội', '0987654321');
INSERT INTO ChiNhanh (TenCN, DiaChiCN, SDTCN)
VALUES ('Spartacus Thái Hà', '47 Thái Hà, Đống Đa, Hà Nội', '0123456789');

--- TABLE ViTriCV ---

CREATE TABLE ViTriCV (
    MaCV VARCHAR2(10) PRIMARY KEY,
    TenCV NVARCHAR2(50) NOT NULL,
    MoTaCV NVARCHAR2(100)
);

CREATE SEQUENCE MaCV_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER ViTriCV_BI
BEFORE INSERT ON ViTriCV
FOR EACH ROW
BEGIN
    SELECT 'CV' || TO_CHAR(MaCV_Seq.NEXTVAL) INTO :NEW.MaCV FROM dual;
END;
/

INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Giám đốc', 'Chủ kinh doanh');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Quản lý', 'Quản lý chi nhánh');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Nhân viên quầy', 'Nhân viên hỗ trợ');
INSERT INTO ViTriCV (TenCV, MoTaCV) VALUES ('Nhân viên bếp', 'Nhân viên bar');

--- TABLE BoPhan ---

CREATE TABLE BoPhan (
    MaBP VARCHAR2(10) PRIMARY KEY,
    TenBP NVARCHAR2(50) NOT NULL
);

CREATE SEQUENCE MaBP_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER BoPhan_BI
BEFORE INSERT ON BoPhan
FOR EACH ROW
BEGIN
    SELECT 'BP' || TO_CHAR(MaBP_Seq.NEXTVAL) INTO :NEW.MaBP FROM dual;
END;
/

INSERT INTO BoPhan (TenBP) VALUES ('Quản lý chung');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận internet');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận quầy bar và bếp');
INSERT INTO BoPhan (TenBP) VALUES ('Bộ phận dịch vụ khác');

--- TABLE Luong ---

CREATE TABLE Luong (
    BacLuong NUMBER(2) PRIMARY KEY CHECK (BacLuong > 0),
    HeSoLuong NUMBER NOT NULL CHECK (HeSoLuong > 0),
    LuongCoBan NUMBER NOT NULL CHECK (LuongCoBan > 0),
    PhuCap NUMBER NOT NULL CHECK (PhuCap >= 0)
);

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

--- TABLE HangTK ---

CREATE TABLE HangTK (
    MaHangTK VARCHAR2(10) PRIMARY KEY,
    TenHangTK NVARCHAR2(30) NOT NULL,
    MucChiTieu NUMBER NOT NULL CHECK (MucChiTieu >= 0),
    MucChietKhau NUMBER(5, 2) NOT NULL CHECK (MucChietKhau >= 0 AND MucChietKhau <= 100)
);

CREATE SEQUENCE MaHangTK_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER HangTK_BI
BEFORE INSERT ON HangTK
FOR EACH ROW
BEGIN
    SELECT 'HTK' || TO_CHAR(MaHangTK_Seq.NEXTVAL) INTO :NEW.MaHangTK FROM dual;
END;
/

INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Thường', 0, 0);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Bạc', 5000000, 5);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Vàng', 1000000, 10);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Bạch kim', 1500000, 15);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Kim cương', 2000000, 20);
INSERT INTO HangTK (TenHangTK, MucChiTieu, MucChietKhau) VALUES ('Vô địch', 3000000, 25);

--- TABLE NhanVien ---

CREATE TABLE NhanVien (
    MaNV VARCHAR2(10) PRIMARY KEY,
    TenNV NVARCHAR2(50) NOT NULL CHECK (NOT REGEXP_LIKE(TenNV, '[0-9]')),
    GioiTinh NUMBER(1) NOT NULL CHECK (GioiTinh IN (0, 1)),
    NgaySinh DATE NOT NULL,
    SoCCCD CHAR(12) NOT NULL CHECK (REGEXP_LIKE(SoCCCD, '^[0-9]*$')),
    SDTNV CHAR(10) NOT NULL CHECK (REGEXP_LIKE(SDTNV, '^[0-9]*$')),
    EmailNV VARCHAR2(30) NOT NULL,
    DiaChiNV NVARCHAR2(100) NOT NULL,
    AnhNV CLOB,
    NgayVaoLam DATE NOT NULL,
    NgayNghiViec DATE,
    MaCV VARCHAR2(10) REFERENCES ViTriCV(MaCV),
    MaCN VARCHAR2(10) REFERENCES ChiNhanh(MaCN),
    MaBP VARCHAR2(10) REFERENCES BoPhan(MaBP),
    BacLuong NUMBER(2) REFERENCES Luong(BacLuong)
);

CREATE SEQUENCE MaNV_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER NhanVien_BI
BEFORE INSERT ON NhanVien
FOR EACH ROW
BEGIN
    SELECT 'NV' || TO_CHAR(MaNV_Seq.NEXTVAL) INTO :NEW.MaNV FROM dual;
END;
/

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

--- TABLE KhachHang ---

CREATE TABLE KhachHang (
    TaiKhoan VARCHAR2(30) PRIMARY KEY,
    MatKhau VARCHAR2(30) NOT NULL,
    TenKH NVARCHAR2(50) NOT NULL CHECK (NOT REGEXP_LIKE(TenKH, '[0-9]')),
    GioiTinh NUMBER(1) NOT NULL CHECK (GioiTinh IN (0, 1)),
    NgaySinh DATE NOT NULL,
    SoCCCD CHAR(12) NOT NULL CHECK (REGEXP_LIKE(SoCCCD, '^[0-9]*$')),
    SDTKH CHAR(10) NOT NULL CHECK (REGEXP_LIKE(SDTKH, '^[0-9]*$')),
    EmailKH VARCHAR2(30) NOT NULL,
    DiaChiKH NVARCHAR2(100) NOT NULL,
    TTGioiHan NUMBER(1) NOT NULL CHECK (TTGioiHan IN (0, 1)),
    SoTienDangCo NUMBER NOT NULL CHECK (SoTienDangCo >= 0),
    SoTienChiTieu NUMBER NOT NULL CHECK (SoTienChiTieu >= 0),
    AnhKH CLOB,
    MaHangTK VARCHAR2(10) REFERENCES HangTK(MaHangTK)
);

CREATE SEQUENCE MaKH_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER KhachHang_BI
BEFORE INSERT ON KhachHang
FOR EACH ROW
BEGIN
    SELECT 'tk' || TO_CHAR(MaKH_Seq.NEXTVAL) INTO :NEW.TaiKhoan FROM dual;
END;
/

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

--- TABLE GDNapTien ---

CREATE TABLE GDNapTien (
    MaGD VARCHAR2(10) PRIMARY KEY,
    TaiKhoan VARCHAR2(30) NOT NULL,
    MaNV VARCHAR2(10) NOT NULL,
    SoTienNap NUMBER NOT NULL CHECK (SoTienNap >= 0),
    FOREIGN KEY (TaiKhoan) REFERENCES KhachHang(TaiKhoan),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE SEQUENCE MaGD_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER GDNapTien_BI
BEFORE INSERT ON GDNapTien
FOR EACH ROW
BEGIN
    SELECT 'GD' || TO_CHAR(MaGD_Seq.NEXTVAL) INTO :NEW.MaGD FROM dual;
END;
/

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

--- TABLE Zone ---

CREATE TABLE Zone (
    LoaiZone VARCHAR2(10) PRIMARY KEY,
    TenZone VARCHAR2(30) NOT NULL,
    MucGiaTheoGio NUMBER NOT NULL CHECK (MucGiaTheoGio >= 0),
    TSKT CLOB NOT NULL
);

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

--- TABLE TTMay ---

CREATE TABLE TTMay (
    MaMay VARCHAR2(10),
    MaCN VARCHAR2(10) REFERENCES ChiNhanh(MaCN),
    LoaiZone VARCHAR2(10) REFERENCES Zone(LoaiZone),
    TTHoatDong NUMBER(1) NOT NULL CHECK (TTHoatDong IN (0, 1)),
    TTBan NUMBER(1) NOT NULL CHECK (TTBan IN (0, 1)),
    PRIMARY KEY (MaMay, MaCN)
);

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

--- TABLE PLDVAnUong ---

CREATE TABLE PLDVAnUong (
    MaPL VARCHAR2(10) PRIMARY KEY,
    TenPL NVARCHAR2(50) NOT NULL
);

CREATE SEQUENCE MaPLDV_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER PLDVAnUong_BI
BEFORE INSERT ON PLDVAnUong
FOR EACH ROW
BEGIN
    SELECT 'PL' || TO_CHAR(MaPLDV_Seq.NEXTVAL) INTO :NEW.MaPL FROM dual;
END;
/

INSERT INTO PLDVAnUong (TenPL) VALUES ('Đồ uống');
INSERT INTO PLDVAnUong (TenPL) VALUES ('Đồ ăn');
INSERT INTO PLDVAnUong (TenPL) VALUES ('Combo');

--- TABLE DVAnUong ---

CREATE TABLE DVAnUong (
    MaMon VARCHAR2(10) PRIMARY KEY,
    TenMon NVARCHAR2(50) NOT NULL,
    GiaMon NUMBER NOT NULL CHECK (GiaMon >= 0),
    AnhMon CLOB,
    MaPL VARCHAR2(10) NOT NULL REFERENCES PLDVAnUong(MaPL)
);

CREATE SEQUENCE MaDVAU_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER DVAnUong_BI
BEFORE INSERT ON DVAnUong
FOR EACH ROW
BEGIN
    SELECT 'DVAU' || TO_CHAR(MaDVAU_Seq.NEXTVAL) INTO :NEW.MaMon FROM dual;
END;
/

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

--- TABLE DVKhac ---

CREATE TABLE DVKhac (
    MaDV VARCHAR2(10) PRIMARY KEY,
    TenDV NVARCHAR2(50) NOT NULL,
    MucGiaTheoGio NUMBER NOT NULL CHECK (MucGiaTheoGio >= 0)
);

CREATE SEQUENCE MaDVK_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER DVKhac_BI
BEFORE INSERT ON DVKhac
FOR EACH ROW
BEGIN
    SELECT 'DVK' || TO_CHAR(MaDVK_Seq.NEXTVAL) INTO :NEW.MaDV FROM dual;
END;
/

INSERT INTO DVKhac (TenDV, MucGiaTheoGio) VALUES ('Billards', 20000);
INSERT INTO DVKhac (TenDV, MucGiaTheoGio) VALUES ('Karaoke', 30000);

--- TABLE HoaDon ---

CREATE TABLE HoaDon (
    MaHD VARCHAR2(10) PRIMARY KEY,
    TaiKhoan VARCHAR2(30) REFERENCES KhachHang(TaiKhoan),
    MaNV VARCHAR2(10) REFERENCES NhanVien(MaNV),
    NgayXuat DATE NOT NULL,
    TongTien NUMBER NOT NULL CHECK (TongTien >= 0),
    GhiChu CLOB
);

CREATE SEQUENCE MaHD_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER HoaDon_BI
BEFORE INSERT ON HoaDon
FOR EACH ROW
BEGIN
    SELECT 'HD' || TO_CHAR(MaHD_Seq.NEXTVAL) INTO :NEW.MaHD FROM dual;
END;
/

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk1', 'NV1', TO_DATE('2022-10-08', 'YYYY-MM-DD'), 75000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk2', 'NV6', TO_DATE('2022-12-02', 'YYYY-MM-DD'), 69000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk5', 'NV5', TO_DATE('2022-11-03', 'YYYY-MM-DD'), 40000, NULL);

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk4', 'NV7', TO_DATE('2023-03-04', 'YYYY-MM-DD'), 87000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk3', 'NV5', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 30000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk2', 'NV6', TO_DATE('2023-02-23', 'YYYY-MM-DD'), 88000, NULL);

INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk1', 'NV6', TO_DATE('2023-06-05', 'YYYY-MM-DD'), 135000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk7', 'NV7', TO_DATE('2022-11-27', 'YYYY-MM-DD'), 51000, NULL);
INSERT INTO HoaDon (TaiKhoan, MaNV, NgayXuat, TongTien, GhiChu) VALUES ('tk6', 'NV4', TO_DATE('2023-04-15', 'YYYY-MM-DD'), 32000, NULL);

--- TABLE CTHoaDonInternet ---

CREATE TABLE CTHoaDonInternet (
    MaHD VARCHAR2(10),
    MaMay VARCHAR2(10),
    MaCN VARCHAR2(10),
    SoGio NUMBER NOT NULL CHECK (SoGio > 0),
    DonGiaTheoGio NUMBER NOT NULL CHECK (DonGiaTheoGio >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaMay, MaCN),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaMay, MaCN) REFERENCES TTMay(MaMay, MaCN)
);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD1', 'STR002', 'CN1', 2, 20000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD2', 'FPS001', 'CN2', 3, 10000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD3', 'STA001', 'CN1', 5, 8000, 0);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD4', 'COU003', 'CN3', 2, 16000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD5', 'FPS002', 'CN1', 3, 10000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD6', 'VIP001', 'CN2', 4, 12000, 0);

INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD7', 'PES002', 'CN2', 3, 20000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD8', 'VIP002', 'CN3', 3, 12000, 0);
INSERT INTO CTHoaDonInternet (MaHD, MaMay, MaCN, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD9', 'STA002', 'CN3', 2, 12000, 0);

--- TABLE CTHoaDonDVKhac ---

CREATE TABLE CTHoaDonDVKhac (
    MaHD VARCHAR2(10),
    MaDV VARCHAR2(10),
    SoGio NUMBER NOT NULL CHECK (SoGio > 0),
    DonGiaTheoGio NUMBER NOT NULL CHECK (DonGiaTheoGio >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaDV),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaDV) REFERENCES DVKhac(MaDV)
);

INSERT INTO CTHoaDonDVKhac (MaHD, MaDV, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD7', 'DVK1', 2, 20000, 0);
INSERT INTO CTHoaDonDVKhac (MaHD, MaDV, SoGio, DonGiaTheoGio, ChietKhau) VALUES ('HD2', 'DVK2', 1, 30000, 20);

--- TABLE CTHoaDonAnUong ---

CREATE TABLE CTHoaDonAnUong (
    MaHD VARCHAR2(10),
    MaMon VARCHAR2(10),
    SoLuong NUMBER NOT NULL CHECK (SoLuong > 0),
    DonGia NUMBER NOT NULL CHECK (DonGia >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaMon),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaMon) REFERENCES DVAnUong(MaMon)
);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD1', 'DVAU2', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD2', 'DVAU1', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD4', 'DVAU10', 1, 55000, 0);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD6', 'DVAU8', 1, 40000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD7', 'DVAU6', 2, 10000, 0);

INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD7', 'DVAU2', 1, 15000, 0);
INSERT INTO CTHoaDonAnUong (MaHD, MaMon, SoLuong, DonGia, ChietKhau) VALUES ('HD8', 'DVAU4', 1, 15000, 0);

--- TABLE ThietBi ---
CREATE TABLE ThietBi (
    MaTB VARCHAR2(10) PRIMARY KEY,
    TenTB NVARCHAR2(50) NOT NULL
);

CREATE SEQUENCE MaTB_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;


CREATE OR REPLACE TRIGGER ThietBi_BI
BEFORE INSERT ON ThietBi
FOR EACH ROW
BEGIN
    SELECT 'TB' || TO_CHAR(MaTB_Seq.NEXTVAL) INTO :NEW.MaTB FROM dual;
END;
/

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

--- TABLE BaoTri ---

CREATE TABLE BaoTri (
    MaBT VARCHAR2(10) PRIMARY KEY,
    MaCN VARCHAR2(10),
    MaMay VARCHAR2(10),
    MaTB VARCHAR2(10) REFERENCES ThietBi(MaTB),
    TinhTrang CLOB NOT NULL,
    GhiChu CLOB,
    TTSua NUMBER(1) NOT NULL CHECK (TTSua IN (0, 1)),
    FOREIGN KEY (MaCN, MaMay) REFERENCES TTMay(MaCN, MaMay)
);

CREATE SEQUENCE MaBT_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER BaoTri_BI
BEFORE INSERT ON BaoTri
FOR EACH ROW
BEGIN
    SELECT 'BT' || TO_CHAR(MaBT_Seq.NEXTVAL) INTO :NEW.MaBT FROM dual;
END;
/

INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'VIP003', 'TB3', 'Lỗi RAM', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN2', 'STR002', 'TB3', 'Lỗi RAM', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'STA005', 'TB4', 'Lỗi VGA', NULL, 1);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN1', 'COU001', 'TB4', 'Lỗi VGA', NULL, 0);
INSERT INTO BaoTri (MaCN, MaMay, MaTB, TinhTrang, GhiChu, TTSua) VALUES ('CN3', 'STA002', 'TB6', 'Bàn phím bị kẹt', NULL, 1);

--- TABLE SuKien ---

CREATE TABLE SuKien (
    MaSK VARCHAR2(10) PRIMARY KEY,
    TenSK NVARCHAR2(100) NOT NULL,
    MoTaSK CLOB,
    NgayBD DATE NOT NULL,
    NgayKT DATE NOT NULL,
    TTToChuc NUMBER(1) NOT NULL CHECK (TTToChuc IN (0, 1)),
    MaCN VARCHAR2(10) REFERENCES ChiNhanh(MaCN),
    CONSTRAINT Check_NgayKT_NgayBD CHECK (NgayKT >= NgayBD)
);

CREATE SEQUENCE MaSK_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER SuKien_BI
BEFORE INSERT ON SuKien
FOR EACH ROW
BEGIN
    SELECT 'SK' || TO_CHAR(MaSK_Seq.NEXTVAL) INTO :NEW.MaSK FROM dual;
END;
/

INSERT INTO SuKien (TenSK, MoTaSK, NgayBD, NgayKT, TTToChuc, MaCN) VALUES ('Spartacus Cyber Cup TFT T9', 'Giải Teamfight Tactics Tier C', TO_DATE('2023-09-14', 'YYYY-MM-DD'), TO_DATE('2023-09-24', 'YYYY-MM-DD'), 1, 'CN1');
INSERT INTO SuKien (TenSK, MoTaSK, NgayBD, NgayKT, TTToChuc, MaCN) VALUES ('Valorant Campus Cyber Cup 2023', 'Sân chơi dành riêng cho các bạn học sinh đam mê eSports với tổng giá trị giải thưởng lên đến 8 triệu VNĐ', TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-06-04', 'YYYY-MM-DD'), 1, 'CN2');

--- TABLE ThamGiaSuKien ---

CREATE TABLE ThamGiaSuKien (
    MaSK VARCHAR2(10),
    TaiKhoan VARCHAR2(30),
    UuDai CLOB,
    PRIMARY KEY (MaSK, TaiKhoan),
    FOREIGN KEY (MaSK) REFERENCES SuKien(MaSK),
    FOREIGN KEY (TaiKhoan) REFERENCES KhachHang(TaiKhoan)
);

INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk1', 'Giảm 50% giá đến ngày 17/1/2024');
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk2', NULL);
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK1', 'tk4', NULL);

INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk2', NULL);
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk3', 'Tặng 2 triệu vật phẩm trong game Valorant');
INSERT INTO ThamGiaSuKien (MaSK, TaiKhoan, UuDai) VALUES ('SK2', 'tk5', 'Tặng 1 triệu vật phẩm trong game Valorant');

--- TABLE DatCho ---

CREATE TABLE DatCho (
    MaDC VARCHAR2(10) PRIMARY KEY,
    TaiKhoan VARCHAR2(30) REFERENCES KhachHang(TaiKhoan),
    MaNV VARCHAR2(10) REFERENCES NhanVien(MaNV),
    NgayDat DATE NOT NULL,
    NgayDen DATE NOT NULL,
    YeuCau CLOB NOT NULL,
    CONSTRAINT Check_NgayDen_NgayDat CHECK (NgayDen >= NgayDat)
);

CREATE SEQUENCE MaDC_Seq
  START WITH 1
  INCREMENT BY 1
  NOMAXVALUE;

CREATE OR REPLACE TRIGGER DatCho_BI
BEFORE INSERT ON DatCho
FOR EACH ROW
BEGIN
    SELECT 'DC' || TO_CHAR(MaDC_Seq.NEXTVAL) INTO :NEW.MaDC FROM dual;
END;
/

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

--- Nếu loại bỏ bảng phải drop cả table và sequence để reset sequence ---

DROP SEQUENCE MaCN_Seq;
DROP SEQUENCE MaCV_Seq;
DROP SEQUENCE MaBP_Seq;
DROP SEQUENCE MaHangTK_Seq;
DROP SEQUENCE MaNV_Seq;
DROP SEQUENCE MaKH_Seq;
DROP SEQUENCE MaGD_Seq;
DROP SEQUENCE MaPLDV_Seq;
DROP SEQUENCE MaDVAU_Seq;
DROP SEQUENCE MaDVK_Seq;
DROP SEQUENCE MaHD_Seq;
DROP SEQUENCE MaTB_Seq;
DROP SEQUENCE MaBT_Seq;
DROP SEQUENCE MaSK_Seq;
DROP SEQUENCE MaDC_Seq;

DROP TABLE DatCho;
DROP TABLE ThamGiaSuKien;
DROP TABLE SuKien;
DROP TABLE BaoTri;
DROP TABLE ThietBi;
DROP TABLE CTHoaDonAnUong;
DROP TABLE CTHoaDonDVKhac;
DROP TABLE CTHoaDonInternet;
DROP TABLE HoaDon;
DROP TABLE DVAnUong;
DROP TABLE DVKhac;
DROP TABLE PLDVAnUong;
DROP TABLE TTMay;
DROP TABLE Zone;
DROP TABLE GDNapTien;
DROP TABLE KhachHang;
DROP TABLE NhanVien;
DROP TABLE HangTK;
DROP TABLE Luong;
DROP TABLE BoPhan;
DROP TABLE ViTriCV;
DROP TABLE ChiNhanh;

------------------
--- TABLESPACE ---
------------------

CREATE TABLESPACE T1
  DATAFILE 'pcbang_df1.dbf' SIZE 500M AUTOEXTEND ON NEXT 100M
  MAXSIZE 2G
  LOGGING
  DEFAULT STORAGE (
    INITIAL 100M
    NEXT 100M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
    PCTINCREASE 0
  )
  ONLINE;

CREATE TABLESPACE T2
  DATAFILE 'pcbang_df2.dbf' SIZE 1G AUTOEXTEND ON NEXT 200M
  MAXSIZE 4G
  LOGGING
  DEFAULT STORAGE (
    INITIAL 200M
    NEXT 200M
    MINEXTENTS 1
    MAXEXTENTS UNLIMITED
    PCTINCREASE 0
  )
  ONLINE;

ALTER TABLE ChiNhanh MOVE TABLESPACE T1;
ALTER TABLE NhanVien MOVE TABLESPACE T1;
ALTER TABLE ViTriCV MOVE TABLESPACE T1;
ALTER TABLE Luong MOVE TABLESPACE T1;
ALTER TABLE BoPhan MOVE TABLESPACE T1;
ALTER TABLE HangTK MOVE TABLESPACE T1;
ALTER TABLE Zone MOVE TABLESPACE T1;
ALTER TABLE DVAnUong MOVE TABLESPACE T1;
ALTER TABLE PLDVAnUong MOVE TABLESPACE T1;
ALTER TABLE DVKhac MOVE TABLESPACE T1;
ALTER TABLE ThietBi MOVE TABLESPACE T1;

ALTER TABLE KhachHang MOVE TABLESPACE T2;
ALTER TABLE TTMay MOVE TABLESPACE T2;
ALTER TABLE HoaDon MOVE TABLESPACE T2;
ALTER TABLE CTHoaDonInternet MOVE TABLESPACE T2;
ALTER TABLE CTHoaDonAnUong MOVE TABLESPACE T2;
ALTER TABLE CTHoaDonDVKhac MOVE TABLESPACE T2;
ALTER TABLE BaoTri MOVE TABLESPACE T2;
ALTER TABLE SuKien MOVE TABLESPACE T2;
ALTER TABLE ThamGiaSuKien MOVE TABLESPACE T2;
ALTER TABLE DatCho MOVE TABLESPACE T2;
ALTER TABLE GDNapTien MOVE TABLESPACE T2;

SELECT table_name, tablespace_name
FROM all_tables
WHERE tablespace_name in ('T1', 'T2');

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

--------------------------
--- USERS & PRIVILEGES ---
--------------------------

SELECT object_name, object_type
FROM all_objects
WHERE object_type IN ('TABLE', 'VIEW', 'FUNCTION', 'PROCEDURE') AND owner = 'C##PCBANG';

--- Admin

CREATE USER C##QTV IDENTIFIED BY 12345
  DEFAULT TABLESPACE T2
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON T1;

GRANT CONNECT, RESOURCE, CREATE SESSION TO C##QTV;
GRANT DBA TO C##QTV;

--- Giám đốc / Chủ kinh doanh

CREATE USER C##GD IDENTIFIED BY 12345
  DEFAULT TABLESPACE T2
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON T1;

GRANT CONNECT, RESOURCE, CREATE SESSION TO C##GD;

BEGIN
  FOR t IN (SELECT object_name FROM all_objects WHERE object_type = 'TABLE' AND owner = 'C##PCBANG') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT ON C##PCBANG.' || t.object_name || ' TO C##GD';
  END LOOP;
END;
/

BEGIN
  FOR proc IN (SELECT object_name FROM all_objects WHERE object_type IN ('PROCEDURE', 'FUNCTION') AND owner = 'C##PCBANG') LOOP
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON C##PCBANG.' || proc.object_name || ' TO C##GD';
  END LOOP;
END;
/

--- Quản lý

CREATE USER C##QuanLy IDENTIFIED BY 12345
  DEFAULT TABLESPACE T2
  TEMPORARY TABLESPACE TEMP
  QUOTA UNLIMITED ON T1;

GRANT CONNECT, RESOURCE, CREATE SESSION TO C##QuanLy;

GRANT SELECT, INSERT ON KhachHang TO C##QuanLy;
GRANT SELECT, INSERT ON TTMay TO C##QuanLy;
GRANT SELECT, INSERT ON HoaDon TO C##QuanLy;
GRANT SELECT, INSERT ON CTHoaDonInternet TO C##QuanLy;
GRANT SELECT, INSERT ON CTHoaDonAnUong TO C##QuanLy;
GRANT SELECT, INSERT ON CTHoaDonDVKhac TO C##QuanLy;
GRANT SELECT, INSERT ON BaoTri TO C##QuanLy;
GRANT SELECT, INSERT ON SuKien TO C##QuanLy;
GRANT SELECT, INSERT ON ThamGiaSuKien TO C##QuanLy;
GRANT SELECT, INSERT ON DatCho TO C##QuanLy;
GRANT SELECT, INSERT ON GDNapTien TO C##QuanLy;

GRANT SELECT, INSERT ON NhanVien TO C##QuanLy;
GRANT SELECT, INSERT ON ViTriCV TO C##QuanLy;

GRANT SELECT ON ChiNhanh TO C##QuanLy;
GRANT SELECT ON Luong TO C##QuanLy;
GRANT SELECT ON BoPhan TO C##QuanLy;
GRANT SELECT ON HangTK TO C##QuanLy;
GRANT SELECT ON Zone TO C##QuanLy;
GRANT SELECT ON DVAnUong TO C##QuanLy;
GRANT SELECT ON PLDVAnUong TO C##QuanLy;
GRANT SELECT ON DVKhac TO C##QuanLy;
GRANT SELECT ON ThietBi TO C##QuanLy;

BEGIN
  FOR proc IN (SELECT object_name FROM all_objects WHERE object_type IN ('PROCEDURE', 'FUNCTION') AND owner = 'C##PCBANG') LOOP
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON C##PCBANG.' || proc.object_name || ' TO C##QuanLy';
  END LOOP;
END;
/

--- Nhân viên quầy

CREATE USER C##NVQuay IDENTIFIED BY 12345 DEFAULT TABLESPACE T2 TEMPORARY TABLESPACE temp;

GRANT CONNECT, RESOURCE, CREATE SESSION TO C##NVQuay;

GRANT SELECT, INSERT ON KhachHang TO C##NVQuay;
GRANT SELECT, INSERT ON TTMay TO C##NVQuay;
GRANT SELECT, INSERT ON HoaDon TO C##NVQuay;
GRANT SELECT, INSERT ON CTHoaDonInternet TO C##NVQuay;
GRANT SELECT, INSERT ON CTHoaDonAnUong TO C##NVQuay;
GRANT SELECT, INSERT ON CTHoaDonDVKhac TO C##NVQuay;
GRANT SELECT, INSERT ON BaoTri TO C##NVQuay;
GRANT SELECT, INSERT ON SuKien TO C##NVQuay;
GRANT SELECT, INSERT ON ThamGiaSuKien TO C##NVQuay;
GRANT SELECT, INSERT ON DatCho TO C##NVQuay;
GRANT SELECT, INSERT ON GDNapTien TO C##NVQuay;

GRANT SELECT ON ChiNhanh TO C##NVQuay;
GRANT SELECT ON HangTK TO C##NVQuay;
GRANT SELECT ON Zone TO C##NVQuay;
GRANT SELECT ON DVAnUong TO C##NVQuay;
GRANT SELECT ON PLDVAnUong TO C##NVQuay;
GRANT SELECT ON DVKhac TO C##NVQuay;
GRANT SELECT ON ThietBi TO C##NVQuay;

BEGIN
  FOR proc IN (SELECT object_name FROM all_objects WHERE object_type IN ('PROCEDURE', 'FUNCTION') AND owner = 'C##PCBANG') LOOP
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON C##PCBANG.' || proc.object_name || ' TO C##NVQuay';
  END LOOP;
END;
/

------------------------
--- BACKUP & RESTORE ---
------------------------

--- Execute this in sqlplus as sysdba

sqlplus / as sysdba

ARCHIVE LOG LIST

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE ARCHIVELOG;
ALTER DATABASE OPEN;

ALTER DATABASE CLOSE;

--- Backup & Restore in RMAN

BACKUP DATABASE;
BACKUP DATABASE PLUS ARCHIVELOG;
LIST BACKUP;

RESTORE DATABASE VALIDATE;
RESTORE DATABASE;
RECOVER DATABASE;

DELETE BACKUP;

GRANT CREATE SESSION TO "C##PCBANG" WITH ADMIN OPTION;

GRANT CREATE PROFILE TO "C##PCBANG" WITH ADMIN OPTION;
GRANT ALTER PROFILE TO "C##PCBANG" WITH ADMIN OPTION;
GRANT DROP PROFILE TO "C##PCBANG" WITH ADMIN OPTION;

GRANT CREATE USER TO "C##PCBANG" WITH ADMIN OPTION;
GRANT ALTER USER TO "C##PCBANG" WITH ADMIN OPTION;
GRANT DROP USER TO "C##PCBANG" WITH ADMIN OPTION;

GRANT CREATE ROLE TO "C##PCBANG" WITH ADMIN OPTION;
GRANT ALTER ANY ROLE TO "C##PCBANG" WITH ADMIN OPTION;
GRANT DROP ANY ROLE TO "C##PCBANG" WITH ADMIN OPTION;
GRANT GRANT ANY ROLE TO "C##PCBANG" WITH ADMIN OPTION;

GRANT SELECT ANY TRANSACTION TO "C##PCBANG" WITH ADMIN OPTION;