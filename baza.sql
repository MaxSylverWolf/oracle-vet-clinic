DROP TABLE Klienci CASCADE CONSTRAINTS; 
DROP TABLE Pupile CASCADE CONSTRAINTS; 
DROP TABLE Gatunki CASCADE CONSTRAINTS; 
DROP TABLE Rasy CASCADE CONSTRAINTS; 
DROP TABLE Wizyty CASCADE CONSTRAINTS; 
DROP TABLE Typ_Wizyty CASCADE CONSTRAINTS; 
DROP TABLE Weterynarze CASCADE CONSTRAINTS; 
DROP TABLE Przebieg_Leczenia CASCADE CONSTRAINTS;
DROP TABLE LekiUzyte CASCADE CONSTRAINTS; 
DROP TABLE Leki CASCADE CONSTRAINTS;

CREATE TABLE Klienci
(
id NUMBER(10),
imie VARCHAR2(50),
nazwisko VARCHAR2(50),
numer NUMBER(11),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT klient_pk PRIMARY KEY (id)
);

CREATE TABLE Gatunki
(
id NUMBER(10),
nazwa VARCHAR2(50),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT gatunek_pk PRIMARY KEY (id)
);

CREATE TABLE Rasy
(
id NUMBER(10),
nazwa VARCHAR2(50),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT rasa_pk PRIMARY KEY (id)
);

CREATE TABLE Weterynarze
(
id NUMBER(10),
imie VARCHAR2(50),
nazwisko VARCHAR2(50),
specjalizacja VARCHAR2(50),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT wet_pk PRIMARY KEY (id)
);

CREATE TABLE Pupile
(
id NUMBER(10),
nazwa VARCHAR2(50),
plec VARCHAR2(15),
id_klienta NUMBER(10),
wiek NUMBER(4),
id_gatunku NUMBER(10),
id_rasy NUMBER(10),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT pupil_pk PRIMARY KEY (id),
CONSTRAINT pupil_klient_fk FOREIGN KEY (id_klienta) REFERENCES Klienci (id),
CONSTRAINT pupil_gatunek_fk FOREIGN KEY (id_gatunku) REFERENCES Gatunki (id),
CONSTRAINT pupil_rasa_fk FOREIGN KEY (id_rasy) REFERENCES Rasy (id)
);

CREATE TABLE Typ_Wizyty
(
id NUMBER(10),
czynnosc VARCHAR2(200),
koszt NUMBER(8),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT typ_wiz_pk PRIMARY KEY (id)
);

CREATE TABLE Wizyty
(
id NUMBER(10),
nazwa VARCHAR2(100),
id_pupila NUMBER(10),
id_typu_wizyty NUMBER(10),
id_klienta NUMBER(10),
id_weterynarza NUMBER(10),
godzina NUMBER(4),
data_wizyty VARCHAR2(100),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT wizyty_pk PRIMARY KEY (id),
CONSTRAINT wizyty_klient_fk FOREIGN KEY (id_klienta) REFERENCES Klienci (id),
CONSTRAINT wizyty_pupil_fk FOREIGN KEY (id_pupila) REFERENCES Pupile (id),
CONSTRAINT wizyty_typ_fk FOREIGN KEY (id_typu_wizyty) REFERENCES Typ_Wizyty (id),
CONSTRAINT wizyty_wet_fk FOREIGN KEY (id_weterynarza) REFERENCES Weterynarze (id)
);

CREATE TABLE Leki
(
id NUMBER(10),
nazwa VARCHAR2(30),
zastosowanie VARCHAR2(100),
cena NUMBER(4),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT lek_pk PRIMARY KEY (id)
);

CREATE TABLE LekiUzyte
(
id NUMBER(10),
id_wizyty NUMBER(10),
id_leku NUMBER(10),
ilosc NUMBER(2),
kosztLeku NUMBER(4),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT leku_pk PRIMARY KEY (id),
CONSTRAINT leku_wizyta_fk FOREIGN KEY (id_wizyty) REFERENCES Wizyty (id),
CONSTRAINT leku_fk FOREIGN KEY (id_leku) REFERENCES Leki (id)
);

CREATE TABLE Przebieg_Leczenia
(
id NUMBER(10),
id_pupila NUMBER(10),
przebieg VARCHAR2(200),
data_ost_mod DATE,
uzytkownik VARCHAR2(30),
CONSTRAINT przebieg_pk PRIMARY KEY (id),
CONSTRAINT przebieg_pupil_fk FOREIGN KEY (id_pupila) REFERENCES Pupile (id)
);