# Annunci / Status del progetto

L'applicazione ha la finalità di completare una prova tecnica di lavoro. Una prova che deve tenere fede al documento funzionale ricevuto dal candidato in fase di colloquio. In particolare l'applicazione deve essere sviluppata con il linguaggio swift 5.5 e utilizzare un target maggiore uguale ad iOS 13. La parte grafica deve essere sviluppata, senza l'utilizzo di storyboard/xib e deve essere presente almeno una "TabBar" per le sezioni "Pokèmon" e "Preferiti". 

# PokemonApp

L'applicazione è composta da una pagina di benvenuto e presenta due pulsanti "Tutorial" (al momento ancora non disponibile) e il pulsante "Accedi". Quest'ultimo ci porta nella pagina di "Login" dove è possibile effettuare l'accesso all'interno dell'app, registrare un nuovo utente, condividere l'applicazione (al momento ancora non disponibile) e leggere la pagina "Termini e Condizioni" (Pagina non veritiera). Il menù è composto da tre sezioni (Tab Pokèmon, Tab Preferiti, Tab Impostazioni). Nella prima pagina sono mostrati in lista di massimo 50 elementi e con paginazione (mostrata in alto a destra) tutti i pokèmon. Per ogni Pokèmon è possibile guardarne l'immagine il nome e il dettaglio. Quest'ultimo è raggiungibile con una semplice selezione dell'elemento. Ogni Pokèmon può essere salvato nei preferiti e mostrato nel "Tab Preferiti". Per salvarli nei preferiti basta applicare una leggere pressione sull'elemento. La pagina di dettaglio mostra le abilità e le singole voci di forza per ogni Pokèmon. L'ultima pagina presente è il "Tab Impostazioni" dove è possibile effettuare l'uscita dall'applicazione.

## Struttura del progetto

Per ogni funzionalità esistente nel progetto, è stata creata una cartella per racchiuderne grafica e logica. La parte grafica è sviluppata all'interno del file con nomenglatura "FunzionalitàView" mentra la parte logica è all'interno del file definito con "FunzionalitàViewmodel". Dove la voce "Funzionalità" è sostituita dal contesto in cui siamo (Login,Menu,ecc). La cartella Network contiene tutta la parte di Api per recuperare i dati necessari allo sviluppo del progretto. Nella cartella utility è presente tutta la parte di codice in condivisione e tutta la parte di salvataggio dati come il database e le shared Preferences. 

## Architettura

Lo schema di progettazione software scelto è il pattern Model-View-viewmodel. La scelta ricade su questo modello per astrarre tutta la parte logica da quella grafica. Lo stesso ofrre notevoli vantaggi quali:
Estensibilità (ridefinire la grafica senza toccare la logica), testabilità (semplicità nel scrivere gli unit test) e trasparenza nella comunicazione (tra i vari livelli).

## Gestione dei dati

L'applicazione supporta i mock per la fase di sviluppo e di testing grazie allo schema "PokemonAppMock". Mentre per la fase si salvataggio si è deciso di utilizzare una database interno utilizando lo strumento "Core Data" messo a disposizione da apple.

### Link a documentazione esterna 
- Funzionalità
    https://drive.google.com/file/d/1AF5jvn_Bs3ZC_fuZi4sXOb1nZgjGkClw/view?usp=share_link
- Core Data
    https://developer.apple.com/documentation/coredata
- Firebase
    https://firebase.google.com/docs?hl=i
- MVVM
    https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project

## Licenza generale 

## Autori e Copyright
Amato Luigi

