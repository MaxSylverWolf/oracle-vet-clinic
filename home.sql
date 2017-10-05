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