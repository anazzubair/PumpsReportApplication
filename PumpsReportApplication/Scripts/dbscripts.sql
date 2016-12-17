USE [master]
GO
/****** Object:  Database [PumpsDB]    Script Date: 6/6/2016 1:12:34 PM ******/
CREATE DATABASE [PumpsDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PumpsDB', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PumpsDB.mdf' , SIZE = 24576KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'PumpsDB_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\PumpsDB_log.ldf' , SIZE = 6272KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PumpsDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PumpsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PumpsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PumpsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PumpsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PumpsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PumpsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PumpsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PumpsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PumpsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PumpsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PumpsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PumpsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PumpsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PumpsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PumpsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PumpsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PumpsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PumpsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PumpsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PumpsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PumpsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PumpsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PumpsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PumpsDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PumpsDB] SET  MULTI_USER 
GO
ALTER DATABASE [PumpsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PumpsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PumpsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PumpsDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [PumpsDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PumpsDB', N'ON'
GO
USE [PumpsDB]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StationId] [bigint] NOT NULL,
	[PumpId] [bigint] NOT NULL,
	[TotalRunHours] [decimal](18, 2) NOT NULL,
	[NumberOfFaults] [bigint] NOT NULL,
	[Pressure] [decimal](18, 2) NOT NULL,
	[Amps] [decimal](18, 2) NOT NULL,
	[MainsKWH] [decimal](18, 2) NOT NULL,
	[GeneratorKWH] [decimal](18, 2) NOT NULL,
	[IsFault] [nchar](1) NOT NULL CONSTRAINT [DF_Message_IsFault]  DEFAULT ('N'),
	[MessageTime] [datetime] NOT NULL CONSTRAINT [DF_Message_MessageTime]  DEFAULT (getdate()),
	[ReceiveTime] [datetime] NOT NULL CONSTRAINT [DF_Message_ReceiveTime]  DEFAULT (getdate()),
 CONSTRAINT [PK_Message] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pump]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pump](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[StationId] [bigint] NOT NULL,
 CONSTRAINT [PK_Pumps] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Station]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Station](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_Stations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](250) NOT NULL,
	[Passowrd] [nvarchar](250) NOT NULL,
	[IsActive] [nchar](1) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[DailyReportView]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[DailyReportView]
AS
SELECT        row_number() over (order by CONVERT(date, MessageTime), StationId, PumpId) AS Id, CONVERT(date, MessageTime) AS MessageDate, StationId, PumpId, 
			  MAX(TotalRunHours) AS TotalRunHours, MAX(DailyRunHours) AS DailyRunHours, MAX(NumberOfFaults) AS NumberOfFaults, AVG(Pressure) AS Pressure, AVG(Amps) AS Amps, 
				MAX(GeneratorKWH) AS GeneratorKWH, MAX(MainsKWH) AS MainsKWH, Pump AS Pump, Station AS Station
FROM            dbo.MessageView
GROUP BY CONVERT(date, MessageTime), StationId, Station, PumpId, Pump
GO
/*
Alternate sql which does not depend on messageview and directly calculates, but very slow. Does not hit index for messagetime
SELECT        row_number() over (order by CONVERT(date, dbo.Message.MessageTime), dbo.Message.StationId, dbo.Message.PumpId) AS Id, 
				(max(totalrunhours) - ISNULL((select max(mm.totalrunhours) from message mm 
						where convert(date, dateadd(dd, 1, mm.messagetime)) = CONVERT(date, dbo.Message.MessageTime)
						and mm.stationid = dbo.message.stationid and mm.pumpid = dbo.message.pumpid),0)) as DailyRunHours,
				CONVERT(date, dbo.Message.MessageTime) AS MessageDate, dbo.Message.StationId, dbo.Message.PumpId, MAX(dbo.Message.TotalRunHours) AS TotalRunHours, 
                MAX(dbo.Message.NumberOfFaults) AS NumberOfFaults, AVG(dbo.Message.Pressure) AS Pressure, 
				AVG(dbo.Message.Amps) AS Amps, MAX(dbo.Message.GeneratorKWH) AS GeneratorKWH, MAX(dbo.Message.MainsKWH) AS MainsKWH, 
				dbo.Pump.Name AS Pump, dbo.Station.Name AS Station
FROM            dbo.Message INNER JOIN
                dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
                dbo.Station ON dbo.Message.StationId = dbo.Station.Id
GROUP BY CONVERT(date, dbo.Message.MessageTime), dbo.Message.StationId, dbo.Station.Name, dbo.Message.PumpId, dbo.Pump.Name
GO*/
/****** Object:  View [dbo].[MessageView]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MessageView]
AS
SELECT        dbo.Message.Id, dbo.Message.StationId, dbo.Message.PumpId, 
  dbo.Pump.Name AS Pump, dbo.Station.Name AS Station,
  dbo.Message.TotalRunHours, 
  dbo.Message.TotalRunHours -
							isnull((select max(m.TotalRunHours) as TotalRunHours from message m
							  where m.stationid = dbo.Message.stationid and m.pumpid = dbo.Message.pumpid 
							  and convert(date, m.messagetime) = convert(date, dateadd(dd, -1, dbo.Message.messagetime))
							),0) as DailyRunHours,
  dbo.Message.NumberOfFaults, dbo.Message.Pressure, 
  dbo.Message.Amps, dbo.Message.MainsKWH, dbo.Message.GeneratorKWH, 
  dbo.Message.IsFault, dbo.Message.MessageTime, dbo.Message.ReceiveTime
FROM dbo.Message INNER JOIN
     dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
     dbo.Station ON dbo.Message.StationId = dbo.Station.Id

GO
/****** Object:  View [dbo].[MonthlyReportView]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MonthlyReportView]
AS
SELECT row_number() OVER (ORDER BY DATEPART(m, messagetime), DATEPART(yyyy, messagetime), dbo.Message.StationId, dbo.Message.PumpId) AS Id, 
(max(totalrunhours) - ISNULL((select max(mm.totalrunhours) from message mm 
						where DATEPART(m, dateadd(m, 1, mm.messagetime)) = DATEPART(m, dbo.message.messagetime)
						AND DATEPART(yyyy, dateadd(m, 1, mm.messagetime)) = DATEPART(yyyy, dbo.message.messagetime)
						and mm.stationid = dbo.message.stationid and mm.pumpid = dbo.message.pumpid),0)) as MonthlyRunHours,
datefromparts(datepart(yyyy, messagetime), datepart(m,messagetime), 1) AS MessageDate, dbo.Message.StationId, dbo.Message.PumpId, 
MAX(dbo.Message.TotalRunHours) AS TotalRunHours, 
SUM(dbo.Message.NumberOfFaults) AS NumberOfFaults, 
AVG(dbo.Message.Pressure) AS Pressure, AVG(dbo.Message.Amps) AS Amps, MAX(dbo.Message.GeneratorKWH) 
AS GeneratorKWH, MAX(dbo.Message.MainsKWH) AS MainsKWH, dbo.Pump.Name AS Pump, 
dbo.Station.Name AS Station
FROM dbo.Message INNER JOIN
    dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
    dbo.Station ON dbo.Message.StationId = dbo.Station.Id
GROUP BY DATEPART(m, messagetime), DATEPART(yyyy, messagetime), 
    dbo.Message.StationId, dbo.Station.Name, dbo.Message.PumpId, dbo.Pump.Name

GO
/****** Object:  View [dbo].[YearlyReportView]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[YearlyReportView]
AS
SELECT        row_number() over (order by YEAR(messagetime), dbo.Message.StationId, dbo.Message.PumpId) AS Id, 
			YEAR(messagetime) AS MessageDate, 
			(max(totalrunhours) - ISNULL((select max(mm.totalrunhours) from message mm 
						where DATEPART(yyyy, dateadd(yyyy, 1, mm.messagetime)) = DATEPART(yyyy, dbo.message.messagetime)
						and mm.stationid = dbo.message.stationid and mm.pumpid = dbo.message.pumpid),0)) as YearlyRunHours,
			dbo.Message.StationId, dbo.Message.PumpId, MAX(dbo.Message.TotalRunHours) AS TotalRunHours, 
                         SUM(dbo.Message.NumberOfFaults) AS NumberOfFaults, AVG(dbo.Message.Pressure) AS Pressure, 
						 AVG(dbo.Message.Amps) AS Amps, 
                         MAX(dbo.Message.GeneratorKWH) AS GeneratorKWH, MAX(dbo.Message.MainsKWH) AS MainsKWH, dbo.Pump.Name AS Pump, 
						 dbo.Station.Name AS Station
FROM            dbo.Message INNER JOIN
                         dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
                         dbo.Station ON dbo.Message.StationId = dbo.Station.Id
GROUP BY DATEPART(yyyy, messagetime), dbo.Message.StationId, dbo.Station.Name, dbo.Message.PumpId, dbo.Pump.Name



GO
/****** Object:  Index [IX_Message_MessageTime]    Script Date: 6/6/2016 1:12:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_Message_MessageTime] ON [dbo].[Message]
(
	[MessageTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Pump] FOREIGN KEY([PumpId])
REFERENCES [dbo].[Pump] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Pump]
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD  CONSTRAINT [FK_Message_Station] FOREIGN KEY([StationId])
REFERENCES [dbo].[Station] ([Id])
GO
ALTER TABLE [dbo].[Message] CHECK CONSTRAINT [FK_Message_Station]
GO
ALTER TABLE [dbo].[Pump]  WITH CHECK ADD  CONSTRAINT [FK_Pump_Station] FOREIGN KEY([StationId])
REFERENCES [dbo].[Station] ([Id])
GO
ALTER TABLE [dbo].[Pump] CHECK CONSTRAINT [FK_Pump_Station]
GO
/****** Object:  StoredProcedure [dbo].[InsertMessage]    Script Date: 6/6/2016 1:12:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[InsertMessage] 
	@StationId bigint,
	@PumpId bigint,
	@TotalRunHours decimal(18,2),
	@NumberOfFaults bigint,
	@Pressure decimal(18,2),
	@Amps decimal(18,2),
	@MainsKWH decimal(18,2),
	@GeneratorKWH decimal(18,2),
	@IsFault nchar(1),
	@MessageTime datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PreviousDayTotalRunHours decimal(18,2), @DailyRunHours decimal(18,2)

    -- Insert statements for procedure here
	select @PreviousDayTotalRunHours = m.TotalRunHours from message m
	where m.stationid = @StationId and m.pumpid = @PumpId and m.messagetime = 
	(
		select max(mn.messagetime) from message mn 
		where mn.stationid = @stationid and mn.pumpid = @pumpid 
				and convert(date, mn.messagetime) = convert(date, dateadd(dd, -1, @MessageTime))
		group by mn.stationid, mn.pumpid, convert(date, mn.messagetime)
	)

	SET @DailyRunHours = @TotalRunHours - ISNULL(@PreviousDayTotalRunHours, 0)

	INSERT INTO [dbo].[Message] ([StationId], [PumpId], [TotalRunHours], [DailyRunHours], [NumberOfFaults], [Pressure],
				[Amps], [MainsKWH], [GeneratorKWH], [IsFault], [MessageTime], [ReceiveTime])
     VALUES (@StationId, @PumpId, @TotalRunHours, @DailyRunHours, @NumberOfFaults, @Pressure, @Amps, @MainsKWH, @GeneratorKWH, @IsFault,
			 @MessageTime, GetDate())

END
GO

/****** Object:  StoredProcedure [dbo].[getDailyReport]    Script Date: 6/30/2016 12:15:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[getDailyReportOld] 
	@StationId bigint,
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN

	SET NOCOUNT ON;

	SELECT        row_number() over (order by CONVERT(date, MessageTime), StationId, PumpId) AS Id, CONVERT(date, MessageTime) AS MessageDate, StationId, PumpId, 
				  MAX(TotalRunHours) AS TotalRunHours, MAX(DailyRunHours) AS DailyRunHours, MAX(NumberOfFaults) AS NumberOfFaults, AVG(Pressure) AS Pressure, AVG(Amps) AS Amps, 
					MAX(GeneratorKWH) AS GeneratorKWH, MAX(MainsKWH) AS MainsKWH, Pump AS Pump, Station AS Station
	FROM            
		(
			SELECT        dbo.Message.Id, dbo.Message.StationId, dbo.Message.PumpId, 
			  dbo.Pump.Name AS Pump, dbo.Station.Name AS Station,
			  dbo.Message.TotalRunHours, 
			  dbo.Message.TotalRunHours -
										isnull((select max(m.TotalRunHours) as TotalRunHours from message m
										  where m.stationid = dbo.Message.stationid and m.pumpid = dbo.Message.pumpid 
										  and convert(date, m.messagetime) = convert(date, dateadd(dd, -1, dbo.Message.messagetime))
										),0) as DailyRunHours,
			  dbo.Message.NumberOfFaults, dbo.Message.Pressure, 
			  dbo.Message.Amps, dbo.Message.MainsKWH, dbo.Message.GeneratorKWH, 
			  dbo.Message.IsFault, dbo.Message.MessageTime, dbo.Message.ReceiveTime
			FROM dbo.Message INNER JOIN
				 dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
				 dbo.Station ON dbo.Message.StationId = dbo.Station.Id
				 where dbo.Message.MessageTime >= @FromDate and dbo.Message.MessageTime < @ToDate and dbo.Message.StationId = @StationId
		) messageview
	GROUP BY CONVERT(date, MessageTime), StationId, Station, PumpId, Pump


END
GO


/****** Object:  StoredProcedure [dbo].[getDailyReport]    Script Date: 6/30/2016 1:45:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[getDailyReport] 
	@StationId bigint,
	@FromDate datetime,
	@ToDate datetime
AS
BEGIN

	SET NOCOUNT ON;

	SELECT        row_number() over (order by CONVERT(date, MessageTime), StationId, PumpId) AS Id, CONVERT(date, MessageTime) AS MessageDate, StationId, PumpId, 
				  MAX(TotalRunHours) AS TotalRunHours, MAX(DailyRunHours) AS DailyRunHours, MAX(NumberOfFaults) AS NumberOfFaults, AVG(Pressure) AS Pressure, AVG(Amps) AS Amps, 
					MAX(GeneratorKWH) AS GeneratorKWH, MAX(MainsKWH) AS MainsKWH, Pump AS Pump, Station AS Station
	FROM            
		(
			SELECT        dbo.Message.Id, dbo.Message.StationId, dbo.Message.PumpId, 
			  dbo.Pump.Name AS Pump, dbo.Station.Name AS Station,
			  dbo.Message.TotalRunHours, 
			  (dbo.Message.TotalRunHours - isnull(p.PreviousTotalRunHours,0)) as DailyRunHours,
			  dbo.Message.NumberOfFaults, dbo.Message.Pressure, 
			  dbo.Message.Amps, dbo.Message.MainsKWH, dbo.Message.GeneratorKWH, 
			  dbo.Message.IsFault, dbo.Message.MessageTime, dbo.Message.ReceiveTime
			FROM dbo.Message INNER JOIN
				 dbo.Pump ON dbo.Message.PumpId = dbo.Pump.Id INNER JOIN
				 dbo.Station ON dbo.Message.StationId = dbo.Station.Id
				 left join 
				 (
					select isnull(max(m.TotalRunHours), 0) as PreviousTotalRunHours, CONVERT(date, m.MessageTime) as MessageTime, m.StationId, m.PumpId
					from message m
					where m.MessageTime >= @FromDate and m.MessageTime < @ToDate and  m.StationId = @StationId
					GROUP BY CONVERT(date, m.MessageTime), m.StationId, m.PumpId
				 ) p on convert(date, p.messagetime) = convert(date, dateadd(dd, -1, dbo.Message.messagetime))
					 and p.stationid = dbo.Message.stationid and p.pumpid = dbo.Message.pumpid 
			where dbo.Message.MessageTime >= @FromDate and dbo.Message.MessageTime < @ToDate and dbo.Message.StationId = @StationId
		) messageview
	GROUP BY CONVERT(date, MessageTime), StationId, Station, PumpId, Pump


END
GO

USE [master]
GO
ALTER DATABASE [PumpsDB] SET  READ_WRITE 
GO
