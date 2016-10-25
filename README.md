# shops-chooser
Poniżej  znajduje się przykładowy hash z produktami spożywczymi, oraz sklepami, w których można kupić dany produkt w określonej cenie.

    input = {
        chleb:  {auchan: 2.3, biedronka: 2.6, lidl: 2.4},
        maslo:  {auchan: 2.5, biedronka: 3, lidl: 2.4, zabka: 3.5},
        jogurt: {auchan: 1.5, lidl: 1.4, zabka: 2},
        ser:    {auchan: 1.3, lidl: 1.9, zabka: 1.5, biedronka: 1.1}
    }
    cart = [:chleb, :maslo]
Przykład:  "chleb" można kupić w sklepie "Auchan" za 2,30 zł lub w sklepie  "Biedronka" za 2,60 zł lub w sklepie "Lidl" za 2,40 zł itd. Nie  wszystkie towary można kupić w danym sklepie - np. chleba nie kupię w  “Żabka”.

Zmienna input może zawierać inne produkty, sklepy oraz ceny (w postaci liczby stałej lub zmiennoprzecinkowej). 

Zmienna cart zawiera listę produktów, które chcemy kupić.



Funkcjonalność I: "Zakupy w jednym sklepie"

Użytkownik chce zrobić zakupy tylko w jednym sklepie. Program dla dowolnej tablicy z produktami (cart) powinien wypisać w jakich sklepach i za ile można kupić dane produkty i posortować je po sumarycznej cenie tych produktów. Sklepy, w których nie można kupić wszystkich produktów powinny zostać pominięte.

Przykład:

Dla powyższych danych (cart = chleb i maslo) program powinien zwrócić następujący wynik:

auchan:
* chleb 2.3
* maslo 2.5
* suma 4.8

lidl:
* chleb 2.4
* maslo 2.4
* suma 4.8

biedronka:
* chleb 2.6
* maslo 3
* suma 5.6
Wniosek: Chleb i masło będą łącznie kosztować 4,80 w sklepie “Auchan”, 4,80 w sklepie “Lidl”, 5,60 w sklepie “Biedronka”.

W sklepie "Biedronka" użytkownik zapłaci najwięcej, dlatego powinna być na końcu listy.



Funkcjonalność II: "Zakupy w dowolnych sklepach"

Tym razem użytkownik chce zapłacić najmniej mogąc odwiedzić dowolną ilość sklepów. Program powinien podać listę sklepów, w których zapłaci najmniej za swoje zakupy wraz z listą produktów oraz ich ceną.

Przykład:

Dla powyższych danych (cart = chleb i maslo) program powinien zwrócić następujący wynik:

auchan:
* chleb 2.3

lidl:
* maslo 2.4
Wniosek: Chleb najlepiej kupić w sklepie "Auchan", a masło w sklepie "Lidl".



Funkcjonalność III: "Zakupy w jednym lub dwóch sklepach"

W tym przypadku użytkownik odwiedza jeden lub dwa sklepy w czasie zakupów. Program powinien napisać do jakich sklepów (maksymalnie dwóch) należy się udać, aby kupić produkty (zmienna cart) możliwie najtaniej.

Przykład 1:

Dla powyższych danych (cart = chleb i maslo) program powinien zwrócić następujący wynik:

auchan:
* chleb 2.3

lidl:
* maslo 2.4
Wniosek: Chleb najlepiej kupić w sklepie "Auchan", a masło w sklepie "Lidl".

Przykład 2:

Jeżeli do koszyka dodamy jeszcze jogurt i ser (cart = chleb, maslo, jogurt, ser) to program powinien zwrócić następujący wynik:


lidl:
* chleb:2.4
* maslo 2.4
* jogurt 1.4

biedronka:
* ser 1.1
Wniosek: W sklepie "Lidl" najlepiej kupić chleb, masło i jogurt, a w "Biedronka" ser.

* Zadanie 1:
    InputReader.new(input).market.sort_shop_by_prices cart
* Zadanie 2:
    InputReader.new(input).market.find_cheapest_products cart
* Zadanie 3:
    InputReader.new(input).market.find_cheapest_products_in_n_shops_only cart, n

