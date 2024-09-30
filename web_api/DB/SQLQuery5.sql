USE [web_quan_ly_57kmt]
GO
/****** Object:  UserDefinedFunction [dbo].[cung_trong_truong]    Script Date: 30/09/2024 15:38:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[cung_trong_truong]()
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @thoi_diem DATETIME;
    DECLARE @result NVARCHAR(MAX);

    SELECT TOP 1 @thoi_diem = l.thoi_gian
    FROM lich_su l
    JOIN thanh_vien t ON l.ten_moi = t.ten
    WHERE l.vi_tri_moi = 'Trường'
    GROUP BY l.thoi_gian
    HAVING COUNT(DISTINCT t.id) = (SELECT COUNT(*) FROM thanh_vien)
    ORDER BY l.thoi_gian ASC;

    SET @result = (SELECT @thoi_diem AS thoi_diem
                   FOR JSON PATH, WITHOUT_ARRAY_WRAPPER);

    RETURN @result;
END;
GO
/****** Object:  Table [dbo].[lich_su]    Script Date: 30/09/2024 15:38:52 ******/
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
/****** Object:  Table [dbo].[thanh_vien]    Script Date: 30/09/2024 15:38:52 ******/
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
/****** Object:  Table [dbo].[user_login]    Script Date: 30/09/2024 15:38:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_login](
	[user] [varchar](50) NOT NULL,
	[pass] [varbinary](20) NULL,
	[name] [nvarchar](50) NULL,
	[lastLogin] [datetime] NULL,
 CONSTRAINT [PK_user_login] PRIMARY KEY CLUSTERED 
(
	[user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_login_salt]    Script Date: 30/09/2024 15:38:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_login_salt](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user] [varchar](50) NULL,
	[salt] [varchar](50) NULL,
 CONSTRAINT [PK__user_log__3213E83FC94CE51F] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[lich_su] ON 
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (10, NULL, 2, CAST(N'2024-09-21T12:13:05.760' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (11, NULL, 1, CAST(N'2024-09-21T12:13:30.470' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (13, NULL, 1, CAST(N'2024-09-21T12:14:30.300' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (16, NULL, 1, CAST(N'2024-09-21T12:15:23.120' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (17, NULL, 1, CAST(N'2024-09-21T12:15:50.850' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (18, NULL, 1, CAST(N'2024-09-21T12:18:22.290' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (19, NULL, 1, CAST(N'2024-09-21T12:19:45.373' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (29, 21, 1, CAST(N'2024-09-21T13:42:37.000' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (31, 23, 1, CAST(N'2024-09-21T13:42:45.510' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (33, 25, 1, CAST(N'2024-09-21T13:42:59.603' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (34, 26, 1, CAST(N'2024-09-21T13:43:05.127' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (35, 27, 1, CAST(N'2024-09-21T16:04:54.540' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (40, 21, 3, CAST(N'2024-09-22T18:53:06.010' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (43, 30, 1, CAST(N'2024-09-25T11:13:07.360' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (44, 31, 1, CAST(N'2024-09-25T11:13:33.067' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (46, 21, 1, CAST(N'2024-09-25T11:16:34.407' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (47, 33, 1, CAST(N'2024-09-25T11:16:54.077' AS DateTime))
GO
INSERT [dbo].[lich_su] ([id], [ma_thanh_vien], [ma_vi_tri], [thoi_gian]) VALUES (48, 34, 1, CAST(N'2024-09-25T11:19:17.660' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[lich_su] OFF
GO
SET IDENTITY_INSERT [dbo].[thanh_vien] ON 
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (21, N'sdfb', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (23, N'sfdgfd', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (25, N'thrgbdfbhg', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (26, N'fdgbvgbdf', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (27, N'dfgb', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (30, N'÷aced', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (31, N'÷CDSQAC', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (33, N'Ìd§', 1)
GO
INSERT [dbo].[thanh_vien] ([ma_thanh_vien], [ten], [ma_vi_tri]) VALUES (34, N'c§de', 1)
GO
SET IDENTITY_INSERT [dbo].[thanh_vien] OFF
GO
INSERT [dbo].[user_login] ([user], [pass], [name], [lastLogin]) VALUES (N'a', 0xE0C9035898DD52FC65C41454CEC9C4D2611BFB37, N'Tên Người Dùng', CAST(N'2024-09-30T15:38:01.747' AS DateTime))
GO
INSERT [dbo].[user_login] ([user], [pass], [name], [lastLogin]) VALUES (N'boss', 0x0FD3329B452CA6AEC3A6029080836C5261ED928A, N'Bình', CAST(N'2024-09-30T08:38:18.147' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[user_login_salt] ON 
GO
INSERT [dbo].[user_login_salt] ([id], [user], [salt]) VALUES (4, N'boss', N'boss')
GO
INSERT [dbo].[user_login_salt] ([id], [user], [salt]) VALUES (8, N'a', N'a')
GO
SET IDENTITY_INSERT [dbo].[user_login_salt] OFF
GO
ALTER TABLE [dbo].[lich_su] ADD  CONSTRAINT [DF_lich_su_thoi_gian]  DEFAULT (getdate()) FOR [thoi_gian]
GO
ALTER TABLE [dbo].[lich_su]  WITH CHECK ADD  CONSTRAINT [FK__lich_su__ma_than__4222D4EF] FOREIGN KEY([ma_thanh_vien])
REFERENCES [dbo].[thanh_vien] ([ma_thanh_vien])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[lich_su] CHECK CONSTRAINT [FK__lich_su__ma_than__4222D4EF]
GO
ALTER TABLE [dbo].[user_login_salt]  WITH CHECK ADD  CONSTRAINT [FK_user_login_salt_user_login] FOREIGN KEY([user])
REFERENCES [dbo].[user_login] ([user])
GO
ALTER TABLE [dbo].[user_login_salt] CHECK CONSTRAINT [FK_user_login_salt_user_login]
GO
/****** Object:  StoredProcedure [dbo].[SP_API]    Script Date: 30/09/2024 15:38:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_API]
    @action varchar(50),
    @ma_thanh_vien int = NULL,
    @ma_vi_tri int = NULL,
    @ten nvarchar(100) = NULL,

	@uid		varchar(50)=null,
	@pass		varchar(50)=null
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

	ELSE IF (@action = 'check_diadiem')
	BEGIN
		DECLARE @count int;
		SELECT @count = COUNT(*)
		FROM thanh_vien
		WHERE ma_vi_tri = 3;
		DECLARE @total int;
		SELECT @total = COUNT(*) FROM thanh_vien;
		IF @count = @total
		BEGIN
			DECLARE @currentTime nvarchar(19) = CONVERT(nvarchar(19), GETDATE(), 120);
			SELECT 
				'Tất cả thành viên đều ở trường' AS message,
				@currentTime AS thoigian
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER;
		END
	END

	ELSE IF (@action = 'get_salt')
    BEGIN        
        SELECT  1 as ok,
            [salt]
        FROM user_login_salt
		where [user] = @uid
        FOR JSON PATH,WITHOUT_ARRAY_WRAPPER;
    END

	else if(@action='login')
	begin
		if exists(select * from [user_login] where ([user] = @uid) and ([pass] = CONVERT(varbinary(20), @pass, 2))) 
			begin
				SET NOCOUNT ON;
				select 1 as ok,N'Login thành công' as [msg], [user], [name], [lastLogin]
				from [user_login]
				where [user] = @uid 
				for json path, without_array_wrapper;

				update [user_login] set lastLogin=getdate() where [user] = @uid;
			end;
		else
			begin
				select 0 as ok,N'Có gì đó sai sai' as msg 
				for json path, without_array_wrapper;
			end;
	end;
END


GO
