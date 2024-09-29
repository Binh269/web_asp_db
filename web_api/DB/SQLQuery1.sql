USE [web_quan_ly_57kmt]
GO
/****** Object:  Table [dbo].[lich_su]    Script Date: 21/09/2024 12:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lich_su](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ma_thanh_vien] [int] NULL,
	[ma_vi_tri] [int] NULL,
	[thoi_gian] [datetime] NULL,
 CONSTRAINT [PK__lich_su__4C9D7F291C5E5AD6] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[thanh_vien]    Script Date: 21/09/2024 12:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[thanh_vien](
	[ma_thanh_vien] [int] IDENTITY(1,1) NOT NULL,
	[ten] [nvarchar](255) NULL,
	[ma_vi_tri] [int] NULL,
 CONSTRAINT [PK__thanh_vi__F37935A9EDCF4EDB] PRIMARY KEY CLUSTERED 
(
	[ma_thanh_vien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lich_su] ADD  CONSTRAINT [DF_lich_su_thoi_gian]  DEFAULT (getdate()) FOR [thoi_gian]
GO
ALTER TABLE [dbo].[lich_su]  WITH CHECK ADD  CONSTRAINT [FK__lich_su__ma_than__4222D4EF] FOREIGN KEY([ma_thanh_vien])
REFERENCES [dbo].[thanh_vien] ([ma_thanh_vien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[lich_su] CHECK CONSTRAINT [FK__lich_su__ma_than__4222D4EF]
GO
/****** Object:  StoredProcedure [dbo].[SP_API]    Script Date: 21/09/2024 12:22:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_API]
    @action varchar(50),
    @ma_thanh_vien int = NULL,
    @ma_vi_tri int = NULL,
    @ten nvarchar(100) = NULL  -- Tham số cho tên
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

        -- Lấy ID của thành viên vừa thêm
        SET @newMaThanhVien = SCOPE_IDENTITY();

        -- Ghi lại vào lịch sử
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
GO
