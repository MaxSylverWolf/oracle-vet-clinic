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

INSERT INTO Klienci(id,imie,nazwisko,numer,data_ost_mod,uzytkownik) VALUES (1,'dominika','wojtaszewska',123456789,sysdate,'system');
INSERT INTO Klienci(id,imie,nazwisko,numer,data_ost_mod,uzytkownik) VALUES (2,'ktostam','ktosiek',123456789,sysdate,'system');

INSERT INTO Gatunki(id,nazwa,data_ost_mod,uzytkownik) VALUES (1,'kot',sysdate,'system');
INSERT INTO Gatunki(id,nazwa,data_ost_mod,uzytkownik) VALUES (2,'pies',sysdate,'system');
INSERT INTO Gatunki(id,nazwa,data_ost_mod,uzytkownik) VALUES (3,'krolik',sysdate,'system');
INSERT INTO Gatunki(id,nazwa,data_ost_mod,uzytkownik) VALUES (4,'chomik',sysdate,'system');

INSERT INTO Rasy(id,nazwa,data_ost_mod,uzytkownik) VALUES (1,'maine coon',sysdate,'system');
INSERT INTO Rasy(id,nazwa,data_ost_mod,uzytkownik) VALUES (2,'owczarek',sysdate,'system');
INSERT INTO Rasy(id,nazwa,data_ost_mod,uzytkownik) VALUES (3,'angora',sysdate,'system');
INSERT INTO Rasy(id,nazwa,data_ost_mod,uzytkownik) VALUES (4,'mieszaniec',sysdate,'system');

INSERT INTO Weterynarze(id,imie,nazwisko,specjalizacja,data_ost_mod,uzytkownik) VALUES (1, 'krzysztof', 'majchrzak','hodowlane',sysdate,'system');
INSERT INTO Weterynarze(id,imie,nazwisko,specjalizacja,data_ost_mod,uzytkownik) VALUES (2, 'agata', 'majchrzak','domowe',sysdate,'system');

INSERT INTO Pupile(id,nazwa,plec,id_klienta,wiek,id_gatunku,id_rasy,data_ost_mod,uzytkownik) VALUES (1, 'misia', 'samiczka', 1, 11, 1, 4, sysdate, 'system');
INSERT INTO Pupile(id,nazwa,plec,id_klienta,wiek,id_gatunku,id_rasy,data_ost_mod,uzytkownik) VALUES (2, 'biala', 'kotka', 1, 18, 1, 4, sysdate, 'system');
INSERT INTO Pupile(id,nazwa,plec,id_klienta,wiek,id_gatunku,id_rasy,data_ost_mod,uzytkownik) VALUES (3, 'luna', 'suczka', 2, 2, 2, 2, sysdate, 'system');

INSERT INTO Typ_Wizyty(id,czynnosc,koszt,data_ost_mod,uzytkownik) VALUES (1, 'sterylizacja', 200, sysdate, 'system');
INSERT INTO Typ_Wizyty(id,czynnosc,koszt,data_ost_mod,uzytkownik) VALUES (2, 'kastracja', 140, sysdate, 'system');
INSERT INTO Typ_Wizyty(id,czynnosc,koszt,data_ost_mod,uzytkownik) VALUES (3, 'szczepionka', 40, sysdate, 'system');

INSERT INTO Wizyty(id,nazwa,id_pupila,id_typu_wizyty,id_klienta,id_weterynarza,godzina,data_wizyty,data_ost_mod,uzytkownik) VALUES (1, 'lekki zabieg pod znieczuleniem', 1, 3, 1, 1, 10, '5 kwietnia', sysdate, 'system');

INSERT INTO Leki(id,nazwa,zastosowanie, cena, data_ost_mod,uzytkownik) VALUES (1, 'apap', 'przeciwgoraczkowy', 40, sysdate, 'system');

INSERT INTO LekiUzyte(id,id_wizyty,id_leku, ilosc, kosztLeku, data_ost_mod, uzytkownik) VALUES (1, 1, 1, 3, 120, sysdate, 'system');

INSERT INTO Przebieg_Leczenia(id, id_pupila, przebieg, data_ost_mod, uzytkownik) VALUES (1, 1, 'wszystko w porzadku jest', sysdate, 'system');

BEGIN 
DBMS_EPG.create_dad(dad_name=>'klinika', path =>'/klinika/*');
END;
/

BEGIN 
DBMS_EPG.map_dad(dad_name=>'klinika', path =>'/klinika/*');
END;
/ 

BEGIN 
DBMS_EPG . set_dad_attribute (dad_name => 'klinika', 
attr_name => 'default-page' , 
attr_value => 'home');
END ;
/

CREATE OR REPLACE PROCEDURE home IS
BEGIN
htp.htmlOpen;
htp.headOpen;
htp.title('KLINIKA WETERYNARYJNA');
htp.headClose;
htp.bodyOpen;

htp.print('<center><h1 style="color:blue">KLINIKA WETERYNARYJNA</h1>');
htp.br;
htp.print('<A Href=klienciHome.klienciLista>Klienci</a>'); 
htp.br;
htp.print('<A Href=gatunkiHome.gatunkiLista>Gatunki Zwierzat</a>'); 
htp.br;
htp.print('<A Href=rasyHome.rasyLista>Rasy Zwiarzat</a>'); 
htp.br;
htp.print('<A Href=weterynarzeHome.weterynarzeLista>Weterynarze</a>'); 
htp.br;
htp.print('<A Href=pupileHome.pupileLista>Pupile</a>'); 
htp.br;
htp.print('<A Href=typWizytyHome.typWizytyLista>Rodzaje wizyt</a>'); 
htp.br;
htp.print('<A Href=wizytyHome.wizytyLista>Wizyty</a>'); 
htp.br;
htp.print('<A Href=lekiHome.lekiLista>Leki</a>'); 
htp.br;
htp.print('<A Href=lekiUzyteHome.lekiUzyteLista>Uzyte leki</a>'); 
htp.br;
htp.print('<A Href=przebiegHome.przebiegLista>Przebieg leczenia</a>'); 
htp.br;
htp.print('<A Href=szukajHome.szukajKlientaPupili>Szukaj pupili danego klienta</a></center>'); 
htp.br;
htp.bodyClose;
htp.htmlClose;
END;
/

BEGIN 
DBMS_EPG.map_dad(dad_name=>'klinika', path =>'/klinika/*');
END;
/ 


CREATE OR REPLACE PACKAGE klienciHome IS
 PROCEDURE klienciLista;
 PROCEDURE wiecejKlient(idx NUMBER);
 PROCEDURE edytujKlient(idx NUMBER);
 PROCEDURE edytujKlientSQL(idx NUMBER, iimie VARCHAR2, inazwisko VARCHAR2, inumer NUMBER);
 PROCEDURE dodajKlient;
 PROCEDURE dodajKlientSQL(iimie VARCHAR2, inazwisko VARCHAR2, inumer NUMBER);
 PROCEDURE usunKlient(idx NUMBER);
END klienciHome;
/
CREATE OR REPLACE PACKAGE BODY klienciHome IS
	PROCEDURE klienciLista IS
		CURSOR c1 IS SELECT * FROM Klienci;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA KLIENTOW KLINIKI</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.dodajKlient>Dodaj klienta</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Imie');
			htp.tableHeader('Nazwisko');
			htp.tableHeader('Numer');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR klient IN c1 LOOP
			
				htp.tableRowOpen(2,2);
				htp.tableData(klient.id,2,2);
				htp.tableData(klient.imie,2,2);
				htp.tableData(klient.nazwisko,2,2);
				htp.tableData(klient.numer,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/klienciHome.wiecejKlient?idx='||klient.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/klienciHome.edytujKlient?idx='||klient.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/klienciHome.usunKlient?idx='||klient.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END klienciLista;
	
	PROCEDURE wiecejKlient(idx NUMBER) IS
		KlienciTemp Klienci%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO KlienciTemp FROM Klienci WHERE idx=id;
			htp.print('Czytaj wiecej o rekordzie klienta: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||KlienciTemp.id); 
			htp.br;
			htp.print('<b>Imie:</b> ' || KlienciTemp.imie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> '|| KlienciTemp.nazwisko); 
			htp.br;
			htp.print('<b>Numer:</b> '|| KlienciTemp.numer); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||KlienciTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||KlienciTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejKlient;
	
	PROCEDURE edytujKlient(idx NUMBER) IS
		KlienciTemp Klienci%ROWTYPE;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO KlienciTemp FROM Klienci WHERE idx=id;
			htp.print('Formularz edycji klienta'); htp.br;
			htp.print('<form action="klienciHome.edytujKlientSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || KlienciTemp.id || '">'); 
			htp.br;
			htp.print('Imie: '); 
			htp.br;
			htp.print('<input type="text" name="iimie" value="' || KlienciTemp.imie || '">'); 
			htp.br;
			htp.print('Nazwisko: '); 
			htp.br;
			htp.print('<input type="text" name="inazwisko" value="' || KlienciTemp.nazwisko || '">'); 
			htp.br;
			htp.print('Numer: '); 
			htp.br;
			htp.print('<input type="text" name="inumer" value="' || KlienciTemp.numer || '">'); 
			htp.br;
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujKlient;
	
	PROCEDURE edytujKlientSQL(idx NUMBER, iimie VARCHAR2, inazwisko VARCHAR2, inumer NUMBER) IS
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			UPDATE Klienci SET imie = iimie, nazwisko = inazwisko, numer = inumer, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Klienci');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Imie:</b> ' || iimie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> '|| inazwisko); 
			htp.br;
			htp.print('<b>Numer:</b> '|| inumer); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujKlientSQL;
	
	PROCEDURE dodajKlient IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania klienta'); 
			htp.br;
			htp.print('<form action="klienciHome.dodajKlientSQL" method="post">');
			htp.print('Imie: '); 
			htp.br;
			htp.print('<input type="text" name="iimie" value="">'); 
			htp.br;
			htp.print('Nazwisko: '); 
			htp.br;
			htp.print('<input type="text" name="inazwisko" value="">'); 
			htp.br;
			htp.print('Numer: '); 
			htp.br;
			htp.print('<input type="text" name="inumer" value="">'); 
			htp.br;			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>');
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajKlient;

	
	PROCEDURE dodajKlientSQL(iimie VARCHAR2, inazwisko VARCHAR2, inumer NUMBER) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Klienci;
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Klienci VALUES (max_id, iimie, inazwisko, inumer, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Klienta: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Imie:</b> ' || iimie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> '|| inazwisko); 
			htp.br;
			htp.print('<b>Numer:</b> '|| inumer); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajKlientSQL;
	
	
	PROCEDURE usunKlient(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Klienci WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Klienta: ');
			htp.br; htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunKlient;
	
END klienciHome;
/


CREATE OR REPLACE PACKAGE lekiHome IS
 PROCEDURE lekiLista;
 PROCEDURE wiecejLek(idx NUMBER);
 PROCEDURE edytujLek(idx NUMBER);
 PROCEDURE edytujLekSQL(idx NUMBER, inazwa VARCHAR2, izastosowanie VARCHAR2, icena NUMBER);
 PROCEDURE dodajLek;
 PROCEDURE dodajLekSQL(inazwa VARCHAR2, izastosowanie VARCHAR2, icena NUMBER);
 PROCEDURE usunLek(idx NUMBER);
END lekiHome;
/
CREATE OR REPLACE PACKAGE BODY lekiHome IS
	PROCEDURE lekiLista IS
		CURSOR c1 IS SELECT * FROM Leki;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA TYPOW LEKOW</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.dodajLek>Dodaj lek</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Nazwa');
			htp.tableHeader('Zastosowanie');
			htp.tableHeader('Cena');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR lek IN c1 LOOP
			
				htp.tableRowOpen(2,2);
				htp.tableData(lek.id,2,2);
				htp.tableData(lek.nazwa,2,2);
				htp.tableData(lek.zastosowanie,2,2);
				htp.tableData(lek.cena,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiHome.wiecejLek?idx='||lek.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiHome.edytujLek?idx='||lek.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiHome.usunLek?idx='||lek.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END lekiLista;
	
	PROCEDURE wiecejLek(idx NUMBER) IS
		LekiTemp Leki%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO LekiTemp FROM Leki WHERE idx=id;
			htp.print('Czytaj wiecej o rekordzie typu leku: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||LekiTemp.id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || LekiTemp.nazwa); 
			htp.br;
			htp.print('<b>Zastosowanie:</b> ' || LekiTemp.zastosowanie); 
			htp.br;		
			htp.print('<b>Cena:</b> ' || LekiTemp.cena); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||LekiTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||LekiTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejLek;
	
	PROCEDURE edytujLek(idx NUMBER) IS
		LekiTemp Leki%ROWTYPE;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO LekiTemp FROM Leki WHERE idx=id;
			htp.print('Formularz edycji leku'); 
			htp.br;
			htp.print('<form action="lekiHome.edytujLekSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || LekiTemp.id || '">'); 
			htp.br;
			htp.print('Nazwa: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="' || LekiTemp.nazwa || '">'); 
			htp.br; 
			htp.print('Zastosowanie: ');
			htp.br;
			htp.print('<input type="text" name="izastosowanie" value="' || LekiTemp.zastosowanie || '">'); 
			htp.br; 	
			htp.print('Cena: ');
			htp.br;
			htp.print('<input type="text" name="icena" value="' || LekiTemp.cena || '">'); 
			htp.br; 			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;	
	END edytujLek;
	
	PROCEDURE edytujLekSQL(idx NUMBER, inazwa VARCHAR2, izastosowanie VARCHAR2, icena NUMBER) IS
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			UPDATE Leki SET nazwa = inazwa, zastosowanie = izastosowanie, cena = icena, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Leki');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Zastosowanie:</b> ' || izastosowanie); 
			htp.br;
			htp.print('<b>Cena:</b> ' || icena); 
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujLekSQL;
	
	PROCEDURE dodajLek IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania typu leku'); 
			htp.br;
			htp.print('<form action="lekiHome.dodajLekSQL" method="post">');
			htp.print('Nazwa: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="">'); 
			htp.br;	
			htp.print('Zastosowanie: '); 
			htp.br;
			htp.print('<input type="text" name="izastosowanie" value="">'); 
			htp.br;
			htp.print('Cena: '); 
			htp.br;
			htp.print('<input type="text" name="icena" value="">'); 			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajLek;

	
	PROCEDURE dodajLekSQL(inazwa VARCHAR2, izastosowanie VARCHAR2, icena NUMBER) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Leki;
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Leki VALUES (max_id, inazwa, izastosowanie, icena, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Lek: ');
			htp.br; htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Zastosowanie:</b> ' || izastosowanie); 
			htp.br;				
			htp.print('<b>Cena:</b> ' || icena); 
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajLekSQL;
	
	
	PROCEDURE usunLek(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Leki WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Lek: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/lekiHome.lekiLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunLek;
	
END lekiHome;
/


CREATE OR REPLACE PACKAGE lekiUzyteHome IS
 PROCEDURE lekiUzyteLista;
 PROCEDURE wiecejLekUzyty(idx NUMBER);
 PROCEDURE edytujUzytyLek(idx NUMBER);
 PROCEDURE edytujUzytyLekSQL(idx NUMBER, iid_wizyty NUMBER, iid_leku NUMBER, iilosc NUMBER);
 PROCEDURE dodajUzytyLek;
 PROCEDURE dodajUzytyLekSQL(iid_wizyty NUMBER, iid_leku NUMBER, iilosc NUMBER);
 PROCEDURE usunLekUzyty(idx NUMBER);
 FUNCTION kosztUzytychLekow(iid_leku NUMBER, iilosc NUMBER) RETURN NUMBER;
END lekiUzyteHome;
/
CREATE OR REPLACE PACKAGE BODY lekiUzyteHome IS
	PROCEDURE lekiUzyteLista IS
		wizyta Wizyty%ROWTYPE;
		lek Leki%ROWTYPE;
		CURSOR c1 IS SELECT * FROM LekiUzyte;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA LEKOW UZYTYCH </h2>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.dodajUzytyLek>Dodaj lek uzyty na wizycie</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Wizyta');
			htp.tableHeader('Lek');
			htp.tableHeader('Ilosc');
			htp.tableHeader('Koszt lekow');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR lekiUzyte IN c1 LOOP
				SELECT * INTO wizyta FROM Wizyty WHERE id=lekiUzyte.id_wizyty;
				SELECT * INTO lek FROM Leki WHERE id=lekiUzyte.id_leku;
				
				htp.tableRowOpen(2,2);
				htp.tableData(lekiUzyte.id,2,2);
				htp.tableData(wizyta.nazwa,2,2);
				htp.tableData(lek.nazwa,2,2);
				htp.tableData(lekiUzyte.ilosc,2,2);		
				htp.tableData(lekiUzyte.kosztLeku,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiUzyteHome.wiecejLekUzyty?idx='||lekiUzyte.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiUzyteHome.edytujUzytyLek?idx='||lekiUzyte.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/lekiUzyteHome.usunLekUzyty?idx='||lekiUzyte.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END lekiUzyteLista;
	
	PROCEDURE wiecejLekUzyty(idx NUMBER) IS
		LekiUzyteTemp LekiUzyte%ROWTYPE;
		wizyta Wizyty%ROWTYPE;
		lek Leki%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO LekiUzyteTemp FROM LekiUzyte WHERE idx=id;
			SELECT * INTO wizyta FROM Wizyty WHERE id=LekiUzyteTemp.id_wizyty;
			SELECT * INTO lek FROM Leki WHERE id=LekiUzyteTemp.id_leku;			
			htp.print('Czytaj wiecej o rekordzie leki uzyte: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||LekiUzyteTemp.id); 
			htp.br;
			htp.print('<b>Wizyta:</b> ' || wizyta.nazwa); 
			htp.br;			
			htp.print('<b>ID_wizyty:</b> ' || LekiUzyteTemp.id_wizyty); 
			htp.br;		
			htp.print('<b>Lek:</b> ' || lek.nazwa); 
			htp.br;	
			htp.print('<b>ID_leku:</b> ' || LekiUzyteTemp.id_leku); 
			htp.br;
			htp.print('<b>Ilosc:</b> ' || LekiUzyteTemp.ilosc); 
			htp.br;		
			htp.print('<b>Koszt lekow:</b> ' || LekiUzyteTemp.kosztLeku); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||LekiUzyteTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||LekiUzyteTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejLekUzyty;
	
	PROCEDURE edytujUzytyLek(idx NUMBER) IS
		LekiUzyteTemp LekiUzyte%ROWTYPE;
		CURSOR c2 IS SELECT * FROM Wizyty;
		CURSOR c3 IS SELECT * FROM Leki;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO LekiUzyteTemp FROM LekiUzyte WHERE idx=id;			
			htp.print('Formularz edycji lekiUzytea'); htp.br;
			htp.print('<form action="lekiUzyteHome.edytujUzytyLekSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || LekiUzyteTemp.id || '">'); 
			htp.br;
			htp.print('Wizyta: '); 
			htp.br;
			htp.print('<select name="iid_wizyty">');
				FOR temp IN c2 LOOP
					IF (LekiUzyteTemp.id_wizyty = temp.id) THEN
						htp.print('<option value="' || temp.id || '" selected>' || temp.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');  
			htp.br;
			htp.print('Lek: '); 
			htp.br;
			htp.print('<select name="iid_leku">');
				FOR omg IN c3 LOOP
					IF (LekiUzyteTemp.id_leku = omg.id) THEN
						htp.print('<option value="' || omg.id || '" selected>' || omg.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || omg.id || '">' || omg.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');
			htp.br;
			htp.br;
			htp.print('Ilosc: '); 
			htp.br;
			htp.print('<input type="text" name="iilosc" value="' || LekiUzyteTemp.ilosc || '">');			
			htp.br; 						
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujUzytyLek;
	
	PROCEDURE edytujUzytyLekSQL(idx NUMBER, iid_wizyty NUMBER, iid_leku NUMBER, iilosc NUMBER) IS
		sesja VARCHAR2(30);
		wizyta Wizyty%ROWTYPE;
		lek Leki%ROWTYPE;
		cenaTemp NUMBER;
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			SELECT * INTO wizyta FROM Wizyty WHERE id=iid_wizyty;
			SELECT * INTO lek FROM Leki WHERE id=iid_leku;	
			cenaTemp:=lekiUzyteHome.kosztUzytychLekow(iid_leku, iilosc);
			UPDATE LekiUzyte SET id_wizyty = iid_wizyty, id_leku = iid_leku, ilosc = iilosc, kosztLeku = cenaTemp, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele LekiUzyte');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Wizyta:</b> ' || wizyta.nazwa); 
			htp.br;	
			htp.print('<b>Lek:</b> ' || lek.nazwa); 
			htp.br;	
			htp.print('<b>Ilosc:</b> '|| iilosc); 
			htp.br;	
			htp.print('<b>Koszt lekow:</b> '|| cenaTemp); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;	
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujUzytyLekSQL;
	
	PROCEDURE dodajUzytyLek IS
		CURSOR c2 IS SELECT * FROM Wizyty;
		CURSOR c3 IS SELECT * FROM Leki;
		
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania uzytych lekow'); 
			htp.br;
			htp.print('<form action="lekiUzyteHome.dodajUzytyLekSQL" method="post">');
			htp.print('Wizyta: '); 
			htp.br;
			htp.print('<select name="iid_wizyty">');
				FOR temp IN c2 LOOP
					htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');  
			htp.br; 
			htp.br;
			htp.print('Lek: '); 
			htp.br;
			htp.print('<select name="iid_leku">');
				FOR omg IN c3 LOOP
					htp.print('<option value="' || omg.id || '">' || omg.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');   			
			htp.br; 
			htp.br;
			htp.print('Ilosc: '); 
			htp.br;
			htp.print('<input type="text" name="iilosc" value="">'); 
			htp.br;			
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajUzytyLek;

	
	PROCEDURE dodajUzytyLekSQL(iid_wizyty NUMBER, iid_leku NUMBER, iilosc NUMBER) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		wizyta Wizyty%ROWTYPE;
		lek Leki%ROWTYPE;		
		cenaTemp NUMBER;
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM LekiUzyte;
			SELECT * INTO wizyta FROM Wizyty WHERE id=iid_wizyty;
			SELECT * INTO lek FROM Leki WHERE id=iid_leku;		
			cenaTemp:=lekiUzyteHome.kosztUzytychLekow(iid_leku, iilosc);				
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO LekiUzyte VALUES (max_id, iid_wizyty, iid_leku, iilosc, cenaTemp, sysdate, sesja);
			COMMIT;
			htp.print('Dodano lek: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Wizyta:</b> '|| wizyta.nazwa); 
			htp.br;
			htp.print('<b>Lek:</b> '|| lek.nazwa); 		
			htp.br;			
			htp.print('<b>Ilosc:</b> ' || iilosc); 
			htp.br;
			htp.print('<b>Koszt lekow:</b> ' || cenaTemp); 
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
		
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajUzytyLekSQL;
	
	
	PROCEDURE usunLekUzyty(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM LekiUzyte WHERE id = idx;
			COMMIT;
			htp.print('Usunieto lek: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/lekiUzyteHome.lekiUzyteLista>Wstecz </a>'); htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunLekUzyty;
	
	FUNCTION kosztUzytychLekow(iid_leku NUMBER, iilosc NUMBER) RETURN NUMBER IS
		calosc NUMBER;
		cenaTemp NUMBER;
		BEGIN
			SELECT cena INTO cenaTemp FROM Leki WHERE id=iid_leku;
			calosc:=cenaTemp*iilosc;
			RETURN calosc;		
	END kosztUzytychLekow;
	
		
END lekiUzyteHome;
/


CREATE OR REPLACE PACKAGE przebiegHome IS
 PROCEDURE przebiegLista;
 PROCEDURE wiecejPrzebieg(idx NUMBER);
 PROCEDURE edytujPrzebieg(idx NUMBER);
 PROCEDURE edytujPrzebiegSQL(idx NUMBER, iid_pupila NUMBER, iprzebieg VARCHAR2);
 PROCEDURE dodajPrzebieg;
 PROCEDURE dodajPrzebiegSQL(iid_pupila NUMBER, iprzebieg VARCHAR2);
 PROCEDURE usunPrzebieg(idx NUMBER);
END przebiegHome;
/
CREATE OR REPLACE PACKAGE BODY przebiegHome IS
	PROCEDURE przebiegLista IS
		pupil Pupile%ROWTYPE;
		CURSOR c1 IS SELECT * FROM Przebieg_Leczenia;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA LEKOW UZYTYCH </h2>');
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.dodajPrzebieg>Dodaj przebieg</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Pupil');
			htp.tableHeader('Przebieg');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR prze IN c1 LOOP
				SELECT * INTO pupil FROM Pupile WHERE id=prze.id_pupila;
				
				htp.tableRowOpen(2,2);
				htp.tableData(prze.id,2,2);
				htp.tableData(pupil.nazwa,2,2);
				htp.tableData(prze.przebieg,2,2);			
				htp.tableData('<A Href=http://localhost:8080/klinika/przebiegHome.wiecejPrzebieg?idx='||prze.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/przebiegHome.edytujPrzebieg?idx='||prze.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/przebiegHome.usunPrzebieg?idx='||prze.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END przebiegLista;
	
	PROCEDURE wiecejPrzebieg(idx NUMBER) IS
		PrzeTemp Przebieg_Leczenia%ROWTYPE;
		pupil Pupile%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO PrzeTemp FROM Przebieg_Leczenia WHERE idx=id;
			SELECT * INTO pupil FROM Pupile WHERE id=PrzeTemp.id_pupila;			
			htp.print('Czytaj wiecej o rekordzie przebiegu: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||PrzeTemp.id); 
			htp.br;
			htp.print('<b>Pupil:</b> ' || pupil.nazwa); 
			htp.br;			
			htp.print('<b>ID_pupila:</b> ' || PrzeTemp.id_pupila); 
			htp.br;		
			htp.print('<b>Przebieg:</b> ' || PrzeTemp.przebieg); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||PrzeTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||PrzeTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejPrzebieg;
	
	PROCEDURE edytujPrzebieg(idx NUMBER) IS
		PrzeTemp Przebieg_Leczenia%ROWTYPE;
		CURSOR c2 IS SELECT * FROM Pupile;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO PrzeTemp FROM Przebieg_Leczenia WHERE idx=id;			
			htp.print('Formularz edycji przebiegu'); htp.br;
			htp.print('<form action="przebiegHome.edytujPrzebiegSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || PrzeTemp.id || '">'); 
			htp.br;
			htp.print('Pupil: '); 
			htp.br;
			htp.print('<select name="iid_pupila">');
				FOR temp IN c2 LOOP
					IF (PrzeTemp.id_pupila = temp.id) THEN
						htp.print('<option value="' || temp.id || '" selected>' || temp.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');  
			htp.br;
			htp.print('Przebieg: '); 
			htp.br;
			htp.print('<input type="text" name="iprzebieg" value="' || PrzeTemp.przebieg || '">'); 
			htp.br; 						
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujPrzebieg;
	
	PROCEDURE edytujPrzebiegSQL(idx NUMBER, iid_pupila NUMBER, iprzebieg VARCHAR2) IS
		sesja VARCHAR2(30);
		pupil Pupile%ROWTYPE;		
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			SELECT * INTO pupil FROM Pupile WHERE id=iid_pupila;		
			UPDATE Przebieg_Leczenia SET id_pupila = iid_pupila, przebieg = iprzebieg, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Przebieg_Leczenia');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Pupil:</b> ' || pupil.nazwa); 
			htp.br;	
			htp.print('<b>Przebieg:</b> ' || iprzebieg); 
			htp.br;		
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;	
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujPrzebiegSQL;
	
	PROCEDURE dodajPrzebieg IS
		CURSOR c2 IS SELECT * FROM Pupile;
		
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania przebiegu leczenia'); 
			htp.br;
			htp.print('<form action="przebiegHome.dodajPrzebiegSQL" method="post">');
			htp.print('Pupil: '); 
			htp.br;
			htp.print('<select name="iid_pupila">');
				FOR temp IN c2 LOOP
					htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');  
			htp.br; 
			htp.br;
			htp.print('Przebieg: '); 
			htp.br;
			htp.print('<input type="text" name="iprzebieg" value="">'); 
			htp.br;				
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajPrzebieg;

	
	PROCEDURE dodajPrzebiegSQL(iid_pupila NUMBER, iprzebieg VARCHAR2) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		pupil Pupile%ROWTYPE;			
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Przebieg_Leczenia;
			SELECT * INTO pupil FROM Pupile WHERE id=iid_pupila;			
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Przebieg_Leczenia VALUES (max_id, iid_pupila, iprzebieg, sysdate, sesja);
			COMMIT;
			htp.print('Dodano przebieg leczenia: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Pupil:</b> '|| pupil.nazwa); 
			htp.br;
			htp.print('<b>Przebieg:</b> '|| iprzebieg); 		
			htp.br;					
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
		
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajPrzebiegSQL;
	
	
	PROCEDURE usunPrzebieg(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Przebieg_Leczenia WHERE id = idx;
			COMMIT;
			htp.print('Usunieto przebieg');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/przebiegHome.przebiegLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunPrzebieg;
	
END przebiegHome;
/


CREATE OR REPLACE PACKAGE pupileHome IS
 PROCEDURE pupileLista;
 PROCEDURE wiecejPupil(idx NUMBER);
 PROCEDURE edytujPupil(idx NUMBER);
 PROCEDURE edytujPupilSQL(idx NUMBER, inazwa VARCHAR2, iplec VARCHAR2, iid_klienta NUMBER, iwiek NUMBER, iid_gatunku NUMBER, iid_rasy NUMBER);
 PROCEDURE dodajPupila;
 PROCEDURE dodajPupilaSQL(inazwa VARCHAR2, iplec VARCHAR2, iid_klienta NUMBER, iwiek NUMBER, iid_gatunku NUMBER, iid_rasy NUMBER);
 PROCEDURE usunPupila(idx NUMBER);
END pupileHome;
/
CREATE OR REPLACE PACKAGE BODY pupileHome IS
	PROCEDURE pupileLista IS
		klient Klienci%ROWTYPE;
		gatunek Gatunki%ROWTYPE;
		rasa Rasy%ROWTYPE;
		CURSOR c1 IS SELECT * FROM Pupile;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA ZWIERZAT</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.dodajPupila>Dodaj pupila</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Nazwa');
			htp.tableHeader('Plec');
			htp.tableHeader('Wiek');
			htp.tableHeader('Klient');
			htp.tableHeader('Gatunek');
			htp.tableHeader('Rasa');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR pupil IN c1 LOOP
				SELECT * INTO klient FROM Klienci WHERE id=pupil.id_klienta;
				SELECT * INTO gatunek FROM Gatunki WHERE id=pupil.id_gatunku;
				SELECT * INTO rasa FROM Rasy WHERE id=pupil.id_rasy;
				
				htp.tableRowOpen(2,2);
				htp.tableData(pupil.id,2,2);
				htp.tableData(pupil.nazwa,2,2);
				htp.tableData(pupil.plec,2,2);
				htp.tableData(pupil.wiek,2,2);
				htp.tableData(klient.imie||' '||klient.nazwisko,2,2);
				htp.tableData(gatunek.nazwa,2,2);
				htp.tableData(rasa.nazwa,2,2);				
				htp.tableData('<A Href=http://localhost:8080/klinika/pupileHome.wiecejPupil?idx='||pupil.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/pupileHome.edytujPupil?idx='||pupil.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/pupileHome.usunPupila?idx='||pupil.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END pupileLista;
	
	PROCEDURE wiecejPupil(idx NUMBER) IS
		PupileTemp Pupile%ROWTYPE;
		klient Klienci%ROWTYPE;
		gatunek Gatunki%ROWTYPE;
		rasa Rasy%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO PupileTemp FROM Pupile WHERE idx=id;
			SELECT * INTO klient FROM Klienci WHERE id=PupileTemp.id_klienta;
			SELECT * INTO gatunek FROM Gatunki WHERE id=PupileTemp.id_gatunku;
			SELECT * INTO rasa FROM Rasy WHERE id=PupileTemp.id_rasy;			
			htp.print('Czytaj wiecej o rekordzie pupila: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||PupileTemp.id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || PupileTemp.nazwa); 
			htp.br;
			htp.print('<b>Plec:</b> ' || PupileTemp.plec); 
			htp.br;
			htp.print('<b>ID_klienta:</b> ' || PupileTemp.id_klienta); 
			htp.br;
			htp.print('<b>Klient:</b> ' || klient.imie ||' '|| klient.nazwisko); 
			htp.br;			
			htp.print('<b>Wiek:</b> ' || PupileTemp.wiek); 
			htp.br;
			htp.print('<b>ID_gatunku:</b> ' || PupileTemp.id_gatunku); 
			htp.br;
			htp.print('<b>Gatunek:</b> ' || gatunek.nazwa); 
			htp.br;			
			htp.print('<b>ID_rasy:</b> ' || PupileTemp.id_rasy); 
			htp.br;		
			htp.print('<b>Rasa:</b> ' || rasa.nazwa); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||PupileTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||PupileTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejPupil;
	
	PROCEDURE edytujPupil(idx NUMBER) IS
		PupileTemp Pupile%ROWTYPE;
		CURSOR c1 IS SELECT * FROM Klienci;
		CURSOR c2 IS SELECT * FROM Gatunki;
		CURSOR c3 IS SELECT * FROM Rasy;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO PupileTemp FROM Pupile WHERE idx=id;
			htp.print('Formularz edycji pupila'); htp.br;
			htp.print('<form action="pupileHome.edytujPupilSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || PupileTemp.id || '">'); 
			htp.br;
			htp.print('Nazwa: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="' || PupileTemp.nazwa || '">'); 
			htp.br; 
			htp.br; 
			htp.print('Plec: '); 
			htp.br;
			htp.print('<input type="text" name="iplec" value="' || PupileTemp.plec || '">'); 
			htp.br; 
			htp.br; 
			htp.print('Klient: '); 
			htp.br;
			htp.print('<select name="iid_klienta">');
				FOR cosik IN c1 LOOP
					IF (PupileTemp.id_klienta = cosik.id) THEN
						htp.print('<option value="' || cosik.id || '" selected>' || cosik.imie||' '||cosik.nazwisko ||'</option>');
					ELSE
						htp.print('<option value="' || cosik.id || '">' || cosik.imie||' '||cosik.nazwisko ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>'); 
			htp.br;
			htp.print('Wiek: '); 
			htp.br;
			htp.print('<input type="text" name="iwiek" value="' || PupileTemp.wiek || '">'); 
			htp.br; 
			htp.br;
			htp.print('Gatunek: '); 
			htp.br;
			htp.print('<select name="iid_gatunku">');
				FOR temp IN c2 LOOP
					IF (PupileTemp.id_gatunku = temp.id) THEN
						htp.print('<option value="' || temp.id || '" selected>' || temp.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');  
			htp.br;
			htp.print('Rasa: '); 
			htp.br;
			htp.print('<select name="iid_rasy">');
				FOR omg IN c3 LOOP
					IF (PupileTemp.id_rasy = omg.id) THEN
						htp.print('<option value="' || omg.id || '" selected>' || omg.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || omg.id || '">' || omg.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');
			htp.br;			
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujPupil;
	
	PROCEDURE edytujPupilSQL(idx NUMBER, inazwa VARCHAR2, iplec VARCHAR2, iid_klienta NUMBER, iwiek NUMBER, iid_gatunku NUMBER, iid_rasy NUMBER) IS
		sesja VARCHAR2(30);
		klient Klienci%ROWTYPE;
		gatunek Gatunki%ROWTYPE;
		rasa Rasy%ROWTYPE;		
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			SELECT * INTO klient FROM Klienci WHERE id=iid_klienta;
			SELECT * INTO gatunek FROM Gatunki WHERE id=iid_gatunku;
			SELECT * INTO rasa FROM Rasy WHERE id=iid_rasy;			
			UPDATE Pupile SET nazwa = inazwa, id_klienta = iid_klienta, wiek = iwiek, id_gatunku = iid_gatunku, plec = iplec, id_rasy = iid_rasy, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Pupile');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Plec:</b> '|| iplec); 
			htp.br;
			htp.print('<b>Klient:</b> ' || klient.imie||' '||klient.nazwisko); 
			htp.br;
			htp.print('<b>Wiek:</b> '|| iwiek); 
			htp.br;
			htp.print('<b>Gatunek:</b> ' || gatunek.nazwa); 
			htp.br;	
			htp.print('<b>Rasa:</b> ' || rasa.nazwa); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;	
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujPupilSQL;
	
	PROCEDURE dodajPupila IS
		CURSOR c1 IS SELECT * FROM Klienci;
		CURSOR c2 IS SELECT * FROM Gatunki;
		CURSOR c3 IS SELECT * FROM Rasy;
		
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania pupila'); 
			htp.br;
			htp.print('<form action="pupileHome.dodajPupilaSQL" method="post">');
			htp.print('Nazwa: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="">'); 
			htp.br;	
			htp.print('Plec: '); 
			htp.br;
			htp.print('<input type="text" name="iplec" value="">'); 
			htp.br;
			htp.print('Klient: '); 
			htp.br;
			htp.print('<select name="iid_klienta">');
				FOR cosik IN c1 LOOP
						htp.print('<option value="' || cosik.id || '" selected>' || cosik.imie||' '||cosik.nazwisko ||'</option>');
				END LOOP;
				htp.print('</select>'); 
			htp.br;		
			htp.print('Wiek: '); 
			htp.br;
			htp.print('<input type="text" name="iwiek" value="">'); 
			htp.br; 
			htp.br;
			htp.print('Gatunek: '); 
			htp.br;
			htp.print('<select name="iid_gatunku">');
				FOR temp IN c2 LOOP
					htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');  
			htp.br; 
			htp.br;
			htp.print('Rasa: '); 
			htp.br;
			htp.print('<select name="iid_rasy">');
				FOR omg IN c3 LOOP
					htp.print('<option value="' || omg.id || '">' || omg.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');   			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajPupila;

	
	PROCEDURE dodajPupilaSQL(inazwa VARCHAR2, iplec VARCHAR2, iid_klienta NUMBER, iwiek NUMBER, iid_gatunku NUMBER, iid_rasy NUMBER) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		klient Klienci%ROWTYPE;
		gatunek Gatunki%ROWTYPE;
		rasa Rasy%ROWTYPE;			
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Pupile;
			SELECT * INTO klient FROM Klienci WHERE id=iid_klienta;
			SELECT * INTO gatunek FROM Gatunki WHERE id=iid_gatunku;
			SELECT * INTO rasa FROM Rasy WHERE id=iid_rasy;			
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Pupile VALUES (max_id, inazwa, iid_klienta, iwiek, iid_gatunku, iplec, iid_rasy, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Pupila: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Plec:</b> '|| iplec); 
			htp.br;
			htp.print('<b>Klient:</b> '|| klient.imie||' '||klient.nazwisko); htp.br;
			htp.br;
			htp.print('<b>Wiek:</b> '|| iwiek); 
			htp.br;
			htp.print('<b>Gatunek:</b> '|| gatunek.nazwa); 
			htp.br;
			htp.print('<b>Rasa:</b> '|| rasa.nazwa); 		
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
		
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajPupilaSQL;
	
	
	PROCEDURE usunPupila(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Pupile WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Pupila: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/pupileHome.pupileLista>Wstecz </a>'); htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunPupila;
	
END pupileHome;
/


CREATE OR REPLACE PACKAGE rasyHome IS
 PROCEDURE rasyLista;
 PROCEDURE wiecejRasa(idx NUMBER);
 PROCEDURE edytujRasa(idx NUMBER);
 PROCEDURE edytujRasaSQL(idx NUMBER, inazwa VARCHAR2);
 PROCEDURE dodajRase;
 PROCEDURE dodajRaseSQL(inazwa VARCHAR2);
 PROCEDURE usunRase(idx NUMBER);
END rasyHome;
/
CREATE OR REPLACE PACKAGE BODY rasyHome IS
	PROCEDURE rasyLista IS
		CURSOR c1 IS SELECT * FROM Rasy;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA RAS ZWIERZAT</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.dodajRase>Dodaj rase</a>');htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Nazwa');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR rasa IN c1 LOOP
			
				htp.tableRowOpen(2,2);
				htp.tableData(rasa.id,2,2);
				htp.tableData(rasa.nazwa,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/rasyHome.wiecejRasa?idx='||rasa.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/rasyHome.edytujRasa?idx='||rasa.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/rasyHome.usunRase?idx='||rasa.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END rasyLista;
	
	PROCEDURE wiecejRasa(idx NUMBER) IS
		RasyTemp Rasy%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO RasyTemp FROM Rasy WHERE idx=id;
			
			htp.print('Czytaj wiecej o rekordzie rasy: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||RasyTemp.id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || RasyTemp.nazwa); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||RasyTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||RasyTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejRasa;
	
	PROCEDURE edytujRasa(idx NUMBER) IS
		RasyTemp Rasy%ROWTYPE;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO RasyTemp FROM Rasy WHERE idx=id;
			htp.print('Formularz edycji rasy'); 
			htp.br;
			htp.print('<form action="rasyHome.edytujRasaSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || RasyTemp.id || '">'); 
			htp.br;
			htp.print('Nazwa: '); htp.br;
			htp.print('<input type="text" name="inazwa" value="' || RasyTemp.nazwa || '">'); 
			htp.br; 
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujRasa;
	
	PROCEDURE edytujRasaSQL(idx NUMBER, inazwa VARCHAR2) IS
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			UPDATE Rasy SET nazwa = inazwa, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Rasy');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujRasaSQL;
	
	PROCEDURE dodajRase IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania rasy'); 
			htp.br;
			htp.print('<form action="rasyHome.dodajRaseSQL" method="post">');
			htp.print('Nazwa: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="">'); 
			htp.br;			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajRase;

	
	PROCEDURE dodajRaseSQL(inazwa VARCHAR2) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Rasy;
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Rasy VALUES (max_id, inazwa, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Rase: ');
			htp.br; htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Nazwa:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajRaseSQL;
	
	
	PROCEDURE usunRase(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Rasy WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Rase: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/rasyHome.rasyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunRase;
	
END rasyHome;
/

CREATE OR REPLACE PACKAGE szukajHome IS
 PROCEDURE szukajKlientaPupili;
 PROCEDURE szukajKlientaPupiliSQL(iimie VARCHAR2, inazwisko VARCHAR2);
END szukajHome;
/

CREATE OR REPLACE PACKAGE BODY szukajHome IS
	PROCEDURE szukajKlientaPupili IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Wyszukaj pupili danego klienta'); 
			htp.br;
			htp.print('<form action="szukajHome.szukajKlientaPupiliSQL" method="post">');
			htp.print('Imie: '); 
			htp.br;
			htp.print('<input type="text" name="iimie" value="">'); 
			htp.br;
			htp.print('Nazwisko: '); 
			htp.br;
			htp.print('<input type="text" name="inazwisko" value="">'); 
			htp.br;			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Szukaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/klienciHome.klienciLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>');
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;	
	
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END szukajKlientaPupili;
	
	PROCEDURE szukajKlientaPupiliSQL(iimie VARCHAR2, inazwisko VARCHAR2) IS
		CURSOR c1 IS SELECT Klienci.imie, Klienci.nazwisko, Pupile.id, Pupile.nazwa, Pupile.wiek FROM Klienci, Pupile WHERE Klienci.imie = iimie AND Klienci.nazwisko = inazwisko AND Klienci.id = Pupile.id_klienta;	
		kursor c1%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA KLIENTOW I PUPILI </h2>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Imie');
			htp.tableHeader('Nazwisko');
			htp.tableHeader('Pupil');
			htp.tableHeader('Wiek');
			FOR kursor IN c1 LOOP			
				htp.tableRowOpen(2,2);
				htp.tableData(kursor.id,2,2);
				htp.tableData(kursor.imie,2,2);
				htp.tableData(kursor.nazwisko,2,2);
				htp.tableData(kursor.nazwa,2,2);
				htp.tableData(kursor.wiek,2,2);						
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END szukajKlientaPupiliSQL;	
		
	
END szukajHome;
/	


CREATE OR REPLACE PACKAGE typWizytyHome IS
 PROCEDURE typWizytyLista;
 PROCEDURE wiecejTypWizyty(idx NUMBER);
 PROCEDURE edytujTypWizyty(idx NUMBER);
 PROCEDURE edytujTypWizytySQL(idx NUMBER, iczynnosc VARCHAR2, ikoszt VARCHAR2);
 PROCEDURE dodajTypWizyty;
 PROCEDURE dodajTypWizytySQL(iczynnosc VARCHAR2, ikoszt VARCHAR2);
 PROCEDURE usunTypWizyty(idx NUMBER);
END typWizytyHome;
/
CREATE OR REPLACE PACKAGE BODY typWizytyHome IS
	PROCEDURE typWizytyLista IS
		CURSOR c1 IS SELECT * FROM Typ_Wizyty;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA TYPOW WIZYT KLINIKI</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.dodajTypWizyty>Dodaj typ wizyty</a>');htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Czynnosc');
			htp.tableHeader('Koszt');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR typWiz IN c1 LOOP
			
				htp.tableRowOpen(2,2);
				htp.tableData(typWiz.id,2,2);
				htp.tableData(typWiz.czynnosc,2,2);
				htp.tableData(typWiz.koszt,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/typWizytyHome.wiecejTypWizyty?idx='||typWiz.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/typWizytyHome.edytujTypWizyty?idx='||typWiz.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/typWizytyHome.usunTypWizyty?idx='||typWiz.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END typWizytyLista;
	
	PROCEDURE wiecejTypWizyty(idx NUMBER) IS
		Typ_WizytyTemp Typ_Wizyty%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO Typ_WizytyTemp FROM Typ_Wizyty WHERE idx=id;
			htp.print('Czytaj wiecej o rekordzie typ wizyty: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||Typ_WizytyTemp.id); 
			htp.br;
			htp.print('<b>Czynnosc:</b> ' || Typ_WizytyTemp.czynnosc); 
			htp.br;
			htp.print('<b>Koszt:</b> '|| Typ_WizytyTemp.koszt); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||Typ_WizytyTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||Typ_WizytyTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejTypWizyty;
	
	PROCEDURE edytujTypWizyty(idx NUMBER) IS
		Typ_WizytyTemp Typ_Wizyty%ROWTYPE;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO Typ_WizytyTemp FROM Typ_Wizyty WHERE idx=id;
			htp.print('Formularz edycji typ wizyty'); 
			htp.br;
			htp.print('<form action="typWizytyHome.edytujTypWizytySQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || Typ_WizytyTemp.id || '">'); 
			htp.br;
			htp.print('Czynnosc: '); 
			htp.br;
			htp.print('<input type="text" name="iczynnosc" value="' || Typ_WizytyTemp.czynnosc || '">');
			htp.br;
			htp.print('Koszt: '); 
			htp.br;
			htp.print('<input type="text" name="ikoszt" value="' || Typ_WizytyTemp.koszt || '">'); 
			htp.br;
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujTypWizyty;
	
	PROCEDURE edytujTypWizytySQL(idx NUMBER, iczynnosc VARCHAR2, ikoszt VARCHAR2) IS
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			UPDATE Typ_Wizyty SET czynnosc = iczynnosc, koszt = ikoszt, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Typ_Wizyty');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Czynnosc:</b> ' || iczynnosc); 
			htp.br;
			htp.print('<b>Koszt:</b> '|| ikoszt); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujTypWizytySQL;
	
	PROCEDURE dodajTypWizyty IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania typu wizyty'); 
			htp.br;
			htp.print('<form action="typWizytyHome.dodajTypWizytySQL" method="post">');
			htp.print('Czynnosc: '); 
			htp.br;
			htp.print('<input type="text" name="iczynnosc" value="">'); 
			htp.br;
			htp.print('Koszt: '); 
			htp.br;
			htp.print('<input type="text" name="ikoszt" value="">'); 
			htp.br;			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajTypWizyty;

	
	PROCEDURE dodajTypWizytySQL(iczynnosc VARCHAR2, ikoszt VARCHAR2) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Typ_Wizyty;
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Typ_Wizyty VALUES (max_id, iczynnosc, ikoszt, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Typ Wizyty: ');
			htp.br; htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Czynnosc:</b> ' || iczynnosc); 
			htp.br;
			htp.print('<b>Koszt:</b> '|| ikoszt); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajTypWizytySQL;
	
	
	PROCEDURE usunTypWizyty(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Typ_Wizyty WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Typ Wizyty: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/typWizytyHome.typWizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunTypWizyty;
	
END typWizytyHome;
/


CREATE OR REPLACE PACKAGE weterynarzeHome IS
 PROCEDURE weterynarzeLista;
 PROCEDURE wiecejWeterynarz(idx NUMBER);
 PROCEDURE edytujWeterynarz(idx NUMBER);
 PROCEDURE edytujWeterynarzSQL(idx NUMBER, iimie VARCHAR2, inazwisko VARCHAR2, ispecjalizacja VARCHAR2);
 PROCEDURE dodajWeterynarza;
 PROCEDURE dodajWeterynarzaSQL(iimie VARCHAR2, inazwisko VARCHAR2, ispecjalizacja VARCHAR2);
 PROCEDURE usunWeterynarza(idx NUMBER);
END weterynarzeHome;
/
CREATE OR REPLACE PACKAGE BODY weterynarzeHome IS
	PROCEDURE weterynarzeLista IS
		CURSOR c1 IS SELECT * FROM Weterynarze;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA WETERYNARZY KLINIKI</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.dodajWeterynarza>Dodaj weterynarza</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Imie');
			htp.tableHeader('Nazwisko');
			htp.tableHeader('Specjalizacja');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR weterynarz IN c1 LOOP
			
				htp.tableRowOpen(2,2);
				htp.tableData(weterynarz.id,2,2);
				htp.tableData(weterynarz.imie,2,2);
				htp.tableData(weterynarz.nazwisko,2,2);
				htp.tableData(weterynarz.specjalizacja,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/weterynarzeHome.wiecejWeterynarz?idx='||weterynarz.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/weterynarzeHome.edytujWeterynarz?idx='||weterynarz.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/weterynarzeHome.usunWeterynarza?idx='||weterynarz.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END weterynarzeLista;
	
	PROCEDURE wiecejWeterynarz(idx NUMBER) IS
		WeterynarzeTemp Weterynarze%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO WeterynarzeTemp FROM Weterynarze WHERE idx=id;
			
			htp.print('Czytaj wiecej o rekordzie weterynarza: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||WeterynarzeTemp.id); 
			htp.br;
			htp.print('<b>Imie:</b> ' || WeterynarzeTemp.imie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> ' || WeterynarzeTemp.nazwisko); 
			htp.br;
			htp.print('<b>Specjalizacja:</b> ' || WeterynarzeTemp.specjalizacja); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||WeterynarzeTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||WeterynarzeTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejWeterynarz;
	
	PROCEDURE edytujWeterynarz(idx NUMBER) IS
		WeterynarzeTemp Weterynarze%ROWTYPE;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO WeterynarzeTemp FROM Weterynarze WHERE idx=id;
			htp.print('Formularz edycji weterynarza'); htp.br;
			htp.print('<form action="weterynarzeHome.edytujWeterynarzSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || WeterynarzeTemp.id || '">'); 
			htp.br;
			htp.print('Imie: '); 
			htp.br;
			htp.print('<input type="text" name="iimie" value="' || WeterynarzeTemp.imie || '">'); 
			htp.br; 
			htp.br; 
			htp.print('Nazwisko: '); 
			htp.br;
			htp.print('<input type="text" name="inazwisko" value="' || WeterynarzeTemp.nazwisko || '">'); 
			htp.br; 
			htp.br; 
			htp.print('Specjalizacja: '); 
			htp.br;
			htp.print('<input type="text" name="ispecjalizacja" value="' || WeterynarzeTemp.specjalizacja || '">'); 
			htp.br; 
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujWeterynarz;
	
	PROCEDURE edytujWeterynarzSQL(idx NUMBER, iimie VARCHAR2, inazwisko VARCHAR2, ispecjalizacja VARCHAR2) IS
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			UPDATE Weterynarze SET imie = iimie, nazwisko = inazwisko, specjalizacja = ispecjalizacja, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Weterynarze');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Imie:</b> ' || iimie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> '|| inazwisko); 
			htp.br;
			htp.print('<b>Specjalizacja:</b> '|| ispecjalizacja); 
			htp.br;
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;	
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujWeterynarzSQL;
	
	PROCEDURE dodajWeterynarza IS
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania weterynarza'); 
			htp.br;
			htp.print('<form action="weterynarzeHome.dodajWeterynarzaSQL" method="post">');
			htp.print('Imie: '); 
			htp.br;
			htp.print('<input type="text" name="iimie" value="">'); 
			htp.br;	
			htp.print('Nazwisko: '); 
			htp.br;
			htp.print('<input type="text" name="inazwisko" value="">'); 
			htp.br;
			htp.print('Specjalizacja: '); 
			htp.br;
			htp.print('<input type="text" name="ispecjalizacja" value="">'); 
			htp.br;			
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajWeterynarza;

	
	PROCEDURE dodajWeterynarzaSQL(iimie VARCHAR2, inazwisko VARCHAR2, ispecjalizacja VARCHAR2) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Weterynarze;
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Weterynarze VALUES (max_id, iimie, inazwisko, ispecjalizacja, sysdate, sesja);
			COMMIT;
			htp.print('Dodano Weterynarza: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Imie:</b> ' || iimie); 
			htp.br;
			htp.print('<b>Nazwisko:</b> ' || inazwisko); 
			htp.br;
			htp.print('<b>Specjalizacja:</b> ' || ispecjalizacja); 
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
		
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajWeterynarzaSQL;
	
	
	PROCEDURE usunWeterynarza(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Weterynarze WHERE id = idx;
			COMMIT;
			htp.print('Usunieto Weterynarza: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/weterynarzeHome.weterynarzeLista>Wstecz </a>'); htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Zly kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Zla procedura</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Brak pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Zla wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunWeterynarza;
	
END weterynarzeHome;
/

CREATE OR REPLACE PACKAGE wizytyHome IS
 PROCEDURE wizytyLista;
 PROCEDURE wiecejWizyta(idx NUMBER);
 PROCEDURE edytujWizyta(idx NUMBER);
 PROCEDURE edytujWizytaSQL(idx NUMBER, inazwa VARCHAR2, iid_pupila NUMBER, iid_typu_wizyty NUMBER, iid_klienta NUMBER, iid_weterynarza NUMBER, igodzina NUMBER, idata_wizyty VARCHAR2);
 PROCEDURE dodajWizyte;
 PROCEDURE dodajWizyteSQL(inazwa VARCHAR2, iid_pupila NUMBER, iid_typu_wizyty NUMBER, iid_klienta NUMBER, iid_weterynarza NUMBER, igodzina NUMBER, idata_wizyty VARCHAR2);
 PROCEDURE usunWizyte(idx NUMBER);
END wizytyHome;
/
CREATE OR REPLACE PACKAGE BODY wizytyHome IS
	PROCEDURE wizytyLista IS
		wet Weterynarze%ROWTYPE;
		klient Klienci%ROWTYPE;
		pupil Pupile%ROWTYPE;
		typw Typ_Wizyty%ROWTYPE;
		CURSOR c1 IS SELECT * FROM Wizyty;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
            htp.print('<center><h2>LISTA WIZYT</h2>');
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.dodajWizyte>Dodaj wizyte</a>');
			htp.br;
			htp.br;
			htp.tableOpen('border="5" bordercolor="skyblue" padding="5" borderspacing="5"');
			htp.tableHeader('ID');
			htp.tableHeader('Notatka');
			htp.tableHeader('Pupil');
			htp.tableHeader('Typ_Wizyty');
			htp.tableHeader('Klient');
			htp.tableHeader('Weterynarz');
			htp.tableHeader('Godzina');
			htp.tableHeader('Data Wizyty');
			htp.tableHeader('Czytaj wiecej');
			htp.tableHeader('Edytuj');
			htp.tableHeader('Usun');
			FOR wizyta IN c1 LOOP
				SELECT * INTO klient FROM Klienci WHERE id=wizyta.id_klienta;
				SELECT * INTO pupil FROM Pupile WHERE id=wizyta.id_pupila;
				SELECT * INTO typw FROM Typ_Wizyty WHERE id=wizyta.id_typu_wizyty;
				SELECT * INTO wet FROM Weterynarze WHERE id=wizyta.id_weterynarza;
				htp.tableRowOpen(2,2);
				htp.tableData(wizyta.id,2,2);
				htp.tableData(wizyta.nazwa,2,2);
				htp.tableData(pupil.nazwa,2,2);
				htp.tableData(typw.czynnosc,2,2);
				htp.tableData(klient.imie||' '||klient.nazwisko,2,2);
				htp.tableData(wet.imie||' '||wet.nazwisko,2,2);
				htp.tableData(wizyta.godzina,2,2);
				htp.tableData(wizyta.data_wizyty,2,2);
				htp.tableData('<A Href=http://localhost:8080/klinika/wizytyHome.wiecejWizyta?idx='||wizyta.id||'>Czytaj wiecej</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/wizytyHome.edytujWizyta?idx='||wizyta.id||'>Edytuj</a>',2,2);	
				htp.tableData('<A Href=http://localhost:8080/klinika/wizytyHome.usunWizyte?idx='||wizyta.id||'>Usun</a>',2,2);			
				htp.tableRowClose;
				
			END LOOP;
			htp.tableClose;
			htp.br;
			htp.print('<A Href="home">Strona glowna</center></a>');
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				
	END wizytyLista;
	
	PROCEDURE wiecejWizyta(idx NUMBER) IS
		WizytyTemp Wizyty%ROWTYPE;
		klient Klienci%ROWTYPE;
		pupil Pupile%ROWTYPE;
		typw Typ_Wizyty%ROWTYPE;
		wet Weterynarze%ROWTYPE;
		BEGIN
			htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT * INTO WizytyTemp FROM Wizyty WHERE idx=id;
			SELECT * INTO klient FROM Klienci WHERE id=WizytyTemp.id_klienta;
			SELECT * INTO pupil FROM Pupile WHERE id=WizytyTemp.id_pupila;
			SELECT * INTO typw FROM Typ_Wizyty WHERE id=WizytyTemp.id_typu_wizyty;
			SELECT * INTO wet FROM Weterynarze WHERE id=WizytyTemp.id_weterynarza;
			htp.print('Czytaj wiecej o rekordzie wizyty: '); 
			htp.br;	
			htp.print('<b>ID:</b> '||WizytyTemp.id); 
			htp.br;
			htp.print('<b>Notatka:</b> ' || WizytyTemp.nazwa); 
			htp.br;
			htp.print('<b>Pupil:</b> ' || pupil.nazwa); 
			htp.br;			
			htp.print('<b>ID_pupila:</b> ' || WizytyTemp.id_pupila); 
			htp.br;		
			htp.print('<b>Typ Wizyty:</b> ' || typw.czynnosc); 
			htp.br;				
			htp.print('<b>ID_typu_Wizyty:</b> ' || WizytyTemp.id_typu_wizyty); 
			htp.br;
			htp.print('<b>Klient:</b> ' || klient.imie ||' '|| klient.nazwisko); 
			htp.br;			
			htp.print('<b>ID_Klienta:</b> ' || WizytyTemp.id_klienta); 
			htp.br;	
			htp.print('<b>Weterynarz:</b> ' || wet.imie ||' '|| wet.nazwisko); 
			htp.br;			
			htp.print('<b>ID_Weterynarza:</b> ' || WizytyTemp.id_weterynarza); 
			htp.br;	
			htp.print('<b>Godzina:</b> ' || WizytyTemp.godzina); 
			htp.br;
			htp.print('<b>Data Wizyty:</b> ' || WizytyTemp.data_wizyty); 
			htp.br;			
			htp.print('<b>Data ost. mod:</b> '||WizytyTemp.data_ost_mod); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||WizytyTemp.uzytkownik); 
			htp.br;		
			htp.br;
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END wiecejWizyta;
	
	PROCEDURE edytujWizyta(idx NUMBER) IS
		WizytyTemp Wizyty%ROWTYPE;
		CURSOR c1 IS SELECT * FROM Klienci;
		CURSOR c2 IS SELECT * FROM Pupile;
		CURSOR c3 IS SELECT * FROM Typ_Wizyty;
		CURSOR c4 IS SELECT * FROM Weterynarze;
		BEGIN
			
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			SELECT * INTO WizytyTemp FROM Wizyty WHERE idx=id;
			htp.print('Formularz edycji wizyty'); 
			htp.br;
			htp.print('<form action="wizytyHome.edytujWizytaSQL" method="post">');
			htp.print('<input type="hidden" name="idx" value="' || WizytyTemp.id || '">'); 
			htp.br;
			htp.print('Notatka: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="' || WizytyTemp.nazwa || '">'); 
			htp.br;
			htp.br;
			htp.print('Pupil: '); 
			htp.br;
			htp.print('<select name="iid_pupila">');
				FOR omg IN c2 LOOP
					IF (WizytyTemp.id_pupila = omg.id) THEN
						htp.print('<option value="' || omg.id || '" selected>' || omg.nazwa ||'</option>');
					ELSE
						htp.print('<option value="' || omg.id || '">' || omg.nazwa ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');
			htp.br;			
			htp.br; 
			htp.print('Typ Wizyty: '); 
			htp.br;
			htp.print('<select name="iid_typu_wizyty">');
				FOR omg1 IN c3 LOOP
					IF (WizytyTemp.id_typu_wizyty = omg1.id) THEN
						htp.print('<option value="' || omg1.id || '" selected>' || omg1.czynnosc ||'</option>');
					ELSE
						htp.print('<option value="' || omg1.id || '">' || omg1.czynnosc ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>');
			htp.br;			
			htp.br; 			
			htp.print('Klient: '); 
			htp.br;
			htp.print('<select name="iid_klienta">');
				FOR cosik IN c1 LOOP
					IF (WizytyTemp.id_klienta = cosik.id) THEN
						htp.print('<option value="' || cosik.id || '" selected>' || cosik.imie||' '||cosik.nazwisko ||'</option>');
					ELSE
						htp.print('<option value="' || cosik.id || '">' || cosik.imie||' '||cosik.nazwisko ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>'); 
			htp.br;			
			htp.br;
			htp.print('Weterynarz: '); 
			htp.br;
			htp.print('<select name="iid_weterynarza">');
				FOR cosik1 IN c4 LOOP
					IF (WizytyTemp.id_weterynarza = cosik1.id) THEN
						htp.print('<option value="' || cosik1.id || '" selected>' || cosik1.imie||' '||cosik1.nazwisko ||'</option>');
					ELSE
						htp.print('<option value="' || cosik1.id || '">' || cosik1.imie||' '||cosik1.nazwisko ||'</option>');
					END IF;
				END LOOP;
				htp.print('</select>'); 
			htp.br;			
			htp.br;		
			htp.print('Godzina: '); 
			htp.br;
			htp.print('<input type="text" name="igodzina" value="' || WizytyTemp.godzina || '">'); 
			htp.br;
			htp.br;
			htp.print('Data wizyty: '); 
			htp.br;
			htp.print('<input type="text" name="idata_wizyty" value="' || WizytyTemp.data_wizyty || '">'); 
			htp.br;
			htp.br;			
			htp.print('<input type="submit" value="Edytuj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujWizyta;
	
	PROCEDURE edytujWizytaSQL(idx NUMBER, inazwa VARCHAR2, iid_pupila NUMBER, iid_typu_wizyty NUMBER, iid_klienta NUMBER, iid_weterynarza NUMBER, igodzina NUMBER, idata_wizyty VARCHAR2) IS
		sesja VARCHAR2(30);
		klient Klienci%ROWTYPE;
		pupil Pupile%ROWTYPE;
		typw Typ_Wizyty%ROWTYPE;		
		wet Weterynarze%ROWTYPE;
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT user INTO sesja FROM dual;
			SELECT * INTO klient FROM Klienci WHERE id=iid_klienta;
			SELECT * INTO pupil FROM Pupile WHERE id=iid_pupila;
			SELECT * INTO typw FROM Typ_Wizyty WHERE id=iid_typu_wizyty;
			SELECT * INTO wet FROM Weterynarze WHERE id=iid_weterynarza;			
			UPDATE Wizyty SET nazwa = inazwa, id_pupila = iid_pupila, id_typu_wizyty = iid_typu_wizyty, id_klienta = iid_klienta, id_weterynarza = iid_weterynarza, godzina = igodzina, data_wizyty = idata_wizyty, data_ost_mod=sysdate, uzytkownik=sesja WHERE id = idx;
			COMMIT;
			htp.print('Zaktualizowano tabele Wizyty');
			htp.br;
			htp.br;
			htp.print('<b>ID:</b> '||idx); 
			htp.br;
			htp.print('<b>Notatka:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Pupil:</b> ' || pupil.nazwa); 
			htp.br;	
			htp.print('<b>Typ wizyty:</b> ' || typw.czynnosc); 
			htp.br;					
			htp.print('<b>Klient:</b> ' || klient.imie||' '||klient.nazwisko); 
			htp.br;
			htp.print('<b>Weterynarz:</b> ' || wet.imie||' '||wet.nazwisko); 
			htp.br;			
			htp.print('<b>Godzina:</b> '|| igodzina); 
			htp.br;		
			htp.print('<b>Data wizyty:</b> '|| idata_wizyty); 
			htp.br;				
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;	
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END edytujWizytaSQL;
	
	PROCEDURE dodajWizyte IS
		CURSOR c1 IS SELECT * FROM Klienci;
		CURSOR c2 IS SELECT * FROM Pupile;
		CURSOR c3 IS SELECT * FROM Typ_Wizyty;
		CURSOR c4 IS SELECT * FROM Weterynarze;
		
		BEGIN
			htp.htmlOpen();
			htp.headOpen();
			htp.headClose();
			htp.bodyOpen();
			htp.print('Formularz dodawania wizyty'); 
			htp.br;
			htp.print('<form action="wizytyHome.dodajWizyteSQL" method="post">');
			htp.print('Notatka: '); 
			htp.br;
			htp.print('<input type="text" name="inazwa" value="">'); 
			htp.br;
			htp.br;
			htp.print('Pupil: '); 
			htp.br;
			htp.print('<select name="iid_pupila">');
				FOR temp IN c2 LOOP
					htp.print('<option value="' || temp.id || '">' || temp.nazwa ||'</option>');
				END LOOP;
				htp.print('</select>');  
			htp.br; 
			htp.br;
			htp.print('Typ wizyty: '); 
			htp.br;
			htp.print('<select name="iid_typu_wizyty">');
				FOR temp1 IN c3 LOOP
					htp.print('<option value="' || temp1.id || '">' || temp1.czynnosc ||'</option>');
				END LOOP;
				htp.print('</select>');  
			htp.br; 
			htp.br;			
			htp.print('Klient: '); 
			htp.br;
			htp.print('<select name="iid_klienta">');
				FOR cosik IN c1 LOOP
						htp.print('<option value="' || cosik.id || '" selected>' || cosik.imie||' '||cosik.nazwisko ||'</option>');
				END LOOP;
				htp.print('</select>'); 
			htp.br;		
			htp.print('Weterynarz: '); 
			htp.br;
			htp.print('<select name="iid_weterynarza">');
				FOR cosik1 IN c4 LOOP
						htp.print('<option value="' || cosik1.id || '" selected>' || cosik1.imie||' '||cosik1.nazwisko ||'</option>');
				END LOOP;
				htp.print('</select>'); 
			htp.br;					
			htp.print('Godzina: '); 
			htp.br;
			htp.print('<input type="text" name="igodzina" value="">'); 
			htp.br; 
			htp.br;
			htp.print('Data wizyty: '); 
			htp.br;
			htp.print('<input type="text" name="idata_wizyty" value="">'); 
			htp.br; 
			htp.br;
			htp.print('<input type="submit" value="Dodaj">');
			htp.print('</form>');
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajWizyte;

	
	PROCEDURE dodajWizyteSQL(inazwa VARCHAR2, iid_pupila NUMBER, iid_typu_wizyty NUMBER, iid_klienta NUMBER, iid_weterynarza NUMBER, igodzina NUMBER, idata_wizyty VARCHAR2) IS
		max_id NUMBER;
		sesja VARCHAR2(30);
		klient Klienci%ROWTYPE;
		pupil Pupile%ROWTYPE;
		typw Typ_Wizyty%ROWTYPE;
		wet Weterynarze%ROWTYPE;
		BEGIN
			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			SELECT MAX(id) INTO max_id FROM Wizyty;
			SELECT * INTO klient FROM Klienci WHERE id=iid_klienta;
			SELECT * INTO pupil FROM Pupile WHERE id=iid_pupila;
			SELECT * INTO typw FROM Typ_Wizyty WHERE id=iid_typu_wizyty;
			SELECT * INTO wet FROM Weterynarze WHERE id=iid_weterynarza;			
			max_id:=max_id+1;
			SELECT user INTO sesja FROM dual;
			INSERT INTO Wizyty VALUES (max_id, inazwa, iid_pupila, iid_typu_wizyty, iid_klienta, iid_weterynarza, igodzina, idata_wizyty, sysdate, sesja);
			COMMIT;
			htp.print('Dodano wizyte: ');
			htp.br; 
			htp.br;
			htp.print('<b>ID:</b> '||max_id); 
			htp.br;
			htp.print('<b>Notatka:</b> ' || inazwa); 
			htp.br;
			htp.print('<b>Pupil:</b> '|| pupil.nazwa); 
			htp.br;
			htp.print('<b>Typ wizyty:</b> '|| typw.czynnosc); 		
			htp.br;	
			htp.print('<b>Klient:</b> '|| klient.imie||' '||klient.nazwisko); 
			htp.br;
			htp.br;
			htp.print('<b>Weterynarz:</b> '|| wet.imie||' '||wet.nazwisko); 
			htp.br;
			htp.br;			
			htp.print('<b>Godzina:</b> '|| igodzina); 
			htp.br;		
			htp.print('<b>Data Wizyty:</b> '|| idata_wizyty); 
			htp.br;					
			htp.print('<b>Data ost. mod:</b> '||sysdate); 
			htp.br;
			htp.print('<b>Uzytkownik:</b> '||sesja); 
			htp.br;
		
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END dodajWizyteSQL;
	
	
	PROCEDURE usunWizyte(idx NUMBER) IS
		BEGIN			
	 		htp.htmlOpen;
			htp.headOpen;
			htp.headClose;
			htp.bodyOpen;
			DELETE FROM Wizyty WHERE id = idx;
			COMMIT;
			htp.print('Usunieto wizyte: ');
			htp.br; 
			htp.br;
			
			htp.print('<A Href=http://localhost:8080/klinika/wizytyHome.wizytyLista>Wstecz </a>'); 
			htp.br;
			htp.print('<A Href="home">Strona glowna </a>'); 
			htp.br;	
			htp.bodyClose;
			htp.htmlClose;
			
			EXCEPTION
				when NO_DATA_FOUND then
					htp.print('<center><h3 style="color:red">Brak rekordow</h3></center>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
					
				WHEN INVALID_CURSOR THEN
					htp.print('<h3 style="color:red">Nieprawidlowwy kursor</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN PROGRAM_ERROR THEN
					htp.print('<h3 style="color:red">Blad bloku procedury</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				WHEN STORAGE_ERROR THEN
					htp.print('<h3 style="color:red">Blad pamieci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when INVALID_NUMBER then
					htp.print('<h3 style="color:red">Wprowadzono niepoprawna wartosc</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when VALUE_ERROR then
					htp.print('<h3 style="color:red">Blad przetwarzania wartosci</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when DUP_VAL_ON_INDEX then
					htp.print('<h3 style="color:red">Blad indexu! Musi byc uniq!</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
				when others then
					htp.print('<h3 style="color:red">Po prostu blad...</h3>');
					htp.br;	
					htp.print('<center><A Href="home">Powrot do strony glownej</a></center>');
					htp.br;	
					htp.bodyClose;
					htp.htmlClose;
	END usunWizyte;
	
END wizytyHome;
/