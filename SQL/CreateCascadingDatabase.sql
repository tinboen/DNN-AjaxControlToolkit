USE [master]
GO

/****** Object:  Database [Cascading_ddl]    Script Date: 11/4/2012 4:04:19 PM ******/
CREATE DATABASE [Cascading_ddl] 
GO



IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [constr].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [constr] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [constr] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [constr] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [constr] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [constr] SET ARITHABORT OFF 
GO

ALTER DATABASE [constr] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [constr] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [constr] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [constr] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [constr] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [constr] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [constr] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [constr] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [constr] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [constr] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [constr] SET  DISABLE_BROKER 
GO

ALTER DATABASE [constr] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [constr] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [constr] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [constr] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [constr] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [constr] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [constr] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [constr] SET  MULTI_USER 
GO

ALTER DATABASE [constr] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [constr] SET DB_CHAINING OFF 
GO

ALTER DATABASE [constr] SET  READ_WRITE 
GO

USE [constr]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Countries](
	[CountryId] [int] NOT NULL,
	[CountryName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[States](
	[StateId] [int] NOT NULL,
	[CountryId] [int] NOT NULL,
	[StateName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[States]  WITH CHECK ADD  CONSTRAINT [FK_States_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO

ALTER TABLE [dbo].[States] CHECK CONSTRAINT [FK_States_Countries]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Cities](
	[CityId] [int] NOT NULL,
	[StateId] [int] NOT NULL,
	[CityName] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Cities] PRIMARY KEY CLUSTERED 
(
	[CityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Cities]  WITH CHECK ADD  CONSTRAINT [FK_Cities_States] FOREIGN KEY([StateId])
REFERENCES [dbo].[States] ([StateId])
GO

ALTER TABLE [dbo].[Cities] CHECK CONSTRAINT [FK_Cities_States]
GO


insert into Countries
select 1,'USA'
union all
select 2,'India'
union all
select 3,'Canada'
go
insert into States
select 1,1,'Alabama'
union all
select 2,1,'Arizona'
union all
select 3,1,'Alaska'
union all
select 4,2,'Maharashtra'
union all
select 5,2,'Gujarat'
union all
select 6,2,'Goa'
union all
select 7,3,'Ontario'
union all
select 8,3,'Quebec'
union all
select 9,3,'Manitoba'
go
insert into Cities
select 1,1,'Abbeville'
union all
select 2,1,'Argo'
union all
select 3,2,'Buckeye'
union all
select 4,2,'Carefree'
union all
select 5,3,'Juneau'
union all
select 6,3,'Sitka'
union all
select 7,4,'Mumbai'
union all
select 8,4,'Pune'
union all
select 9,5,'Ahmedabad'
union all
select 10,5,'Gandhinagar'
union all
select 11,6,'Panjim'
union all
select 12,6,'Vasco'
union all
select 13,7,'Ottawa'
union all
select 14,7,'Port Hope'
union all
select 15,8,'Chandler'
union all
select 16,8,'Princeville'
union all
select 17,9,'Carman'
union all
select 18,9,'Roblin'
