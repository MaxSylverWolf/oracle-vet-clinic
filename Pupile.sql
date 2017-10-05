
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
			INSERT INTO Pupile VALUES (max_id, inazwa, iplec, iid_klienta, iwiek, iid_gatunku, iid_rasy, sysdate, sesja);
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