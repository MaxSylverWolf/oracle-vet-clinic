
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