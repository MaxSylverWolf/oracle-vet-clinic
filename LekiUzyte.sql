
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