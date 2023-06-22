USE LAB2
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.DIADIEM_PHG
	(
	MAPHG nchar(10) NOT NULL,
	DIADIEM nchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.DIADIEM_PHG ADD CONSTRAINT
	PK_DIADIEM_PHG PRIMARY KEY CLUSTERED 
	(
	MAPHG
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.DIADIEM_PHG SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PHONGBAN
	(
	TENPHG nchar(15) NOT NULL,
	MAPHG nchar(10) NOT NULL,
	TRPHG nchar(10) NOT NULL,
	NG_NHANCHUC date NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PHONGBAN ADD CONSTRAINT
	PK_PHONGBAN PRIMARY KEY CLUSTERED 
	(
	MAPHG
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PHONGBAN ADD CONSTRAINT
	FK_PHONGBAN_DIADIEM_PHG FOREIGN KEY
	(
	MAPHG
	) REFERENCES dbo.DIADIEM_PHG
	(
	MAPHG
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PHONGBAN SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.DEAN
	(
	TENDA nchar(15) NOT NULL,
	MADA nchar(10) NOT NULL,
	DDIEM_DA nchar(15) NOT NULL,
	PHONG int NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.DEAN ADD CONSTRAINT
	PK_DEAN PRIMARY KEY CLUSTERED 
	(
	MADA
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.DEAN SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.CONGVIEC
	(
	MADA nchar(10) NOT NULL,
	STT int NOT NULL,
	TEN_CONG_VIEC nchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.CONGVIEC ADD CONSTRAINT
	PK_CONGVIEC PRIMARY KEY CLUSTERED 
	(
	MADA
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.CONGVIEC ADD CONSTRAINT
	FK_CONGVIEC_DEAN FOREIGN KEY
	(
	MADA
	) REFERENCES dbo.DEAN
	(
	MADA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.CONGVIEC SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.PHANCONG
	(
	MA_NVIEN nchar(10) NOT NULL,
	MADA nchar(10) NOT NULL,
	STT int NOT NULL,
	THOIGIAN float(53) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.PHANCONG ADD CONSTRAINT
	PK_PHANCONG PRIMARY KEY CLUSTERED 
	(
	MA_NVIEN
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.PHANCONG ADD CONSTRAINT
	FK_PHANCONG_CONGVIEC FOREIGN KEY
	(
	MADA
	) REFERENCES dbo.CONGVIEC
	(
	MADA
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.PHANCONG SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.NHANVIEN
	(
	HONV nchar(15) NOT NULL,
	TENLOT nchar(15) NOT NULL,
	TENNV nchar(15) NOT NULL,
	MANV nchar(10) NOT NULL,
	NGSINH date NOT NULL,
	DCHI nchar(30) NOT NULL,
	PHAI nchar(10) NOT NULL,
	LUONG float(53) NOT NULL,
		 nchar(10) NOT NULL,
	PHG nchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.NHANVIEN ADD CONSTRAINT
	PK_NHANVIEN PRIMARY KEY CLUSTERED 
	(
	MANV
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.NHANVIEN ADD CONSTRAINT
	FK_NHANVIEN_PHANCONG FOREIGN KEY
	(
	MANV
	) REFERENCES dbo.PHANCONG
	(
	MA_NVIEN
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.NHANVIEN ADD CONSTRAINT
	FK_NHANVIEN_PHONGBAN FOREIGN KEY
	(
	MA_NQL
	) REFERENCES dbo.PHONGBAN
	(
	MAPHG
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.NHANVIEN SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.THANNHAN
	(
	MANV nchar(10) NOT NULL,
	TENTN nchar(15) NOT NULL,
	PHAI nchar(3) NOT NULL,
	NGSINH date NOT NULL,
	QUANHE nchar(15) NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.THANNHAN ADD CONSTRAINT
	PK_THANNHAN PRIMARY KEY CLUSTERED 
	(
	MANV
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.THANNHAN ADD CONSTRAINT
	FK_THANNHAN_NHANVIEN FOREIGN KEY
	(
	MANV
	) REFERENCES dbo.NHANVIEN
	(
	MANV
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.THANNHAN SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

INSERT INTO NHANVIEN(HONV, TENLOT, TENNV, MANV, NGSINH, DCHI, PHAI, LUONG, MA_NQL, PHG) VALUES
('DINH', 'BA', 'TIEN', '009', '1960-11-02', '119 CONG QUYNH, TP HCM', 'NAM', 30000, '005', 5),
('NGUYEN', 'THANH', 'TUNG', '005', '1962-20-08', '222 NGUYEN VAN CU, TP HCM', 'NAM', 40000, '006', 5),
('BUI', 'NGOC', 'HANG', '007', '1954-03-11', '332 NGUYEN THAI HOC, TP HCM', 'NAM', 25000, '001', 4),
('LE', 'QUYNH', 'NHU', '001', '1967-02-01', '291 HO VAN HUE, TP HCM', 'NU', 43000, '006', 4),
('NGUYEN', 'MANH', 'HUNG', '004', '1967-03-04', '95 BA RIA, VUNG TAU', 'NAM', 38000, '005', 5),
('TRAN', 'THANH', 'TAN', '003', '1957-05-04', '34 MAI THI LU, TP HCM', 'NAM', 25000, '005', 5),
('TRAN', 'HONG', 'QUANG', '008', '1967-09-01', '80 LE HONG PHONG, TP HCM', 'NAM', 25000, '001', 4),
('PHAM', 'VAN', 'VINH', '006', '1965-01-01', '45 TRUNG VUONG, HA NOI', 'NU', 55000, '005', 1);

INSERT INTO PHONGBAN(TENPHG, MAPHG, TRPHG, NG_NHANCHUC) VALUES
('NGIEN CUU','5','005', '1978-05-22'),
('DIEU HANH','4','008', '1985-01-01'),
('QUAN LY','1','006', '1971-06-19');

INSERT INTO THANNHAN(MANV, TENTN, PHAI, NGSINH, QUANHE) VALUES
('005', 'TRINH', 'NU', '1976-04-05', 'CON GAI'),
('005', 'KHANG', 'NAM', '1973-10-25', 'CON TRAI'),
('005', 'PHUONG', 'NU', '1948-05-03', 'VO CHONG'),
('001', 'MINH', 'NAM', '1932-02-29', 'VO CHONG'),
('009', 'TIEN', 'NAM', '1978-01-01', 'CON TRAI'),
('009', 'CHAU', 'NU', '1978-12-30', 'CON GAI'),
('009', 'PHUONG', 'NU', '1957-05-05', 'VO CHONG');
--
INSERT INTO DEAN(TENDA, MADA, DDIEM_DA, PHONG) VALUES
('SAN PHAM X', '1', 'VUNG TAU', 5),
('SAN PHAM Y', '2', 'NHA TRANG', 5),
('SAN PHAM Z', '3', 'TP HCM', 5),
('TIN HOC HOA', '10', 'HA NOI', 4),
('CAP QUANG', '20', 'TH HCM', 1),
('DAO TAO', '30', 'HA NOI', 4);

INSERT INTO DIADIEM_PHG(MAPHG, DIADIEM) VALUES
('1', 'TP HCM'),
('4', 'HA NOI'),
('5', 'TAU'),
('5', 'NHA TRANG'),
('5', 'TP HCM');

INSERT INTO PHANCONG(MA_NVIEN, MADA, STT, THOIGIAN) VALUES
('009', '1', 1, 32),
('009', '2', 2, 8),
('004', '3', 1, 40),
('003', '1', 2, 20.0),
('003', '2', 1, 20.0),
('008', '10', 1, 35),
('008', '30', 2, 5),
('001', '30', 1, 20),
('001', '20', 1, 15),
('006', '20', 1, 30),
('005', '3', 1, 10),
('005', '10', 2, 10),
('005', '20', 1, 10),
('007', '30', 2, 30),
('007', '10', 2, 10);

INSERT INTO CONGVIEC(MADA, STT, TEN_CONG_VIEC) VALUES
('1', 1, 'THIET KE SAN PHAM X'),
('1', 2, 'THU NGHIEM SAN PHAM X'),
('2', 1, 'SAN XUAT SAN PHAM X'),
('2', 2, 'QUANG CAO SAN PHAM Y'),
('3', 1, 'KHUYEN MAI SAN PHAM Z'),
('10', 1, 'TIN HOC HOA PHONG NHAN SU'),
('10', 2, 'TIN HOC HOA PHONG KINH DOANH'),
('20', 1, 'LAP DAT CAP QUANG'),
('30', 1, 'DAO TAO NHAN VIEN MARKETING'),
('30', 2, 'DAO TAO CHUYEN VIEN THIET KE');