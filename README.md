# PruebaPase
🚀 Rick & Morty App — SwiftUI

App desarrollada en SwiftUI que consume la API pública de Rick & Morty. Permite explorar personajes, ver información detallada y proteger el acceso mediante autenticación biométrica o contraseña del dispositivo.

📱 Características principales

🔐 Autenticación biométrica / contraseña
Face ID o Touch ID. Si el dispositivo no tiene biométricos disponibles, se usa la autenticación por contraseña del sistema.

👤 Listado de personajes
Vista que muestra los personajes obtenidos desde la API.

🔍 Detalle del personaje
Información completa: nombre, estado, especie, origen y más.

🧭 Navegación 100% SwiftUI
Arquitectura limpia con ViewModels separados por vista.

🏗️ Arquitectura

La app está construida bajo principios MVVM, cuidando la separación entre vistas, lógica y servicios.

✨ Capas principales

Views:
Interfaces hechas en SwiftUI.
CharactersView, CharacterDetailView, FavoritesView.

ViewModels:
Manejan estado, llamadas a servicios y transforman datos para las vistas.
CharactersViewModel, CharacterDetailViewModel, FavoritesViewModel.

Services:
Manejan comunicación con la API y utilidades.

🔐 Autenticación biométrica

La app usa LAContext para validar Face ID o Touch ID.

🌐 API utilizada

Usa la API oficial gratuita:

https://rickandmortyapi.com/

⚙️ Requisitos

iOS 16 o superior

Xcode 15+

Swift 5.9

Conexión a internet para cargar los personajes

▶️ Instalación

Clona este repositorio

git clone https://github.com/usuario/rick-and-morty-app.git

Abre el proyecto en Xcode

Ejecuta en un simulador

Detalle

Player en background

📦 Dependencias

Swinject - Swift Package Manager

🙌 Autor

Mario Gr.
