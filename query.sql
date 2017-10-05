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