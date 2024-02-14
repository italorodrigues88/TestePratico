USE [master]
GO

CREATE DATABASE [dbTeste]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ddbTeste', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbTeste\dbTeste.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'dbTeste_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbTeste\dbTeste_log.ldf' , SIZE = 7616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbTeste].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [dbTeste] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [dbTeste] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [dbTeste] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [dbTeste] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [dbTeste] SET ARITHABORT OFF 
GO

ALTER DATABASE [dbTeste] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [dbTeste] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [dbTeste] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [dbTeste] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [dbTeste] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [dbTeste] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [dbTeste] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [dbTeste] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [dbTeste] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [dbTeste] SET  DISABLE_BROKER 
GO

ALTER DATABASE [dbTeste] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [dbTeste] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [dbTeste] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [dbTeste] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [dbTeste] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [dbTeste] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [dbTeste] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [dbTeste] SET RECOVERY FULL 
GO

ALTER DATABASE [dbTeste] SET  MULTI_USER 
GO

ALTER DATABASE [dbTeste] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [dbTeste] SET DB_CHAINING OFF 
GO

ALTER DATABASE [dbTeste] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [dbTeste] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [dbTeste] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [dbTeste] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [dbTeste] SET QUERY_STORE = OFF
GO

ALTER DATABASE [dbTeste] SET  READ_WRITE 