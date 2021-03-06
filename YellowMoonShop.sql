USE [master]
GO
/****** Object:  Database [YellowMoonShop]    Script Date: 16/10/2020 00:13:37 ******/
CREATE DATABASE [YellowMoonShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'YellowMoonShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'YellowMoonShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\YellowMoonShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [YellowMoonShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YellowMoonShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [YellowMoonShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [YellowMoonShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [YellowMoonShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [YellowMoonShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [YellowMoonShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [YellowMoonShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [YellowMoonShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [YellowMoonShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [YellowMoonShop] SET  MULTI_USER 
GO
ALTER DATABASE [YellowMoonShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [YellowMoonShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [YellowMoonShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [YellowMoonShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [YellowMoonShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [YellowMoonShop]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblLog](
	[logID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[userID] [varchar](50) NOT NULL,
	[productID] [uniqueidentifier] NOT NULL,
	[logDate] [datetime] NULL DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[logID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblOrder_orderID]  DEFAULT (newsequentialid()),
	[userID] [varchar](50) NOT NULL,
	[total] [decimal](15, 2) NOT NULL,
	[orderDate] [datetime] NOT NULL CONSTRAINT [DF_tblOrder_orderDate]  DEFAULT (getdate()),
	[name] [nvarchar](50) NOT NULL,
	[phone] [nchar](10) NOT NULL,
	[address] [nvarchar](255) NOT NULL,
	[paymentID] [uniqueidentifier] NOT NULL,
	[paymentStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblOrderDetail_detailID]  DEFAULT (newsequentialid()),
	[orderID] [uniqueidentifier] NOT NULL,
	[productID] [uniqueidentifier] NULL,
	[price] [decimal](15, 2) NOT NULL,
	[quantity] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[detailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPayment](
	[paymentID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_tblPayment_paymentID]  DEFAULT (newsequentialid()),
	[name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productID] [uniqueidentifier] NOT NULL DEFAULT (newsequentialid()),
	[name] [nvarchar](50) NOT NULL,
	[price] [decimal](15, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[image] [varchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[creationDate] [datetime] NOT NULL,
	[expirationDate] [datetime] NOT NULL,
	[categoryID] [uniqueidentifier] NOT NULL,
	[status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_tblRole_roleID]  DEFAULT (newsequentialid()),
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 16/10/2020 00:13:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[userID] [varchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[password] [nchar](64) NOT NULL,
	[phone] [nchar](10) NULL,
	[address] [nvarchar](255) NULL,
	[roleID] [uniqueidentifier] NOT NULL,
	[status] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'f3701567-bb07-eb11-80b4-34e6d743f8ac', N'Nhu Lan')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Kinh Do')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Girval')
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [logDate]) VALUES (N'082892e3-a70b-eb11-80b4-34e6d743f8ac', N'phuongpt', N'07a68b20-6f08-eb11-80b4-34e6d743f8ac', CAST(N'2020-10-11 16:55:28.000' AS DateTime))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [logDate]) VALUES (N'17c9952c-1d0d-eb11-80b4-34e6d743f8ac', N'phuongpt', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(N'2020-10-13 13:27:32.000' AS DateTime))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [logDate]) VALUES (N'c5ac03be-370e-eb11-80b4-34e6d743f8ac', N'phuongpt', N'ef3a40e0-ad0a-eb11-80b4-34e6d743f8ac', CAST(N'2020-10-14 23:10:14.000' AS DateTime))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [logDate]) VALUES (N'1c4fa98a-060f-eb11-80b4-34e6d743f8ac', N'phuongpt', N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', CAST(N'2020-10-15 23:50:34.000' AS DateTime))
INSERT [dbo].[tblLog] ([logID], [userID], [productID], [logDate]) VALUES (N'e17c2a94-090f-eb11-80b4-34e6d743f8ac', N'phuongpt', N'c440a27b-060f-eb11-80b4-34e6d743f8ac', CAST(N'2020-10-16 00:12:18.000' AS DateTime))
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'617b6e35-bd0c-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(6280000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 02:00:35.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 LÃª Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'31e40f7c-bd0c-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(440000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 02:02:34.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 LÃª Van Vi?t', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'1ee323eb-c00c-eb11-80b4-34e6d743f8ac', N'2020/10/13 02:27:090123456789', CAST(4860000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 02:27:09.000' AS DateTime), N'Nguyen Thi Hieu', N'0123456789', N'TPHCM', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'5ef1a71e-c30c-eb11-80b4-34e6d743f8ac', N'2020/10/13 02:42:540123456789', CAST(7500000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 02:42:54.000' AS DateTime), N'Luu Dieu Hoa', N'0123456789', N'TG', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'502c414b-1c0d-eb11-80b4-34e6d743f8ac', N'2020/10/13 13:21:140123456897', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 13:21:14.000' AS DateTime), N'Hieu nguyen', N'0123456897', N'Ninh Thuan', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'babf48d4-220d-eb11-80b4-34e6d743f8ac', N'2020/10/13 14:08:010123456897', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 14:08:01.000' AS DateTime), N'Hieu nguyen', N'0123456897', N'Ninh Thuan', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'8997e9e4-220d-eb11-80b4-34e6d743f8ac', N'2020/10/13 14:08:290123456897', CAST(1650000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 14:08:29.000' AS DateTime), N'Hieu nguyen', N'0123456897', N'Ninh Thuan', N'49f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'30d8da08-230d-eb11-80b4-34e6d743f8ac', N'2020/10/13 14:09:290123456789', CAST(150000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 14:09:29.000' AS DateTime), N'Nguyen Thi Hieu', N'0123456789', N'TPHCM', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'430ddd30-230d-eb11-80b4-34e6d743f8ac', N'2020/10/13 14:10:360123456789', CAST(3000000.00 AS Decimal(15, 2)), CAST(N'2020-10-13 14:10:36.000' AS DateTime), N'Nguyen Thi Hieu', N'0123456789', N'TPHCM', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'fa726262-350e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(360000.00 AS Decimal(15, 2)), CAST(N'2020-10-14 22:53:22.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 LÃª Van Viet', N'49f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'a2874767-3f0e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:05:05.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'7f1bb348-410e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:18:33.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'f5853451-410e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:18:47.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'edacf702-420e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(800000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:23:45.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'fa56ea65-420e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(800000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:26:31.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'c0be668c-420e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(800000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:27:36.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'62acb5b1-420e-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(150000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 00:28:38.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'79298f1a-ff0e-eb11-80b4-34e6d743f8ac', N'2020/10/15 22:57:190123456789', CAST(1500000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 22:57:19.000' AS DateTime), N'Nguyen Thi Hieu', N'0123456789', N'TPHCM', N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'76ee77c5-060f-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(3500000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 23:52:13.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'49f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'af77f2eb-060f-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(1080000.00 AS Decimal(15, 2)), CAST(N'2020-10-15 23:53:17.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'49f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'not paid')
INSERT [dbo].[tblOrder] ([orderID], [userID], [total], [orderDate], [name], [phone], [address], [paymentID], [paymentStatus]) VALUES (N'fc47d7c8-080f-eb11-80b4-34e6d743f8ac', N'phuongpt123', CAST(500000.00 AS Decimal(15, 2)), CAST(N'2020-10-16 00:06:37.000' AS DateTime), N'Pham Thanh Phuong', N'0123456789', N'788 Le Van Viet', N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'Not Paid')
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'627b6e35-bd0c-eb11-80b4-34e6d743f8ac', N'617b6e35-bd0c-eb11-80b4-34e6d743f8ac', N'a45aa7ce-270b-eb11-80b4-34e6d743f8ac', CAST(4200000.00 AS Decimal(15, 2)), 3)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'637b6e35-bd0c-eb11-80b4-34e6d743f8ac', N'617b6e35-bd0c-eb11-80b4-34e6d743f8ac', N'5e569497-270b-eb11-80b4-34e6d743f8ac', CAST(2080000.00 AS Decimal(15, 2)), 4)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'32e40f7c-bd0c-eb11-80b4-34e6d743f8ac', N'31e40f7c-bd0c-eb11-80b4-34e6d743f8ac', N'06a68b20-6f08-eb11-80b4-34e6d743f8ac', CAST(200000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'33e40f7c-bd0c-eb11-80b4-34e6d743f8ac', N'31e40f7c-bd0c-eb11-80b4-34e6d743f8ac', N'05a68b20-6f08-eb11-80b4-34e6d743f8ac', CAST(240000.00 AS Decimal(15, 2)), 2)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'1fe323eb-c00c-eb11-80b4-34e6d743f8ac', N'1ee323eb-c00c-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(4500000.00 AS Decimal(15, 2)), 3)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'20e323eb-c00c-eb11-80b4-34e6d743f8ac', N'1ee323eb-c00c-eb11-80b4-34e6d743f8ac', N'07a68b20-6f08-eb11-80b4-34e6d743f8ac', CAST(360000.00 AS Decimal(15, 2)), 3)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'5ff1a71e-c30c-eb11-80b4-34e6d743f8ac', N'5ef1a71e-c30c-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(7500000.00 AS Decimal(15, 2)), 5)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'512c414b-1c0d-eb11-80b4-34e6d743f8ac', N'502c414b-1c0d-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'bbbf48d4-220d-eb11-80b4-34e6d743f8ac', N'babf48d4-220d-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'8a97e9e4-220d-eb11-80b4-34e6d743f8ac', N'8997e9e4-220d-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'8b97e9e4-220d-eb11-80b4-34e6d743f8ac', N'8997e9e4-220d-eb11-80b4-34e6d743f8ac', N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', CAST(150000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'31d8da08-230d-eb11-80b4-34e6d743f8ac', N'30d8da08-230d-eb11-80b4-34e6d743f8ac', N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', CAST(150000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'440ddd30-230d-eb11-80b4-34e6d743f8ac', N'430ddd30-230d-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(3000000.00 AS Decimal(15, 2)), 2)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'fb726262-350e-eb11-80b4-34e6d743f8ac', N'fa726262-350e-eb11-80b4-34e6d743f8ac', N'07a68b20-6f08-eb11-80b4-34e6d743f8ac', CAST(360000.00 AS Decimal(15, 2)), 3)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'a3874767-3f0e-eb11-80b4-34e6d743f8ac', N'a2874767-3f0e-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'801bb348-410e-eb11-80b4-34e6d743f8ac', N'7f1bb348-410e-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'f6853451-410e-eb11-80b4-34e6d743f8ac', N'f5853451-410e-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'eeacf702-420e-eb11-80b4-34e6d743f8ac', N'edacf702-420e-eb11-80b4-34e6d743f8ac', N'9ed896d8-370e-eb11-80b4-34e6d743f8ac', CAST(800000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'fb56ea65-420e-eb11-80b4-34e6d743f8ac', N'fa56ea65-420e-eb11-80b4-34e6d743f8ac', N'9ed896d8-370e-eb11-80b4-34e6d743f8ac', CAST(800000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'c1be668c-420e-eb11-80b4-34e6d743f8ac', N'c0be668c-420e-eb11-80b4-34e6d743f8ac', N'9ed896d8-370e-eb11-80b4-34e6d743f8ac', CAST(800000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'63acb5b1-420e-eb11-80b4-34e6d743f8ac', N'62acb5b1-420e-eb11-80b4-34e6d743f8ac', N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', CAST(150000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'7a298f1a-ff0e-eb11-80b4-34e6d743f8ac', N'79298f1a-ff0e-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'77ee77c5-060f-eb11-80b4-34e6d743f8ac', N'76ee77c5-060f-eb11-80b4-34e6d743f8ac', N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', CAST(1500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'78ee77c5-060f-eb11-80b4-34e6d743f8ac', N'76ee77c5-060f-eb11-80b4-34e6d743f8ac', N'c440a27b-060f-eb11-80b4-34e6d743f8ac', CAST(2000000.00 AS Decimal(15, 2)), 4)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'b077f2eb-060f-eb11-80b4-34e6d743f8ac', N'af77f2eb-060f-eb11-80b4-34e6d743f8ac', N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', CAST(1080000.00 AS Decimal(15, 2)), 4)
INSERT [dbo].[tblOrderDetail] ([detailID], [orderID], [productID], [price], [quantity]) VALUES (N'fd47d7c8-080f-eb11-80b4-34e6d743f8ac', N'fc47d7c8-080f-eb11-80b4-34e6d743f8ac', N'c440a27b-060f-eb11-80b4-34e6d743f8ac', CAST(500000.00 AS Decimal(15, 2)), 1)
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'48f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'Cash')
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'49f7ec35-ba0c-eb11-80b4-34e6d743f8ac', N'MOMO')
INSERT [dbo].[tblPayment] ([paymentID], [name]) VALUES (N'8366be3d-ba0c-eb11-80b4-34e6d743f8ac', N'PayPal')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'05a68b20-6f08-eb11-80b4-34e6d743f8ac', N'Banh trung thu trung muoi Nhu Lan', CAST(120000.00 AS Decimal(15, 2)), 68, N'image/banh-trung-thu.jpg', N'', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f3701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'06a68b20-6f08-eb11-80b4-34e6d743f8ac', N'Banh trung thu trung muoi Kinh Do', CAST(200000.00 AS Decimal(15, 2)), 69, N'image/banh-trung-thu.jpg', N'', CAST(N'2020-09-29 00:00:00.000' AS DateTime), CAST(N'2020-12-24 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'07a68b20-6f08-eb11-80b4-34e6d743f8ac', N'Banh trung thu trung muoi Girval', CAST(120000.00 AS Decimal(15, 2)), 53, N'image/banh-trung-thu.jpg', N'', CAST(N'2020-09-30 00:00:00.000' AS DateTime), CAST(N'2020-11-30 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'08a68b20-6f08-eb11-80b4-34e6d743f8ac', N'Banh trung thu thap cam Nhu Lan', CAST(150000.00 AS Decimal(15, 2)), 70, N'image/banh-trung-thu.jpg', N'', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f3701567-bb07-eb11-80b4-34e6d743f8ac', N'Inactive')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'733432e7-f409-eb11-80b4-34e6d743f8ac', N'Banh trung thu thap cam Kinh Do', CAST(150000.00 AS Decimal(15, 2)), 80, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'5ee67308-f509-eb11-80b4-34e6d743f8ac', N'Banh trung thu dau xanh Kinh Do', CAST(150000.00 AS Decimal(15, 2)), 80, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'5fe67308-f509-eb11-80b4-34e6d743f8ac', N'Banh deo Kinh Do', CAST(150000.00 AS Decimal(15, 2)), 80, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-10-12 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'60e67308-f509-eb11-80b4-34e6d743f8ac', N'Banh trung thu sau rieng Kinh Do', CAST(180000.00 AS Decimal(15, 2)), 80, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'61e67308-f509-eb11-80b4-34e6d743f8ac', N'Banh trung thu dau do Kinh Do', CAST(150000.00 AS Decimal(15, 2)), 80, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'ef3a40e0-ad0a-eb11-80b4-34e6d743f8ac', N'Banh trung thu deo Nhu Lan', CAST(220000.00 AS Decimal(15, 2)), 50, N'image/banh-trung-thu.jpg', N'Delicious', CAST(N'2020-09-28 00:00:00.000' AS DateTime), CAST(N'2020-10-29 00:00:00.000' AS DateTime), N'f3701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'5e569497-270b-eb11-80b4-34e6d743f8ac', N'Hop banh trung thu 4 banh Kinh Do', CAST(520000.00 AS Decimal(15, 2)), 16, N'image/kich-thuoc-hop-banh-trung-thu (2).jpg', N'4 banh trung thu trong mot hop', CAST(N'2020-09-19 00:00:00.000' AS DateTime), CAST(N'2020-11-08 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'a45aa7ce-270b-eb11-80b4-34e6d743f8ac', N'Hop banh trung thu cao cap', CAST(1400000.00 AS Decimal(15, 2)), 10, N'image/hop-banh-trung-thu-cao-cap.jpg', N'', CAST(N'2020-09-24 00:00:00.000' AS DateTime), CAST(N'2020-11-20 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'542bb36f-9f0b-eb11-80b4-34e6d743f8ac', N'Hop banh trung thu cao cap Girval', CAST(1500000.00 AS Decimal(15, 2)), 27, N'image/hop-banh-trung-thu-cao-cap.jpg', N'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Consequatur quidem, consectetur tempore tempora quisquam magnam? Deserunt velit, neque tempora omnis quam, dolorum quia saepe maxime, adipisci corrupti recusandae labore sapiente.', CAST(N'2020-10-06 00:00:00.000' AS DateTime), CAST(N'2020-11-05 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'0b27c33d-b70c-eb11-80b4-34e6d743f8ac', N'Banh trung thu dau do Girval', CAST(270000.00 AS Decimal(15, 2)), 72, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-10-15 00:00:00.000' AS DateTime), CAST(N'2020-12-15 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'c8b920a2-b70c-eb11-80b4-34e6d743f8ac', N'Banh trung thu sau rieng Girval', CAST(600000.00 AS Decimal(15, 2)), 50, N'image/banh-trung-thu.jpg', N'ngon lam a', CAST(N'2020-09-15 00:00:00.000' AS DateTime), CAST(N'2020-11-15 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'9ed896d8-370e-eb11-80b4-34e6d743f8ac', N'Hop 4 banh trung thu cao cap', CAST(800000.00 AS Decimal(15, 2)), 27, N'image/kich-thuoc-hop-banh-trung-thu (2).jpg', N'', CAST(N'2020-09-30 00:00:00.000' AS DateTime), CAST(N'2020-10-30 00:00:00.000' AS DateTime), N'129e98c7-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblProduct] ([productID], [name], [price], [quantity], [image], [description], [creationDate], [expirationDate], [categoryID], [status]) VALUES (N'c440a27b-060f-eb11-80b4-34e6d743f8ac', N'Hop 4 banh trung thu cao cap', CAST(500000.00 AS Decimal(15, 2)), 45, N'image/hop-banh-trung-thu-cao-cap.jpg', N'', CAST(N'2020-10-08 00:00:00.000' AS DateTime), CAST(N'2020-10-23 00:00:00.000' AS DateTime), N'f4701567-bb07-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'56dde103-3107-eb11-80b4-34e6d743f8ac', N'Admin')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'User')
INSERT [dbo].[tblRole] ([roleID], [name]) VALUES (N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Guest')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 02:27:090123456789', N'Nguyen Thi Hieu', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456789', N'TPHCM', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 02:42:540123456789', N'Luu Dieu Hoa', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456789', N'TG', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 13:21:140123456897', N'Hieu nguyen', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456897', N'Ninh Thuan', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 14:08:010123456897', N'Hieu nguyen', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456897', N'Ninh Thuan', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 14:08:290123456897', N'Hieu nguyen', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456897', N'Ninh Thuan', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 14:09:290123456789', N'Nguyen Thi Hieu', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456789', N'TPHCM', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/13 14:10:360123456789', N'Nguyen Thi Hieu', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456789', N'TPHCM', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'2020/10/15 22:57:190123456789', N'Nguyen Thi Hieu', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'0123456789', N'TPHCM', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'hieunt123456', N'Nguyen Thi Hieu', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'123 Le Van Viet', N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'labwebfptu@gmail.com', N'labwebfptu', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'          ', N'', N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongpt', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'122 Le Van Viet', N'56dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongpt123', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'788 Le Van Viet', N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongpt456', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'123 Le Van Viet', N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongpt789', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'321 Le Van Viet', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongptp', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'455 Le Van Viet', N'56dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'phuongpttkd', N'Pham Thanh Phuong', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'0123456789', N'456 Le Van Viet', N'01b1cf0b-3107-eb11-80b4-34e6d743f8ac', N'Active')
INSERT [dbo].[tblUser] ([userID], [name], [password], [phone], [address], [roleID], [status]) VALUES (N'taekwondo.ptp@gmail.com', N'taekwondo.ptp', N'b12a28795e265f283bab5f65cfe807e649961d9914c5e9f7c1a6c3ffba1b5da2', N'          ', N'', N'57dde103-3107-eb11-80b4-34e6d743f8ac', N'Active')
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblProduct]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblUser] FOREIGN KEY([userID])
REFERENCES [dbo].[tblUser] ([userID])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblUser]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblPayment] FOREIGN KEY([paymentID])
REFERENCES [dbo].[tblPayment] ([paymentID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblPayment]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrder] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([productID])
REFERENCES [dbo].[tblProduct] ([productID])
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([roleID])
REFERENCES [dbo].[tblRole] ([roleID])
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [YellowMoonShop] SET  READ_WRITE 
GO
