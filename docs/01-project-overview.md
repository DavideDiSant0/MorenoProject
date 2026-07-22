# Project Overview

Repair Parts Finder e' una futura applicazione desktop locale per la ricerca
rapida di ricambi destinata a un riparatore di dispositivi elettronici.

## Problema

La ricerca manuale di ricambi richiede di ripetere molte volte combinazioni di
marca, modello, codice modello, componente e fornitore. Questo rallenta il
lavoro quotidiano e aumenta il rischio di aprire risultati incompleti o poco
coerenti.

## Obiettivo

L'applicazione dovra guidare l'utente nella composizione della ricerca e
generare URL validi per i fornitori configurati. L'acquisto restera sempre fuori
dall'applicazione e sara completato nel sito ufficiale del fornitore.

## Flusso Futuro

1. Selezione del tipo di dispositivo.
2. Selezione della marca.
3. Selezione del modello.
4. Selezione del componente.
5. Selezione dei fornitori.
6. Generazione automatica di query e URL.
7. Visualizzazione di un riepilogo.
8. Apertura nel browser esterno.
9. Registrazione della ricerca nella cronologia.

## Stato Della Fase Corrente

Il progetto include dominio, persistenza locale Drift, casi d'uso applicativi,
generatore URL, browser service astratto, shell GoRouter e una prima schermata
catalogo operativa.

La sezione `/catalog` permette di gestire tipi dispositivo, marche, modelli,
componenti e compatibilita dispositivo/componente. Le altre sezioni UI sono
ancora schermate tecniche pronte per le fasi successive.
