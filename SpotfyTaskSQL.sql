CREATE DATABASE Spotfy
USE Spotfy
CREATE TABLE Artists(
 Id int PRIMARY key IDENTITY,
 Name NVARCHAR(255)Not Null,
 SurName NVARCHAR(255)Not Null,
)

CREATE table ALBUMS(
 Id int PRIMARY key IDENTITY,
 Name NVARCHAR(255)Not Null,
 MusicCount INT NOT NULL,
 ReleaseDate INT NOT NULL,
 Artistid INT references Artists(Id)
)

Create table MUSICS(
 Id int PRIMARY key IDENTITY,
 Name NVARCHAR(255)Not Null,
 MusicTime INT Not Null,
 ListenerCounts INT NOT NULL,
 AlbumId int REFERENCES ALBUMS(Id), 
)

CREATE TABLE ArtisMusic(
 Id int PRIMARY key IDENTITY,
 MusicId int REFERENCES MUSICS(Id),
 ArtistId int REFERENCES Artists(Id),
)

CREATE VIEW vW_GETFULLMUSICINFO AS
SELECT MUSICS.Name,MUSICS.MusicTime,Artists.Name 'ArtistName',ALBUMS.Name 'AlbumName'
FROM MUSICS
JOIN ArtisMusic ON ArtisMusic.MusicId=MUSICS.Id
JOIN Artists ON Artists.Id=ArtisMusic.ArtistId
JOIN ALBUMS ON ALBUMS.Id=MUSICS.AlbumId

CREATE VIEW vW_GETFULLALBUMINFO AS
SELECT ALBUMS.Name,Albums.MusicCount
FROM ALBUMS

CREATE PROCEDURE FILTERALBUMS @ListenerCounts INT , @ALBUMNAMECHAR NVARCHAR(25)
AS
SELECT * 
FROM MUSICS 
Join ALBUMS 
ON ALBUMS.Id=MUSICS.AlbumId
WHERE @ListenerCounts>=MUSICS.ListenerCounts AND ALBUMS.Name Like '%@ALBUMNAMECHAR%'
