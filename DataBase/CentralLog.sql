USE [master]
GO
/****** Object:  Database [CentralLog]    Script Date: 5/3/2020 10:03:32 PM ******/
CREATE DATABASE [CentralLog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CentralLog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\CentralLog.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CentralLog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\CentralLog_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CentralLog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CentralLog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CentralLog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CentralLog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CentralLog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CentralLog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CentralLog] SET ARITHABORT OFF 
GO
ALTER DATABASE [CentralLog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CentralLog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CentralLog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CentralLog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CentralLog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CentralLog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CentralLog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CentralLog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CentralLog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CentralLog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CentralLog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CentralLog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CentralLog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CentralLog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CentralLog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CentralLog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CentralLog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CentralLog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CentralLog] SET  MULTI_USER 
GO
ALTER DATABASE [CentralLog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CentralLog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CentralLog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CentralLog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [CentralLog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [CentralLog]
GO
/****** Object:  Table [dbo].[Log]    Script Date: 5/3/2020 10:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Log](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreatedAt] [datetime] NOT NULL DEFAULT (getdate()),
	[Application] [varchar](200) NOT NULL DEFAULT (''),
	[Scope] [varchar](200) NOT NULL DEFAULT (''),
	[Level] [varchar](200) NOT NULL DEFAULT (''),
	[ClientIp] [varchar](200) NOT NULL DEFAULT (''),
	[Message] [varchar](max) NOT NULL DEFAULT (''),
	[Url] [varchar](max) NOT NULL DEFAULT (''),
	[DurationInSeconds] [decimal](15, 4) NOT NULL DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbl_Users]    Script Date: 5/3/2020 10:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Users](
	[UserId] [bigint] IDENTITY(1,1) NOT NULL,
	[User_Name] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Password] [nvarchar](100) NULL,
	[Created_At] [datetime] NULL,
	[Is_Active] [bit] NULL,
 CONSTRAINT [PK_tbl_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Log] ON 

INSERT [dbo].[Log] ([Id], [CreatedAt], [Application], [Scope], [Level], [ClientIp], [Message], [Url], [DurationInSeconds]) VALUES (1, CAST(N'2020-05-03 22:00:06.720' AS DateTime), N'SomeApp1', N'AmazingClass.ExecuteThat("abc", 123)', N'Exception', N'127.0.0.1', N'Division by 0 exception', N'https://amazingapp.somewhere.whereever/Login', CAST(0.0020 AS Decimal(15, 4)))
INSERT [dbo].[Log] ([Id], [CreatedAt], [Application], [Scope], [Level], [ClientIp], [Message], [Url], [DurationInSeconds]) VALUES (2, CAST(N'2020-05-03 22:00:06.723' AS DateTime), N'SomeApp1', N'AmazingClass.ExecuteThat("abc", 123)', N'Information', N'127.0.0.1', N'Thing succeeded', N'https://amazingapp.somewhere.whereever/ListData', CAST(1.2000 AS Decimal(15, 4)))
SET IDENTITY_INSERT [dbo].[Log] OFF
SET IDENTITY_INSERT [dbo].[tbl_Users] ON 

INSERT [dbo].[tbl_Users] ([UserId], [User_Name], [Email], [Password], [Created_At], [Is_Active]) VALUES (1, N'abc123', N'abc123@gmail.com', N'123456usa', CAST(N'2020-05-03 17:01:34.617' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tbl_Users] OFF
/****** Object:  StoredProcedure [dbo].[sp_Login]    Script Date: 5/3/2020 10:03:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Login] 
	-- Add the parameters for the stored procedure here
	@Email nvarchar(100),
	@Password nvarchar(100),
	@IsExist bit out
	AS
BEGIN

	SET @IsExist = (select count(1) from tbl_Users where Email = @Email and Password = @Password)

END

GO
USE [master]
GO
ALTER DATABASE [CentralLog] SET  READ_WRITE 
GO
