USE [master]
GO
/****** Object:  Database [AMS]    Script Date: 4/13/2020 2:43:15 PM ******/
CREATE DATABASE [AMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AMS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [AMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AMS] SET RECOVERY FULL 
GO
ALTER DATABASE [AMS] SET  MULTI_USER 
GO
ALTER DATABASE [AMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AMS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AMS', N'ON'
GO
ALTER DATABASE [AMS] SET QUERY_STORE = OFF
GO
USE [AMS]
GO
/****** Object:  Table [dbo].[tblManager]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblManager](
	[ManagerId] [nvarchar](10) NOT NULL,
	[ManagerName] [nvarchar](50) NOT NULL,
	[SocialSecurityNo] [char](15) NOT NULL,
	[DateOfbirth] [date] NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[MobileNo] [char](15) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[AddressId] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_ManagerId_tblManager] PRIMARY KEY CLUSTERED 
(
	[ManagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPlaneAllocation]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPlaneAllocation](
	[PlaneID] [nvarchar](10) NOT NULL,
	[HangerID] [nvarchar](10) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
 CONSTRAINT [PK_tblPlaneAllocation] PRIMARY KEY CLUSTERED 
(
	[PlaneID] ASC,
	[HangerID] ASC,
	[StartDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblHanger]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHanger](
	[Hanger_ID] [nvarchar](10) NOT NULL,
	[HangerLocation] [nvarchar](50) NOT NULL,
	[HangerCapacity] [int] NOT NULL,
	[ManagerId] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_HangerId_tblHanger] PRIMARY KEY CLUSTERED 
(
	[Hanger_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_search]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_search]
AS
SELECT dbo.tblHanger.Hanger_ID, dbo.tblHanger.HangerLocation, dbo.tblManager.ManagerName, dbo.tblManager.SocialSecurityNo
FROM     dbo.tblHanger INNER JOIN
                  dbo.tblManager ON dbo.tblHanger.ManagerId = dbo.tblManager.ManagerId
WHERE  (dbo.tblHanger.HangerCapacity >=
                      (SELECT COUNT(*) AS CountOfHangerId
                       FROM      dbo.tblPlaneAllocation
                       WHERE   (HangerID = dbo.tblHanger.Hanger_ID)))
GO
/****** Object:  Table [dbo].[tblAddress]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAddress](
	[AddressId] [nvarchar](10) NOT NULL,
	[HouseNo] [nvarchar](10) NOT NULL,
	[AddressLine1] [nvarchar](50) NOT NULL,
	[City] [nvarchar](20) NOT NULL,
	[State] [nvarchar](20) NOT NULL,
	[Country] [nvarchar](20) NOT NULL,
	[PinNo] [int] NOT NULL,
 CONSTRAINT [PK_AddressId_tblAddress] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLogin]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLogin](
	[UserID] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_UserId_tblLogin] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPilot]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPilot](
	[Pilot_ID] [nvarchar](10) NOT NULL,
	[PilotName] [nvarchar](50) NOT NULL,
	[LicenseNo] [bigint] NOT NULL,
	[SocialSecurityNo] [char](15) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
	[Gender] [nvarchar](10) NOT NULL,
	[MobileNo] [char](15) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[AddressId] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_PilotId_tblPilot] PRIMARY KEY CLUSTERED 
(
	[Pilot_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPlane]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPlane](
	[PlaneID] [nvarchar](10) NOT NULL,
	[Manufacturer_Name] [nvarchar](50) NOT NULL,
	[Registration_No] [nvarchar](10) NOT NULL,
	[ModelNo] [nvarchar](10) NOT NULL,
	[PlaneName] [nvarchar](50) NOT NULL,
	[Capacity] [int] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[pilot_ID] [nvarchar](10) NOT NULL,
	[AddressId] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_PlaneId_tblPlane] PRIMARY KEY CLUSTERED 
(
	[PlaneID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Che101', N'8-30', N'siruseri', N'Chennai', N'TamilNadu', N'India', 600030)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Che102', N'1-8/A', N'siruseri', N'Chennai', N'TamilNadu', N'India', 600019)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Gun101', N'1-8-90', N'Guntur', N'Guntur', N'Telangana', N'India', 505399)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd101', N'8-2-30/B', N'Gachibowli', N'Hyderabad', N'Telangana', N'India', 500019)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd102', N'7-40', N'Somajiguda', N'Hyderabad', N'Telangana', N'India', 500456)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd103', N'6-89', N'Kukattpally', N'Hyderabad', N'Telangana', N'India', 500034)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd104', N'6-7/A', N'Somajiguda', N'Hyderabad', N'Telangana', N'India', 500507)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd105', N'4-30', N'Gachibowli', N'Hyderabad', N'Telangana', N'India', 500589)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Hyd106', N'6-57/A', N'Hyderabad', N'Hyderabad', N'Telangana', N'India', 505678)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Koc101', N'2-9-10', N'Kochi', N'Kochi', N'Kerala', N'India', 680001)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Man101', N'10-26/2', N'GouthamiNagar', N'Mancherial', N'Telangana', N'India', 504208)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Mum101', N'9-11', N'Mumbai', N'Mumbai', N'Maharastra', N'India', 800011)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Mum102', N'9-22', N'Mumbai', N'Mumbai', N'Maharastra', N'India', 800011)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Mum103', N'1-34-2/A', N'Mumbai', N'Mumbai', N'Maharastra', N'India', 700011)
INSERT [dbo].[tblAddress] ([AddressId], [HouseNo], [AddressLine1], [City], [State], [Country], [PinNo]) VALUES (N'Ped101', N'8-30', N'Kolanoor', N'Peddapalli', N'Telangana', N'India', 505162)
INSERT [dbo].[tblHanger] ([Hanger_ID], [HangerLocation], [HangerCapacity], [ManagerId]) VALUES (N'Blo101', N'BlockA', 3, N'505031')
INSERT [dbo].[tblHanger] ([Hanger_ID], [HangerLocation], [HangerCapacity], [ManagerId]) VALUES (N'Blo102', N'BlockA', 2, N'601231')
INSERT [dbo].[tblHanger] ([Hanger_ID], [HangerLocation], [HangerCapacity], [ManagerId]) VALUES (N'Che101', N'Chennai', 4, N'789031')
INSERT [dbo].[tblHanger] ([Hanger_ID], [HangerLocation], [HangerCapacity], [ManagerId]) VALUES (N'Hyd101', N'Hyderabad', 4, N'701231')
INSERT [dbo].[tblHanger] ([Hanger_ID], [HangerLocation], [HangerCapacity], [ManagerId]) VALUES (N'Mum101', N'Mumbai', 3, N'896831')
INSERT [dbo].[tblLogin] ([UserID], [Password]) VALUES (N'admin', N'1234')
INSERT [dbo].[tblManager] ([ManagerId], [ManagerName], [SocialSecurityNo], [DateOfbirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'505031', N'Anusha', N'7896785050     ', CAST(N'1995-11-07' AS Date), N'Female', N'8908908899     ', N'anusha_reddy@mail.com', N'Hyd103')
INSERT [dbo].[tblManager] ([ManagerId], [ManagerName], [SocialSecurityNo], [DateOfbirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'601231', N'Anusha Reddy', N'5558886012     ', CAST(N'1994-07-11' AS Date), N'Female', N'8999799789     ', N'anusha_reddy567@gmail.com', N'Hyd106')
INSERT [dbo].[tblManager] ([ManagerId], [ManagerName], [SocialSecurityNo], [DateOfbirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'701231', N'Pranitha', N'9989447012     ', CAST(N'1995-11-21' AS Date), N'Female', N'9032226412     ', N'pranitha_123@mail.com', N'Man101')
INSERT [dbo].[tblManager] ([ManagerId], [ManagerName], [SocialSecurityNo], [DateOfbirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'789031', N'Ravi', N'7779997890     ', CAST(N'1995-11-21' AS Date), N'Female', N'7896788989     ', N'ravi46576_90@gmail.com', N'Che102')
INSERT [dbo].[tblManager] ([ManagerId], [ManagerName], [SocialSecurityNo], [DateOfbirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'896831', N'Raghav', N'6578678968     ', CAST(N'1990-04-13' AS Date), N'Male', N'8000900890     ', N'raghav.musi2@gmail.com', N'Mum103')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'493531', N'RaviVarma', 6778975610, N'7867564935     ', CAST(N'1997-11-03' AS Date), N'Male', N'8989765024     ', N'ravivarma_456@gmail.com', N'Hyd104')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'623231', N'Srinivas', 8999422678, N'9000116232     ', CAST(N'1985-10-25' AS Date), N'Male', N'9849257714     ', N'srinivas_456@gmail.com', N'Ped101')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'666831', N'Rohan', 8889997776, N'4445556668     ', CAST(N'1995-04-07' AS Date), N'Male', N'8886888868     ', N'rohan_123@gmail.com', N'Hyd101')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'678831', N'Nandhana', 7898567898, N'5678456788     ', CAST(N'1997-04-08' AS Date), N'Female', N'7667788557     ', N'nandhana89@gmail.com', N'Mum101')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'705831', N'Harika', 5558884530, N'6663337058     ', CAST(N'1995-11-16' AS Date), N'Female', N'7997637714     ', N'harikakavya111@gmail.com', N'Gun101')
INSERT [dbo].[tblPilot] ([Pilot_ID], [PilotName], [LicenseNo], [SocialSecurityNo], [DateOfBirth], [Gender], [MobileNo], [EmailAddress], [AddressId]) VALUES (N'776631', N'John', 5656787845, N'9998887766     ', CAST(N'1990-08-05' AS Date), N'Male', N'8000183828     ', N'john256_6@gmail.com', N'Koc101')
INSERT [dbo].[tblPlane] ([PlaneID], [Manufacturer_Name], [Registration_No], [ModelNo], [PlaneName], [Capacity], [Email], [pilot_ID], [AddressId]) VALUES (N'345631', N'Rosely', N'5678903456', N'7889906789', N'Autogyro', 20, N'rosely2@gmail.com', N'678831', N'Che101')
INSERT [dbo].[tblPlane] ([PlaneID], [Manufacturer_Name], [Registration_No], [ModelNo], [PlaneName], [Capacity], [Email], [pilot_ID], [AddressId]) VALUES (N'676631', N'Raghu', N'5678456766', N'7777896788', N'jet', 25, N'raghu234@gmail.com', N'666831', N'Mum102')
INSERT [dbo].[tblPlane] ([PlaneID], [Manufacturer_Name], [Registration_No], [ModelNo], [PlaneName], [Capacity], [Email], [pilot_ID], [AddressId]) VALUES (N'884531', N'Rina', N'7777888845', N'Ah12356723', N'Autogyro', 20, N'rina123_45@mail.com', N'623231', N'Hyd102')
INSERT [dbo].[tblPlane] ([PlaneID], [Manufacturer_Name], [Registration_No], [ModelNo], [PlaneName], [Capacity], [Email], [pilot_ID], [AddressId]) VALUES (N'896531', N'Arha', N'7867678965', N'7856347656', N'Autogyro', 20, N'arha_34578@gmail.com', N'493531', N'Hyd105')
INSERT [dbo].[tblPlaneAllocation] ([PlaneID], [HangerID], [StartDate], [EndDate]) VALUES (N'345631', N'Che101', CAST(N'2020-04-24' AS Date), CAST(N'2020-09-16' AS Date))
INSERT [dbo].[tblPlaneAllocation] ([PlaneID], [HangerID], [StartDate], [EndDate]) VALUES (N'676631', N'Hyd101', CAST(N'2020-04-14' AS Date), CAST(N'2020-04-16' AS Date))
INSERT [dbo].[tblPlaneAllocation] ([PlaneID], [HangerID], [StartDate], [EndDate]) VALUES (N'676631', N'Hyd101', CAST(N'2020-04-18' AS Date), CAST(N'2021-04-01' AS Date))
INSERT [dbo].[tblPlaneAllocation] ([PlaneID], [HangerID], [StartDate], [EndDate]) VALUES (N'896531', N'Blo102', CAST(N'2020-04-23' AS Date), CAST(N'2021-03-16' AS Date))
ALTER TABLE [dbo].[tblHanger]  WITH CHECK ADD  CONSTRAINT [FK_MangerId_tblHanger] FOREIGN KEY([ManagerId])
REFERENCES [dbo].[tblManager] ([ManagerId])
GO
ALTER TABLE [dbo].[tblHanger] CHECK CONSTRAINT [FK_MangerId_tblHanger]
GO
ALTER TABLE [dbo].[tblManager]  WITH CHECK ADD  CONSTRAINT [FK_AddressId_tblManager] FOREIGN KEY([AddressId])
REFERENCES [dbo].[tblAddress] ([AddressId])
GO
ALTER TABLE [dbo].[tblManager] CHECK CONSTRAINT [FK_AddressId_tblManager]
GO
ALTER TABLE [dbo].[tblPilot]  WITH CHECK ADD  CONSTRAINT [FK_addressId_tblPilot] FOREIGN KEY([AddressId])
REFERENCES [dbo].[tblAddress] ([AddressId])
GO
ALTER TABLE [dbo].[tblPilot] CHECK CONSTRAINT [FK_addressId_tblPilot]
GO
ALTER TABLE [dbo].[tblPlane]  WITH CHECK ADD  CONSTRAINT [FK_addressId_tblPlane] FOREIGN KEY([AddressId])
REFERENCES [dbo].[tblAddress] ([AddressId])
GO
ALTER TABLE [dbo].[tblPlane] CHECK CONSTRAINT [FK_addressId_tblPlane]
GO
ALTER TABLE [dbo].[tblPlane]  WITH CHECK ADD  CONSTRAINT [FK_pilotID_tblPlane] FOREIGN KEY([pilot_ID])
REFERENCES [dbo].[tblPilot] ([Pilot_ID])
GO
ALTER TABLE [dbo].[tblPlane] CHECK CONSTRAINT [FK_pilotID_tblPlane]
GO
/****** Object:  StoredProcedure [dbo].[sp_Address]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Address]
@city nvarchar(20)
 as 
 begin
select top 1 AddressId from tblAddress where substring(AddressId,0,4)=substring(@city,0,4) 
order by AddressId desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_AvailableHangersDetails]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_AvailableHangersDetails]
 @f date,@t date
 as
 Begin
 select * from (
 Select H.Hanger_ID,HangerLocation,HangerCapacity-isnull
            ((Select cnt from 
			(Select hangerid,Count(*) cnt from tblPlaneAllocation A where
            (StartDate  between @f and @t)
                or
            (EndDate  between @f and @t)  
                group by A.HangerID) C
				where C.HangerID=H.Hanger_ID),0) AvaiableCapacity, m.ManagerName from tblHanger H 
    
	inner join tblmanager m on m.managerId=H.managerId) T
	where T.AvaiableCapacity>0
End
GO
/****** Object:  StoredProcedure [dbo].[sp_getPilotId]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_getPilotId] 
as
BEGIN
	
	select * from tblPilot where Pilot_ID not in (select Pilot_ID from tblPlane)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getStatus]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_getStatus]
@hno nvarchar(10),@stdt date,
@endt date
as
begin


select HangerID,Hangerlocation,StartDate,EndDate,PlaneID from tblPlaneAllocation 
inner join tblhanger on HangerID=Hanger_ID
where HangerID=@hno and ((startdate between @stdt and @endt)
or (enddate between @stdt and @endt))
union
(select Hanger_ID,Hangerlocation,@stdt as StartDate,@endt EndDate,'' PlaneID from tblHanger where Hanger_ID=@hno and 
HangerCapacity>isnull(
(select cnt from (select hangerid,count(*) cnt from tblplaneallocation A where HangerID=@hno and ((startdate between @stdt and @endt)
or (enddate between @stdt and @endt)) group by A.hangerid) c ),0)
)

end
GO
/****** Object:  StoredProcedure [dbo].[sp_Hanger]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Hanger]
@location nvarchar(50)
 as 
 begin
select top 1 Hanger_ID from tblHanger where substring(Hanger_ID,0,4)=substring(@location,0,4) 
order by Hanger_ID desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Manager]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_Manager]
@socialsecurityno char(15)
as
begin
select top 1 ManagerId from tblManager where SUBSTRING(ManagerId,0,5)=SUBSTRING(@socialsecurityno,LEN(@socialsecurityno)-3,5)
order by ManagerId desc

end
GO
/****** Object:  StoredProcedure [dbo].[sp_Pilot]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Pilot]
@socialsecurityno char(15)
as
begin
select top 1 Pilot_ID from tblPilot where SUBSTRING(Pilot_ID,0,5)=SUBSTRING(@socialsecurityno,LEN(@socialsecurityno)-3,5)
order by Pilot_ID desc
end
GO
/****** Object:  StoredProcedure [dbo].[sp_Plane]    Script Date: 4/13/2020 2:43:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Plane]
@regno char(15)
as
begin
select top 1 PlaneID from tblPlane where SUBSTRING(PlaneID,0,5)=SUBSTRING(@regno,LEN(@regno)-3,5)
order by PlaneID desc
end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tblHanger"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tblManager"
            Begin Extent = 
               Top = 7
               Left = 297
               Bottom = 170
               Right = 504
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_search'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_search'
GO
USE [master]
GO
ALTER DATABASE [AMS] SET  READ_WRITE 
GO
