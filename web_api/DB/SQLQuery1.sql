USE [web_quan_ly_57kmt]
GO
/****** Object:  StoredProcedure [dbo].[SP_API] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SP_API]
    @action varchar(50),
    @ma_thanh_vien int = NULL,
    @ma_vi_tri int = NULL,
    @ten nvarchar(100) = NULL 
AS
BEGIN

    IF (@action = 'get_infor')
    BEGIN        
        SELECT 
            'get_infor' AS status,
            ma_thanh_vien,
            ten,  
            ma_vi_tri
        FROM thanh_vien
        FOR JSON PATH;
    END

    ELSE IF (@action = 'add')
    BEGIN
        DECLARE @time datetime = GETDATE();
        DECLARE @newMaThanhVien int;

        INSERT INTO thanh_vien (ten, ma_vi_tri) 
        VALUES (@ten, @ma_vi_tri);

        SET @newMaThanhVien = SCOPE_IDENTITY();

        INSERT INTO lich_su ([ma_thanh_vien], [ma_vi_tri], [thoi_gian])
        VALUES (@newMaThanhVien, @ma_vi_tri, @time);

        SELECT 'Thêm thành công' AS message FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    END

    ELSE IF (@action = 'update')
    BEGIN
        DECLARE @now datetime = GETDATE();
        UPDATE thanh_vien
        SET [ma_vi_tri] = @ma_vi_tri
        WHERE ma_thanh_vien = @ma_thanh_vien;

        INSERT INTO lich_su ([ma_thanh_vien], [ma_vi_tri], [thoi_gian])
        VALUES (@ma_thanh_vien, @ma_vi_tri, @now);

        SELECT 'Cập nhật thành công' AS message FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    END

    ELSE IF (@action = 'delete')
    BEGIN
        DELETE FROM lich_su
        WHERE ma_thanh_vien = @ma_thanh_vien;
        DELETE FROM thanh_vien
        WHERE ma_thanh_vien = @ma_thanh_vien;

        SELECT 'Xóa thành công' AS message FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
    END

    ELSE IF (@action = 'history')
    BEGIN
        SELECT t.ten, l.ma_vi_tri, 
               CONVERT(nvarchar(16), l.thoi_gian, 120) AS thoi_gian
        FROM lich_su l
        JOIN thanh_vien t ON l.ma_thanh_vien = t.ma_thanh_vien
        WHERE l.ma_thanh_vien = @ma_thanh_vien
        ORDER BY l.thoi_gian DESC
        FOR JSON PATH;
    END
END
