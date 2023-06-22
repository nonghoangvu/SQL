﻿--SELECT * FROM NHANVIEN
BEGIN
	--NV CO LUONG > 3000
	DECLARE @RESULT INT;
	SELECT @RESULT = COUNT(*) FROM NHANVIEN WHERE LUONG > 3000;
	IF @RESULT > 0
	BEGIN
		PRINT N'CO ' + CONVERT(NVARCHAR, @RESULT) + N' NHAN VIEN CO LUONG > 3000'
	END

	ELSE
		BEGIN
			PRINT 'KHONG CO NV CO LUONG > 3000'
		END
END

--TINH TAM GIAC TON TAI HAY KHONG
BEGIN
	DECLARE @A INT = 1, @B INT = 1, @C INT = 1;
	IF (@A + @B > @C) AND (@A + @C > @B) AND (@B + @C > @A)
	BEGIN
		IF (@A = @B AND @B =@C)
		BEGIN
			PRINT N'TAM GIAC DEU'
		END
		ELSE
		BEGIN
			PRINT N'TAM GIAC TON TAI'
		END
	END
	ELSE
	BEGIN
		PRINT N'TAM GIAC KHONG TON TAI'
	END
END

--IF EXIT GIONG IF KHAC CACH THE HIEN
BEGIN
	IF EXISTS (SELECT * FROM NHANVIEN WHERE LUONG > 3000)
	BEGIN
		PRINT N'CO NV LUON > 3000'
	END
	ELSE
	BEGIN
		PRINT N'KHONG TON TAI'
	END
END

--IIF: IIF(<DK>, TRUE, FALSE)
SELECT * FROM NHANVIEN
--NV LUONG >= 35000 -> TRUONG PHONG, CON LAI -. NV QUEN
SELECT TENNV, IIF(LUONG >= 35000, N'TRUONG PHONG', N'NV QUEN') AS 'CHUC VU' FROM NHANVIEN

SELECT IIF(PHAI = N'Nữ', N'MRS.', N'MR.') + TENNV AS 'XUNG HO' FROM NHANVIEN

--CASE
SELECT TENNV,PHAI, 'XUNG HO' = CASE 
	WHEN PHAI = 'NAM' THEN N'MR.' + TENNV
	WHEN PHAI = N'NỮ' THEN N'MRS.' + TENNV
	WHEN PHAI = N'N' THEN N'SONG TINH'
	ELSE 'VO TINH'
	END
FROM NHANVIEN

/*THUC HANH TANG LUONG
NEU LUON < 25000, TANG 30%
LUONG >= 25000 AND <30000 TANG 20%
LUONG > 30000 VAF < 35000 TANG 10%
CON LAI KHONG TANG
*/
SELECT TENNV,LUONG,'DUOC TANG LUONG' = CASE
	WHEN LUONG < 25000 THEN N'TANG 30%'
	WHEN LUONG >= 25000 AND LUONG < 30000 THEN N'TANG 20%'
	WHEN LUONG > 30000 AND LUONG < 35000 THEN N'TANG 10%'
	ELSE N'KHONG TANG'
	END
FROM NHANVIEN

-- WHILE
DECLARE @NUM  INT = 1;
BEGIN
	WHILE @NUM < 10
	BEGIN
		PRINT 'NUMBER IS '  + CONVERT(NCHAR, @NUM);
		SET @NUM+=1;
	END
END
--BREACK, CONTINUE
BEGIN
	--DECLARE @NUM  INT = 1;
	WHILE @NUM < 10
	BEGIN
		SET @NUM+=1;
		IF(@NUM = 5)
		BEGIN
			--BREAK;
			CONTINUE;
		END
		PRINT 'NUMBER IS '  + CONVERT(NCHAR, @NUM);
	END
END

--TRY..CATCH
BEGIN
	BEGIN TRY
		--DECLARE @NUMA INT = 10, @NUMB INT = 0;
		PRINT @NUMA / @NUMB
	END TRY
	
	BEGIN CATCH
		PRINT N'ERROR'
	END CATCH
END

--RAISERROR
BEGIN
	BEGIN TRY
		DECLARE @NUMA INT = 10, @NUMB INT = 0;
		PRINT @NUMA / @NUMB
	END TRY
	
	BEGIN CATCH
		-- MESSENGER, LEVEL, STATE
		RAISERROR('KHONG THE CHIA CHO 0', 16, 232)
		-- LEVEL <= 18
	END CATCH
END


-- USE IF ELSE IN ASSIGNMENT
-- S > 0
BEGIN
	DECLARE @MA_NHA INT -- 0
	DECLARE @DIEN_TICH INT -- 0
	DECLARE @TEB_NHA NVARCHAR(50) -- NULL
	IF(@MA_NHA IS NULL OR @MA_NHA = '') AND (@TEB_NHA IS NULL OR @TEB_NHA = '') AND (@DIEN_TICH IS NULL OR @DIEN_TICH = '') -- CHECK NULL DATA
	BEGIN
		RAISERROR('DATA INVALID', 16, 16)
	END
	ELSE
	BEGIN
		-- INSERT INTO NHATRO BLA BLA
		PRINT 'DA THEM DU LIEU'
	END
END

/*
STORE PROCEDURE: 5 DIEM IN FINAL
1 DIEM FROM RAISERROR
*/
-- CREATE TABE AND DATA: 2 DIEM
-- VIEW: 2 DIEM
-- FUNCTION: 1 DIEM

--STORRE PROCEDURES (SP) PROC = PROCEDURE
USE QLDA -- CHON DB DE CHUA SP DE CHUAN BI VIET
--SELECT * FROM NHANVIEN
CREATE PROC SP_THEMNHANVIEN 
@HONV NVARCHAR(15),
@TENLOT NVARCHAR(15),
@TENNV NVARCHAR(15),
@MANV NCHAR(9),
@NGSINH DATETIME,
@DCHI NVARCHAR(30),
@PHAI NVARCHAR(3),
@LUONG FLOAT,
@MA_NQL NVARCHAR(9),
@PHG INT
AS
	INSERT INTO NHANVIEN VALUES (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG,@MA_NQL , @PHG)

EXEC SP_THEMNHANVIEN 'A', 'B', 'C', '099', '1990-12-12', N'HA NOI', 'Nữ', 3000, '001', 4
SELECT * FROM NHANVIEN
 -- CAU TRUC SP
 -- CREATE PROC NAME
 --	BIEN VO HUONG 1
 -- BIEN VO HUONG ..
 -- AS
 -- CODE HERE

 -- RUN SP: EXEC  <NAME> <VALUE.. TO N>

-- SP KET HOP VOI NHUNG GI DA HOC
-- CONG TY KHONG TUYEN NGUOI TREN 35 TUOI
ALTER PROC SP_THEMNHANVIEN_UNDER35
@HONV NVARCHAR(15),
@TENLOT NVARCHAR(15),
@TENNV NVARCHAR(15),
@MANV NCHAR(9),
@NGSINH DATETIME,
@DCHI NVARCHAR(30),
@PHAI NVARCHAR(3),
@LUONG FLOAT,
@MA_NQL NVARCHAR(9),
@PHG INT
AS BEGIN
	DECLARE @AGE INT = YEAR(GETDATE()) - YEAR(@NGSINH)
	IF(@AGE > 35)
	BEGIN
		RAISERROR('GIA QUA KHONG NHAN', 16, 16)
	END
	ELSE
	BEGIN
		INSERT INTO NHANVIEN VALUES (@HONV, @TENLOT, @TENNV, @MANV, @NGSINH, @DCHI, @PHAI, @LUONG,@MA_NQL , @PHG)
		SELECT * FROM NHANVIEN

	END
END
EXEC SP_THEMNHANVIEN_UNDER35 'A', 'B', 'C', '010', '2012-12-12', N'HA NOI', N'Nữ', 3000, '001', 4

--DROP PROC SP_THEMNHANVIEN_UNDER35


CREATE PROC SP_XOANV
	@MANV NVARCHAR(9)
	AS
	IF EXISTS (SELECT MANV FROM NHANVIEN WHERE MANV = @MANV)
	BEGIN
		DELETE FROM NHANVIEN WHERE MANV = @MANV
		PRINT N'XOA THANH CONG'
	END
	ELSE
	BEGIN
		RAISERROR('KHONG TIM THAY NHAN VIEN', 16,16)
	END
SELECT * FROM NHANVIEN
EXEC SP_XOANV '017'

-- REMOVE A PROC
DROP PROC sp_ThemPhongBan

-- CREATE PROC SELECT
CREATE PROC SP_TIMNVTHEOLUONG
	@LUONG INT
AS BEGIN
	IF EXISTS(SELECT * FROM NHANVIEN WHERE LUONG < @LUONG)
	BEGIN
		SELECT * FROM NHANVIEN WHERE LUONG < @LUONG
	END
	ELSE
	BEGIN
		RAISERROR('kHONG TIM THAY', 16, 16)
	END
END

EXEC SP_TIMNVTHEOLUONG 1500

-- VIEW 2 DIEM 2
-- CHON RA TOP 2 NV LUONG CAO NHAT
/*CREATE*/ALTER VIEW TOP2_LUONG
AS
SELECT TOP 2 * FROM NHANVIEN ORDER BY LUONG DESC
-- USE
SELECT * FROM TOP2_LUONG

-- CREATE VIEW <NAME> AS <CAU LENH BINH THUONG>
-- USE: SELECT */<COLUMNS> FROM <NAME VIEW>

-- DROP VIEW TOP2_LUONG


/*
THUC HANH SP: SUW DUNG DB QLDA
- TAO SP DE THEM 1 THAN NHAN
- TAO SP DE UPDATE PHAI CUA NV DUOC CHON
- TAOJ SP DE XOA 1 THAN NHAN
- TAO SP DE CHON RA NHUNG NV CO MADA = 1
- TAO SP CHON RA NV THEO KHOANG LUONG
*/