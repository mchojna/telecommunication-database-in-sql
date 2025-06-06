-- 1. KTORZY PRACOWNICY OBSLUZYLI WIECEJ KLIENTOW NIZ SREDNIA DLA WSZYSTKICH KLIENTOW
SELECT O.IMIE, O.NAZWISKO, COUNT(K.ID_KONTATKU) LICZBA_KONTATKOW
FROM PRACOWNIK P
JOIN OSOBA O ON P.ID_PRACOWNIKA = O.ID_OSOBY
JOIN KONTAKT K ON P.ID_PRACOWNIKA = K.ID_PRACOWNIKA
GROUP BY O.IMIE, O.NAZWISKO
HAVING COUNT(K.ID_KONTATKU) > (
    SELECT AVG(LICZBA_KONTAKTOW)
    FROM (
        SELECT COUNT(ID_KONTATKU) LICZBA_KONTAKTOW
        FROM KONTAKT
        GROUP BY ID_PRACOWNIKA
    )
)

-- 2. ILE ZGOD MARKETINGOWYCH JEST WYRAZONYCH PRZEZ JAKICH KLIENTOW
SELECT O.IMIE, O.NAZWISKO, COUNT(*) || ' / ' || (SELECT COUNT(DISTINCT ID_ZGODY) FROM ZGODA_MARKETINGOWA) "LICZBA_ZGOD / LICZBA_WSZYSTKICH_ZGOD"
FROM ZGODA_KLIENT ZK
INNER JOIN KLIENT K ON K.ID_KLIENTA = ZK.ID_KLIENTA
INNER JOIN OSOBA O ON O.ID_OSOBY = K.ID_KLIENTA
GROUP BY O.IMIE, O.NAZWISKO

-- 3. JAKA FORMA KONTATKU PRZEKLADA SIE NA ILOSC SPRZEDANYCH UMOW
SELECT FK.NAZWA, COUNT(*) ILOSC_SPRZEDANYCH_UMOW
FROM FORMA_KONTATKU FK
INNER JOIN KONTAKT K ON K.ID_FORMY_KONTATKU = FK.ID_FORMY_KONTATKU
INNER JOIN OFERTA O ON O.ID_KONTATKU = K.ID_KONTATKU
INNER JOIN UMOWA U ON U.ID_OFERTY = O.ID_OFERTY
GROUP BY FK.NAZWA
ORDER BY COUNT(*) DESC;

-- 4. JAKIE PAKIETY SA NAJCZESCIEJ OFEROWANE
SELECT P.NAZWA, COUNT(*) ILOSC_ZAOFEROWANYCH_PAKIETOW
FROM PAKIET P
INNER JOIN OFERTA O ON O.ID_PAKIETU = P.ID_PAKIETU
GROUP BY P.NAZWA
ORDER BY COUNT(*) DESC;

-- 5. JAKA JEST SREDNIA LICZBA NUMEROW POSIADANA PRZEZ KLIENTOW
SELECT AVG(LICZBA_NUMEROW) SREDNIA_LICZBA_NUMEROW 
FROM (
    SELECT COUNT(*) LICZBA_NUMEROW
    FROM KLIENT K
    INNER JOIN NUMER_TELEFONU NT ON NT.ID_KLIENTA = K.ID_KLIENTA
    GROUP BY K.ID_KLIENTA
);

-- 6. ILE JEST NUMEROW TELEFONOW ZAREJESTROWANYCH POD JEDNYM ADRESEM
SELECT A.ID_ADRESU, COUNT(*) LICZBA_NUMEROW
FROM KLIENT K
INNER JOIN NUMER_TELEFONU NT ON NT.ID_KLIENTA = K.ID_KLIENTA
INNER JOIN ADRES A ON A.ID_ADRESU = K.ID_ADRESU
GROUP BY A.ID_ADRESU

-- 7. JAKI PROCENT OFERT KONCZY SIE UMOWA
SELECT COUNT(U.ID_UMOWY) / COUNT(O.ID_OFERTY) * 100 || '%' PROCENT_OFERT_ZAKONCZONYCH_UMOWA
FROM UMOWA U 
RIGHT JOIN OFERTA O ON O.ID_OFERTY = U.ID_OFERTY

-- 8. JAKIM KLIENTOM KONCZA SIE UMOWY ZA 2 MIESIECY LUB MNIEJ
SELECT O.IMIE, O.NAZWISKO, U.ID_UMOWY, U.DATA_ZAKONCZENIA
FROM OSOBA O
INNER JOIN KLIENT K ON K.ID_KLIENTA = O.ID_OSOBY
INNER JOIN KONTAKT KO ON KO.ID_KLIENTA = K.ID_KLIENTA
INNER JOIN OFERTA OE ON OE.ID_KONTATKU = KO.ID_KONTATKU
INNER JOIN UMOWA U ON U.ID_OFERTY = OE.ID_OFERTY
WHERE MONTHS_BETWEEN(U.DATA_ZAKONCZENIA, SYSDATE) <= 2;

-- 9. ILE ROCZNIE PLACA KLIENCI
SELECT O.ID_OSOBY, O.IMIE, O.NAZWISKO, SUM(P.CENA) * 12 ROCZNE_OPLATY
FROM OSOBA O
INNER JOIN KLIENT K ON K.ID_KLIENTA = O.ID_OSOBY
INNER JOIN KONTAKT KO ON KO.ID_KLIENTA = K.ID_KLIENTA
INNER JOIN OFERTA OE ON OE.ID_KONTATKU = KO.ID_KONTATKU
INNER JOIN UMOWA U ON U.ID_OFERTY = OE.ID_OFERTY
INNER JOIN PAKIET P ON P.ID_PAKIETU = OE.ID_PAKIETU
GROUP BY O.ID_OSOBY, O.IMIE, O.NAZWISKO

-- 10. ILE KONTAKTOW Z KLIENTEM JEST WYKONYWANYCH W CIAGU MIESIACA
SELECT EXTRACT(YEAR FROM K.DATA_KONTAKTU) || '-' || EXTRACT(MONTH FROM K.DATA_KONTAKTU) OKRES, COUNT(*) LICZBA_KONTAKTOW
FROM KONTAKT K
GROUP BY EXTRACT(YEAR FROM K.DATA_KONTAKTU), EXTRACT(MONTH FROM K.DATA_KONTAKTU);
