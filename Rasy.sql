
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