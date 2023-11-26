CREATE TABLE ChiNhanh (
    MaCN CHAR(10) PRIMARY KEY,
    TenCN NVARCHAR2(50) NOT NULL,
    DiaChiCN NVARCHAR2(100) NOT NULL,
    SDTCN CHAR(10) NOT NULL CHECK (REGEXP_LIKE(SDTCN, '^[0-9]*$'))
);

CREATE TABLE ViTriCV (
    MaCV CHAR(10) PRIMARY KEY,
    TenCV NVARCHAR2(50) NOT NULL,
    MoTaCV NVARCHAR2(100)
);

CREATE TABLE BoPhan (
    MaBP CHAR(10) PRIMARY KEY,
    TenBP NVARCHAR2(50) NOT NULL
);

CREATE TABLE Luong (
    BacLuong NUMBER(2) PRIMARY KEY CHECK (BacLuong > 0),
    HeSoLuong NUMBER NOT NULL CHECK (HeSoLuong > 0),
    LuongCoBan NUMBER NOT NULL CHECK (LuongCoBan > 0),
    PhuCap NUMBER NOT NULL CHECK (PhuCap >= 0)
);

CREATE TABLE HangTK (
    MaHangTK CHAR(10) PRIMARY KEY,
    TenHangTK NVARCHAR2(30) NOT NULL,
    MucChiTieu NUMBER NOT NULL CHECK (MucChiTieu >= 0),
    MucChietKhau NUMBER(5, 2) NOT NULL CHECK (MucChietKhau >= 0 AND MucChietKhau <= 100)
);

CREATE TABLE NhanVien (
    MaNV CHAR(10) PRIMARY KEY,
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
    MaCV CHAR(10) REFERENCES ViTriCV(MaCV),
    MaCN CHAR(10) REFERENCES ChiNhanh(MaCN),
    MaBP CHAR(10) REFERENCES BoPhan(MaBP),
    BacLuong NUMBER(2) REFERENCES Luong(BacLuong)
);

CREATE TABLE KhachHang (
    TaiKhoan CHAR(30) PRIMARY KEY,
    MatKhau CHAR(30) NOT NULL,
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
    MaHangTK CHAR(10) REFERENCES HangTK(MaHangTK)
);

CREATE TABLE GDNapTien (
    MaGD CHAR(10) PRIMARY KEY,
    TaiKhoan CHAR(30) NOT NULL,
    MaNV CHAR(30) NOT NULL,
    SoTienNap NUMBER NOT NULL CHECK (SoTienNap >= 0),
    FOREIGN KEY (TaiKhoan) REFERENCES KhachHang(TaiKhoan),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE Zone (
    LoaiZone CHAR(10) PRIMARY KEY,
    TenZone CHAR(30) NOT NULL,
    MucGiaTheoGio NUMBER NOT NULL CHECK (MucGiaTheoGio >= 0),
    TSKT CLOB NOT NULL
);

CREATE TABLE TTMay (
    MaMay CHAR(10),
    MaCN CHAR(10) REFERENCES ChiNhanh(MaCN),
    LoaiZone CHAR(10) REFERENCES Zone(LoaiZone),
    TTHoatDong NUMBER(1) NOT NULL CHECK (TTHoatDong IN (0, 1)),
    TTBan NUMBER(1) NOT NULL CHECK (TTBan IN (0, 1)),
    PRIMARY KEY (MaMay, MaCN)
);

CREATE TABLE PLDVAnUong (
    MaPL CHAR(10) PRIMARY KEY,
    TenPL NVARCHAR2(50) NOT NULL
);

CREATE TABLE DVAnUong (
    MaMon CHAR(10) PRIMARY KEY,
    TenMon NVARCHAR2(50) NOT NULL,
    GiaMon NUMBER NOT NULL CHECK (GiaMon >= 0),
    AnhMon CLOB,
    MaPL CHAR(10) NOT NULL REFERENCES PLDVAnUong(MaPL)
);

CREATE TABLE DVKhac (
    MaDV CHAR(10) PRIMARY KEY,
    TenDV NVARCHAR2(50) NOT NULL,
    MucGiaTheoGio NUMBER NOT NULL CHECK (MucGiaTheoGio >= 0)
);

CREATE TABLE HoaDon (
    MaHD CHAR(10) PRIMARY KEY,
    TaiKhoan CHAR(30) REFERENCES KhachHang(TaiKhoan),
    MaNV CHAR(10) REFERENCES NhanVien(MaNV),
    NgayXuat DATE NOT NULL,
    TongTien NUMBER NOT NULL CHECK (TongTien >= 0),
    GhiChu CLOB
);

CREATE TABLE CTHoaDonInternet (
    MaHD CHAR(10),
    MaMay CHAR(10),
    MaCN CHAR(10),
    SoGio NUMBER NOT NULL CHECK (SoGio > 0),
    DonGiaTheoGio NUMBER NOT NULL CHECK (DonGiaTheoGio >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaMay, MaCN),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaMay, MaCN) REFERENCES TTMay(MaMay, MaCN)
);

CREATE TABLE CTHoaDonDVKhac (
    MaHD CHAR(10),
    MaDV CHAR(10),
    SoGio NUMBER NOT NULL CHECK (SoGio > 0),
    DonGiaTheoGio NUMBER NOT NULL CHECK (DonGiaTheoGio >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaDV),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaDV) REFERENCES DVKhac(MaDV)
);

CREATE TABLE CTHoaDonAnUong (
    MaHD CHAR(10),
    MaMon CHAR(10),
    SoLuong NUMBER NOT NULL CHECK (SoLuong > 0),
    DonGia NUMBER NOT NULL CHECK (DonGia >= 0),
    ChietKhau NUMBER(5, 2) NOT NULL CHECK (ChietKhau >= 0 AND ChietKhau <= 100),
    PRIMARY KEY (MaHD, MaMon),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaMon) REFERENCES DVAnUong(MaMon)
);

CREATE TABLE ThietBi (
    MaTB CHAR(10) PRIMARY KEY,
    TenTB NVARCHAR2(50) NOT NULL
);

CREATE TABLE BaoTri (
    MaBT CHAR(10) PRIMARY KEY,
    MaCN CHAR(10),
    MaMay CHAR(10),
    MaTB CHAR(10) REFERENCES ThietBi(MaTB),
    TinhTrang CLOB NOT NULL,
    GhiChu CLOB,
    TTSua NUMBER(1) NOT NULL CHECK (TTSua IN (0, 1)),
    FOREIGN KEY (MaCN, MaMay) REFERENCES TTMay(MaCN, MaMay)
);

CREATE TABLE SuKien (
    MaSK CHAR(10) PRIMARY KEY,
    TenSK NVARCHAR2(100) NOT NULL,
    MoTaSK CLOB,
    NgayBD DATE NOT NULL,
    NgayKT DATE NOT NULL,
    TTToChuc NUMBER(1) NOT NULL CHECK (TTToChuc IN (0, 1)),
    MaCN CHAR(10) REFERENCES ChiNhanh(MaCN),
    CONSTRAINT Check_NgayKT_NgayBD CHECK (NgayKT >= NgayBD)
);

CREATE TABLE ThamGiaSuKien (
    MaSK CHAR(10),
    TaiKhoan CHAR(30),
    UuDai CLOB,
    PRIMARY KEY (MaSK, TaiKhoan),
    FOREIGN KEY (MaSK) REFERENCES SuKien(MaSK),
    FOREIGN KEY (TaiKhoan) REFERENCES KhachHang(TaiKhoan)
);

CREATE TABLE DatCho (
    MaDC CHAR(10) PRIMARY KEY,
    TaiKhoan CHAR(30) REFERENCES KhachHang(TaiKhoan),
    MaNV CHAR(10) REFERENCES NhanVien(MaNV),
    NgayDat DATE NOT NULL,
    NgayDen DATE NOT NULL,
    YeuCau CLOB NOT NULL,
    CONSTRAINT Check_NgayDen_NgayDat CHECK (NgayDen >= NgayDat)
);

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

--- TABLESPACE ---

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

--- INDEX ---

CREATE INDEX id_MatKhau ON KhachHang(MatKhau);
CREATE INDEX id_TenKH ON KhachHang(TenKH);
CREATE INDEX id_SoTienDangCo ON KhachHang(SoTienDangCo);
CREATE INDEX id_SoTienChiTieu ON KhachHang(SoTienChiTieu);
CREATE INDEX id_TenZone ON Zone(TenZone);
CREATE INDEX id_TTHoatDong ON TTMay(TTHoatDong);
CREATE INDEX id_TTBan ON TTMay(TTBan);
CREATE INDEX id_TenMon ON DVAnUong(TenMon);

--- TRIGGER ---

CREATE OR REPLACE TRIGGER tr_CheckEmployeeAge
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

CREATE OR REPLACE TRIGGER tr_CheckEmployeePhoneNumber
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

CREATE OR REPLACE TRIGGER tr_CheckCustomerPhoneNumber
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

CREATE OR REPLACE TRIGGER tr_CheckEmployeeEmail
BEFORE INSERT OR UPDATE ON NhanVien
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.EmailNV, '^[A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email nhan vien khong dung dinh dang.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER tr_CheckCustomerEmail
BEFORE INSERT OR UPDATE ON KhachHang
FOR EACH ROW
BEGIN
    IF NOT REGEXP_LIKE(:NEW.EmailKH, '^[A-Za-z0-9._]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Email khach hang khong dung dinh dang');
    END IF;
END;
/

--- SQL / PL/SQL ---

-- Tinh doanh thu cua toan he thong nam 2022
SELECT YEAR(NgayXuat) AS 'NAM', SUM(TongTien) AS 'Tong Tien'
FROM HoaDon
GROUP BY YEAR(NgayXuat)
HAVING (YEAR(NgayXuat) = 2023)

-- Loai ZONE nao duoc su dung nhieu nhat
SELECT Zone.LoaiZone,  COUNT(CTHoaDonInternet.SoGio) AS SoLan
FROM Zone INNER JOIN TTMay ON Zone.LoaiZone = TTMay.LoaiZone INNER JOIN CTHoaDonInternet ON TTMay.MaMay =  CTHoaDonInternet.MaMay
WHERE ROWNUM <= 1
GROUP BY Zone.LoaiZone
ORDER BY SoLan DESC

-- Kiem tra may nao con dang trong
SELECT MaMay 
FROM TTMay
WHERE TTHoatDong = 0



-- thong ke xem trong nam 2022 moi mot khach hang trong moi thang v? trong ca nam ban trong dich vu an uong voi so luong la bao nhieu
SELECT c.MaMon, c.TenMon, 
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 1 THEN b.SoLuong
      ELSE 0 END) AS Thang1,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 2 THEN b.SoLuong
      ELSE 0 END) AS Thang2,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 3 THEN b.SoLuong
      ELSE 0 END) AS Thang3,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 4 THEN b.SoLuong
      ELSE 0 END) AS Thang4,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 5 THEN b.SoLuong
      ELSE 0 END) AS Thang5,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 6 THEN b.SoLuong
      ELSE 0 END) AS Thang6,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 7 THEN b.SoLuong
      ELSE 0 END) AS Thang7,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 8 THEN b.SoLuong
      ELSE 0 END) AS Thang8,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 9 THEN b.SoLuong
      ELSE 0 END) AS Thang9,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 10 THEN b.SoLuong
      ELSE 0 END) AS Thang10,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 11 THEN b.SoLuong
      ELSE 0 END) AS Thang11,
    SUM (CASE EXTRACT(YEAR FROM a.NgayXuat) WHEN 12 THEN b.SoLuong
      ELSE 0 END) AS Thang12,
    SUM (b.SoLuong) AS CaNam
FROM HoaDon a inner join CTHoaDonAnUong b on a.MaHD = b.MaHD inner join DVAnUong c on b.MaMon = c.MaMon
WHERE EXTRACT(YEAR FROM a.NgayXuat)=2022
GROUP BY c.MaMon, c.TenMon
-- ??a ra khach hang chi tieu nhieu nhat nhat
SELECT *
FROM ( 

--Viet thu tuc tinh tong doanh thu cua he thong trong khoang thoi gian bat ki. Voi tham so dau vao la thoi gian bat dau, thoi gian ket thuc. Tham so dau ra la tong doanh thu toan he thong
CREATE  OR REPLACE PROCEDURE THONGKEDOANHTHU(
    ThangNam1 DATE,
    ThangNam2 DATE)
IS    
    DoanhThu number;
BEGIN
    SELECT SUM(TongTien)
    INTO DoanhThu
    FROM HoaDon
    WHERE NgayXuat BETWEEN  ThangNam1 AND ThangNam2;
    DBMS_OUTPUT.PUT_LINE('Tong doanh thu cua he thong tu ' || TO_CHAR(ThangNam1, 'YYYY-MM-DD') || '??n' || TO_CHAR(ThangNam2, 'YYYY-MM-DD') || ':' || DoanhThu);
END;


DECLARE
    thangnam1 DATE;
    thangnam2 DATE;
BEGIN
    thangnam1 := TO_DATE('2022-04-07', 'YYYY-MM-DD');
    thangnam2 := TO_DATE('2023-05-10', 'YYYY-MM-DD');
    
    THONGKEDOANHTHU(thangnam1, thangnam2);
END;

-- Viet thu tuc t?nh doang thu cua he thong trong mot ngay bat ky nhap tu ban phim
CREATE  OR REPLACE PROCEDURE DoanhThu1Ngay 
IS
    Ngay DATE;
    TongDoanhThu NUMBER;
BEGIN
    Ngay :=&'Ngay';
    SELECT NVL(SUM(TongTien),0) as TongDoanhThu
    INTO DoanhThu
    FROM HoaDon
    WHERE TRUNC(NgayXuat) = TRUNC(Ngay);
    DBMS_OUTPUT.PUT_LINE('T?ng doanh thu ng?y ' || TO_CHAR(Ngay, 'DD-MM-YYYY') || ': ' ||DoanhThu);
END;

EXECUTE DoanhThu1Ngay;

--viet thu tuc liet ke cac dich vu an uong thuoc mot phan loai bat ki v?i tham so truyen vao la ten phan loai. Kiem tra rang buoc ton tai ten phan loai
CREATE  OR REPLACE PROCEDURE LIETKE_DVAU(
    TenPhanLoai char(10)
)
IS
BEGIN
    IF EXISTS ( SELECT * FROM PLDVAnUong WHERE TenPL LIKE TenPhanLoai) THEN
        SELECT DVAnUong.MaMon, DVAnUong.TenMon, DVAnUong.GiaMon
        FROM DVAnUong inner join PLDVAnUong on DVAnUong.MaPL = PLDVAnUong.MaPL
        WHERE PLDVAnUong.TenPL = TenPhanLoai;
    ELSE
         DBMS_OUTPUT.PUT_LINE('Khong ton tai dich vu an uong nay');
    END IF;
END;    
    
EXECUTE LIETKE_DVAU('Cafe');