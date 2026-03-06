<img src="../../Logo.png" width="550" height="75" alt="logo">

# **Histoire des systèmes d’exploitation modernes (1969 → 2025)**

## **Chapitre 1 - La naissance d’UNIX (1969-1975)**

L’histoire des systèmes d’exploitation contemporains trouve son point de départ à la fin des années 1960, dans les laboratoires Bell d’AT&T. En 1969, deux chercheurs, **Ken Thompson** et **Dennis Ritchie**, conçoivent un système d’exploitation expérimental sur un mini-ordinateur PDP-7. Ce système, baptisé **UNIX**, cherchait à offrir un environnement simple, cohérent et multi-utilisateur. L’idée fondatrice était que « tout est fichier » : les périphériques, les données et les processus eux-mêmes pouvaient être manipulés avec la même logique. Cette vision, associée à l’esprit d’ingénierie créative des laboratoires Bell, donna naissance à une architecture élégante et durable.

Vers 1972-1973, Dennis Ritchie crée le langage **C**, spécialement pour réécrire UNIX. Cette réécriture est décisive. Elle rend le système portable et adaptable. UNIX n’est plus lié à un seul modèle de machine, il peut désormais migrer. C’est cette portabilité qui explique en grande partie son héritage immense.

---

## **Chapitre 2 - La diffusion universitaire et l’émergence de BSD (1975-1985)**

Au milieu des années 1970, les laboratoires Bell commencent à diffuser UNIX vers les universités, sous licence de recherche. L’Université de Californie à Berkeley devient rapidement un centre majeur d’innovation. Un étudiant particulièrement doué, **Bill Joy**, améliore UNIX en ajoutant notamment l’éditeur de texte vi et le C-shell. Les chercheurs de Berkeley intègrent également le réseau, en particulier la **pile TCP/IP**, qui deviendra par la suite la base d’Internet.

À partir de là, UNIX existe sous deux grandes branches :  
la branche commerciale d’AT&T, appelée **System V**, et la branche universitaire, appelée **BSD** pour Berkeley Software Distribution.

Au cours des années 1980, d’importantes entreprises adoptent et modifient UNIX. Sun Microsystems commercialise **SunOS** puis **Solaris**, IBM développe **AIX**, Hewlett-Packard propose **HP-UX**, Digital Equipment Corporation crée **Ultrix**. De son côté, Berkeley publie en 1983 **4.2BSD**, qui intègre TCP/IP et devient le socle de l’Internet académique puis mondial.

Cependant, un long conflit juridique entre AT&T et la communauté BSD ralentit l’évolution du système jusqu’à un accord en 1994, qui permet la publication de **BSD 4.4-Lite**, base libre et réutilisable. C’est de cette base que naîtront **FreeBSD**, **NetBSD** et **OpenBSD**, qui existent encore aujourd’hui.

---

## **Chapitre 3 - L’ère des micro-ordinateurs : CP/M, MS-DOS et les premières versions de Windows**

Pendant ce temps, une autre histoire se déroule dans le monde des ordinateurs personnels. En 1974, **Gary Kildall** développe **CP/M**, un système pour micro-ordinateurs 8 bits. Dans les années 1980, Microsoft rachète puis adapte un système similaire appelé QDOS, qui devient **MS-DOS** en 1981. Sur MS-DOS, Microsoft construit petit à petit une interface graphique appelée **Windows**.

Les premières versions de Windows, entre 1985 et 1993, ne sont en réalité que des environnements graphiques posés sur DOS. **Windows 95, 98 et ME** héritent encore de cette base. Il s’agit d’une lignée totalement séparée de celle d’UNIX.

---

## **Chapitre 4 - L’architecture Windows NT : héritage de VMS**

Microsoft comprend vite que cette architecture héritée de MS-DOS n’est pas adaptée aux réseaux et aux machines multiprocesseurs naissants. Pour créer un système plus solide, la firme recrute **Dave Cutler**, l’architecte du système **VMS** chez Digital. Il conçoit le noyau **Windows NT**, publié en 1993.

De Windows NT dériveront **Windows 2000**, puis **Windows XP**, **Windows 7**, **Windows 10** et **Windows 11**.  
Contrairement à ce que l’on pourrait croire, **Windows NT n'est pas descendant d’UNIX**, mais il adopte progressivement des compatibilités (notamment via **POSIX**) afin de faciliter l’interopérabilité.

---

## **Chapitre 5 - La révolution du logiciel libre : GNU et la licence GPL**

Pendant que les versions commerciales d’UNIX dominent les serveurs et que Windows s’impose sur les postes personnels, une révolution éthique et technique se prépare. En 1983, **Richard Stallman** lance le projet **GNU**, dont l’objectif est de créer un système libre. La **licence GPL**, publiée en 1989 puis révisée en 1991, garantit juridiquement quatre libertés fondamentales : utiliser, étudier, modifier et redistribuer.

GNU publie l’éditeur Emacs, le compilateur GCC, puis de nombreuses bibliothèques.  
Mais il manque encore un noyau fonctionnel.

---

## **Chapitre 6 - La naissance de Linux et l’explosion des distributions (1991-2000)**

En 1991, **Linus Torvalds**, étudiant finlandais, publie le premier noyau **Linux**. En l’associant aux outils GNU, on obtient un système complet : **GNU/Linux**. Ce système, libre et modifiable, se diffuse extrêmement vite grâce à Internet et au travail collaboratif.

Des distributions organisées émergent : **Debian**, **Red Hat**, **Slackware**, **SUSE**.  
À la fin des années 1990, Linux devient un acteur majeur des serveurs web.  
L’architecture **LAMP** (Linux, Apache, MySQL, PHP/Perl/Python) devient la base de l’Internet dynamique.

---

## **Chapitre 7 - La guerre ouverte : Microsoft contre Linux (1998-2013)**

La montée en puissance de Linux entraîne un conflit stratégique majeur. Sous la direction de **Steve Ballmer**, Microsoft considère la licence GPL comme une menace pour son modèle économique. En 2001, Ballmer déclare publiquement : **« Linux est un cancer »**.

La période 1998 à 2013 est marquée par :

- des campagnes publicitaires agressives contre Linux,

- des accusations de violation de brevets,

- l’affaire **SCO**, qui tente de contester juridiquement la légalité de Linux, sans succès.

Durant cette période, Linux continue néanmoins de gagner du terrain dans les serveurs, les supercalculateurs et les infrastructures réseau.

---

## **Chapitre 8 - La renaissance d’Apple : de NeXTSTEP à macOS et iOS**

Pendant ces années, Apple vit sa propre transformation. Après son éviction, **Steve Jobs** fonde NeXT et développe **NeXTSTEP**, basé sur un micro-noyau Mach et des composants BSD.

Quand Apple rachète NeXT en 1997, Jobs revient et transforme l’ancien Mac OS en un système moderne basé sur NeXTSTEP : ce sera **Mac OS X** en 2001, devenu **macOS**.  
En 2007, Apple réutilise cette même base pour créer l’iPhone, donnant naissance à **iOS**, puis à ses variantes (iPadOS, watchOS, tvOS).

Les systèmes Apple modernes appartiennent donc **à la famille UNIX**, avec un contrôle strict de la distribution logicielle.

---

## **Chapitre 9 - L’avènement du mobile : Android et la domination de Linux**

En 2008, Google lance **Android**, basé sur le noyau Linux mais avec un environnement logiciel distinct. Android devient rapidement le système d’exploitation mobile le plus utilisé au monde, porté par une multitude de constructeurs.

Linux, qui n’avait jamais dominé les PC domestiques, s’impose finalement **sur les téléphones**, l’outil informatique le plus répandu.

---

## **Chapitre 10 - Le retournement de Microsoft : de l’hostilité à la coopération (2014 → 2025)**

À partir de 2014, **Satya Nadella** devient directeur général de Microsoft. Il comprend que la croissance se situe dans le **cloud**, où **Linux est omniprésent**. Microsoft change alors radicalement de stratégie.

L’entreprise publie **Visual Studio Code** sous licence MIT, ouvre **PowerShell**, apporte **.NET Core** à Linux, propose **SQL Server** pour Linux, puis introduit **WSL** (Windows Subsystem for Linux).  
En 2016, Microsoft devient membre de la **Linux Foundation**.

L’ancien ennemi devient un partenaire.  
L’opposition idéologique laisse place à l’interopération pragmatique.

---

## **Chapitre 11 - Situation en 2025 : une cohabitation stabilisée**

Aujourd’hui, Linux domine les **serveurs**, les **supercalculateurs**, les **infrastructures cloud**, les **conteneurs**, et les **smartphones via Android**.  
macOS et iOS occupent une position forte dans les environnements créatifs et mobiles haut de gamme.  
Windows continue de dominer le poste de travail professionnel, mais s’appuie désormais sur l’interopérabilité avec Linux.

Deux grandes lignées ont ainsi fini par coexister :  
la **famille UNIX** (BSD, Linux, macOS, Android) et la **famille VMS → Windows NT**.

## **Annexe : Visualiser l’arbre historique des systèmes d’exploitation**

Pour bien comprendre l’évolution des systèmes d’exploitation (UNIX, BSD, Linux, macOS, Android, Windows), nous allons manipuler un **organigramme d’histoire** sous forme de **diagramme PlantUML**

#### **Qu’est-ce que PlantUML ?**

**PlantUML** est un outil qui permet de créer des **schémas et diagrammes** (organigrammes, frises, diagrammes UML, etc.) **à partir de texte**.  
Il suffit d’écrire une description simple en langage proche de l’anglais, et PlantUML génère automatiquement l’image correspondante.  
C’est un outil très pratique pour **visualiser des concepts techniques**, garder des documents **clairs**, et permettre une **reproduction exacte** du schéma.

### **1) Ouvrir l’éditeur PlantUML en ligne**

Cliquez sur ce lien :

➡️ [PlantUML Web Server](https://www.plantuml.com/plantuml)

Aucun logiciel n’est nécessaire, tout se fait dans le navigateur.

---

### **2) Copier / Coller le code PlantUML**

 **Copiez l’intégralité de ce script puml**.

```puml
@startuml
' Organigramme chronologique des OS (1969 → 2025) - compatible PlantUML classique
skinparam defaultFontName Arial
skinparam ArrowColor #555
skinparam RoundCorner 8
skinparam Shadowing false
left to right direction

legend left
 Organigramme chronologique par familles
 Flèche pleine = filiation / succession
 Flèche pointillée = influence / base technique
end legend

' =========================
' UNIX / BSD / Apple
' =========================
package "UNIX / BSD / Apple" {
 rectangle UNIX_1969       as "UNIX (Bell Labs)\n1969"
 rectangle V6_1975         as "UNIX V6\n1975"
 rectangle BSD_1977        as "BSD (Berkeley)\n1977"
 rectangle BSD42_1983      as "4.2BSD (TCP/IP)\n1983"
 rectangle SYSV_1983       as "UNIX System V\n1983"
 rectangle BSD44_1994      as "4.4BSD-Lite\n1994"
 rectangle FREEBSD_1993    as "FreeBSD\n1993"
 rectangle NETBSD_1993     as "NetBSD\n1993"
 rectangle OPENBSD_1996    as "OpenBSD\n1996"
 rectangle SUNOS_SOL_1992  as "SunOS → Solaris\n1992"
 rectangle HPUX_1984       as "HP-UX\n1984"
 rectangle AIX_1986        as "IBM AIX\n1986"
 rectangle ULTRIX_1984     as "Ultrix (DEC)\n1984"

 rectangle NEXTSTEP_1988   as "NeXTSTEP (Mach+BSD)\n1988"
 rectangle MACOSX_2001     as "Mac OS X → macOS\n2001"
 rectangle IOS_2007        as "iOS\n2007"

 UNIX_1969 --> V6_1975
 V6_1975 --> BSD_1977
 V6_1975 --> SYSV_1983
 BSD_1977 --> BSD42_1983
 BSD42_1983 --> BSD44_1994

 BSD44_1994 --> FREEBSD_1993
 BSD44_1994 --> NETBSD_1993
 BSD44_1994 --> OPENBSD_1996

 BSD42_1983 --> SUNOS_SOL_1992
 SYSV_1983  --> SUNOS_SOL_1992
 SYSV_1983  --> HPUX_1984
 SYSV_1983  --> AIX_1986
 BSD_1977   --> ULTRIX_1984

 BSD_1977 --> NEXTSTEP_1988
 NEXTSTEP_1988 --> MACOSX_2001
 MACOSX_2001 --> IOS_2007
}

' =========================
' Linux / Android / ChromeOS
' =========================
package "Linux / Android / ChromeOS" {
 rectangle GNU_1983        as "GNU (R. Stallman)\n1983"
 rectangle LINUX_1991      as "Noyau Linux (L. Torvalds)\n1991"
 rectangle DEBIAN_1993     as "Debian\n1993"
 rectangle SLACK_1993      as "Slackware\n1993"
 rectangle SUSE_1992       as "SUSE\n1992"
 rectangle REDHAT_1994     as "Red Hat\n1994"
 rectangle ANDROID_2008    as "Android (Linux)\n2008"
 rectangle CHROMEOS_2009   as "ChromeOS (Linux)\n2009"

 GNU_1983 ..> LINUX_1991 : outils/userland
 LINUX_1991 --> DEBIAN_1993
 LINUX_1991 --> SLACK_1993
 LINUX_1991 --> SUSE_1992
 LINUX_1991 --> REDHAT_1994
 LINUX_1991 --> ANDROID_2008
 LINUX_1991 --> CHROMEOS_2009
}

' =========================
' Windows (DOS → NT)
' =========================
package "Windows (DOS → NT)" {
 rectangle CPM_1974        as "CP/M (G. Kildall)\n1974"
 rectangle MSDOS_1981      as "MS-DOS\n1981"
 rectangle WIN1_1985       as "Windows 1.x\n1985"
 rectangle WIN3_1990       as "Windows 3.x\n1990"
 rectangle WIN95_1995      as "Windows 95\n1995"
 rectangle WIN98_1998      as "Windows 98\n1998"
 rectangle WINME_2000      as "Windows ME\n2000"

 rectangle VMS_1977        as "VMS (DEC)\n1977"
 rectangle NT_1993         as "Windows NT 3.1\n1993"
 rectangle W2K_2000        as "Windows 2000\n2000"
 rectangle XP_2001         as "Windows XP\n2001"
 rectangle W7_2009         as "Windows 7\n2009"
 rectangle W10_2015        as "Windows 10\n2015"
 rectangle W11_2021        as "Windows 11\n2021"

 CPM_1974 --> MSDOS_1981
 MSDOS_1981 --> WIN1_1985
 WIN1_1985 --> WIN3_1990
 WIN3_1990 --> WIN95_1995
 WIN95_1995 --> WIN98_1998
 WIN98_1998 --> WINME_2000

 VMS_1977 ..> NT_1993 : influence archi
 NT_1993 --> W2K_2000
 W2K_2000 --> XP_2001
 XP_2001 --> W7_2009
 W7_2009 --> W10_2015
 W10_2015 --> W11_2021
}

' =========================
' Positionnement horizontal (liens cachés pour la mise en page)
' =========================
UNIX_1969 -[hidden]-> GNU_1983
GNU_1983 -[hidden]-> CPM_1974
BSD44_1994 -[hidden]-> LINUX_1991
MACOSX_2001 -[hidden]-> ANDROID_2008
SUNOS_SOL_1992 -[hidden]-> NT_1993

@enduml
```

Collez-le dans la fenêtre de script du site PlantUML.

Le site génère automatiquement **un diagramme** dont vous pourrez changer le thème visuel.

---

### **3) Observer la structure**

Dans ce diagramme, vous trouverez :

- La famille **UNIX → BSD → macOS / iOS**

- La famille **GNU + Linux → distributions + Android / ChromeOS**

- La famille **CP/M → MS-DOS → Windows → Windows NT → Windows 11**

- Et les **liens d’influence entre lignées**

**Important :**

- **Flèches pleines** = filiation directe / descendance technique

- **Flèches pointillées** = influence historique (idées, architecture, concepts)

Prenez le temps d’**identifier les embranchements**.

---

### **4) Comparer avec l’arbre officiel de Wikipédia**

Maintenant, ouvrez la page suivante :

https://fr.wikipedia.org/wiki/Berkeley_Software_Distribution

Cet article de wikipedia traite de la famille des UNIX BSD et montre **l’arbre historique officiel des systèmes UNIX**.
