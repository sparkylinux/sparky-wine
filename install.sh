#!/bin/sh
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License as
#  published by the Free Software Foundation; either version 2 of the
#  License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA

if [ "$1" = "uninstall" ]; then
	rm -f /etc/xdg/menus/applications-merged/sparky-wine.menu
	rm -f /usr/bin/sparky-wine
	rm -f /usr/lib/sparkycenter/software/sparky-wine.desktop
	rm -f /usr/share/applications/sparky-wine.desktop
	rm -f /usr/share/menu/sparky-wine
	rm -f usr/share/desktop-directories/sparky-wine.directory
	rm -rf /usr/share/sparky/sparky-wine

	# postrm
	if [ -f /usr/share/applications/sparky-wine-uninstaller.desktop ]; then
		rm -f /usr/share/applications/sparky-wine-uninstaller.desktop
	fi

	if [ -f /usr/share/applications/sparky-wine-winecfg.desktop ]; then
		rm -f /usr/share/applications/sparky-wine-winecfg.desktop
	fi

	if [ -x "`which update-menus 2>/dev/null`" ]; then
		update-menus
	fi
else
	cp etc/* /etc/xdg/menus/applications-merged/
	cp bin/* /usr/bin/
	if [ ! -d /usr/lib/sparkycenter/software ]; then
		mkdir -p /usr/lib/sparkycenter/software
	fi
	cp share/sparky-wine.desktop /usr/lib/sparkycenter/software/
	cp share/sparky-wine.desktop /usr/share/applications/
	cp share/sparky-wine /usr/share/menu/
	cp share/sparky-wine.directory /usr/share/desktop-directories
	if [ ! -d /usr/share/sparky/sparky-wine ]; then
		mkdir -p /usr/share/sparky/sparky-wine
	fi
	cp lang/* /usr/share/sparky/sparky-wine/

	# postinstall
	if [ -f /usr/bin/wine ] || [ -f /usr/bin/wine-stable ]; then
		if [ ! -f /usr/share/applications/wine-uninstaller.desktop ]; then

cat > /usr/share/applications/sparky-wine-uninstaller.desktop <<FOO
[Desktop Entry]
Name=Uninstall Wine Software
Name[ca]=Elimineu programes del Wine
Name[cs]=Odinstalovat software z Wine
Name[da]=Fjern Wine software
Name[de]=Deinstalliere Wine Applikationen
Name[el]=Απεγκατάσταση προγραμμάτων Wine
Name[es]=Desinstala software de Wine
Name[eu]=Desinstalatu Wine-ko softwarea
Name[fi]=Poista Wine-ohjelmien asennuksia
Name[fr]=Désinstaller un logiciel Wine
Name[he]=הסרת תוכנות מ־Wine
Name[hu]=Wine szoftverek eltávolítása
Name[it]=Disinstalla software di Wine
Name[lt]=Pašalinti Wine programas
Name[nl]=Wine programma's verwijderen
Name[pl]=Deinstalacja oprogramowania Wine
Name[pt]=Desinstalar Programas do Wine
Name[pt_br]=Gerenciador de Programas do Wine
Name[ru]=Удаление программ Wine
Name[sv]=Avinstallera Wine-programvara
Name[zh_CN]=卸载 Wine 软件
Comment=Uninstall Windows applications for Wine
Comment[ca]=Elimineu programes del Windows que hageu instaŀlat amb el Wine
Comment[cs]=Odinstalovat software pro Windows z prostředí Wine
Comment[de]=Wine Applikations Deinstallations Programm
Comment[el]=Απεγκατάσταση προγραμμάτων Windows από το Wine
Comment[es]=Desinstala una aplicación Windows en Wine
Comment[fi]=Poista Wineen asennettuja Windows-sovelluksia
Comment[hu]=Windows alkalmazások eltávolítása a Wine-ból
Comment[it]=Disinstalla le applicazioni Windows per Wine
Comment[nl]=Verwijder Windows programma's voor Wine
Comment[pl]=Deinstalowanie oprogramowania dla Wine
Comment[pt_br]=Desinstalar ou Reparar um Programa instalado no Wine
Comment[ru]=Удаление Windows-программ, установленных под Wine
Comment[sv]=Avinstallera Windows-program för Wine
Comment[zh_CN]=卸载使用 Wine 安装的 Windows 应用程序
Exec=wine uninstaller
Terminal=false
Type=Application
Icon=wine-uninstaller
Categories=Applications;WineConfig

FOO

		fi
	fi

	if [ -f /usr/bin/winecfg ]; then
		if [ ! -f /usr/share/applications/wine-winecfg.desktop ]; then

cat > /usr/share/applications/sparky-wine-winecfg.desktop <<FOO
[Desktop Entry]
Name=Configure Wine
Name[ca]=Configureu el Wine
Name[cs]=Nastavení Wine
Name[da]=Konfigurer Wine
Name[de]=Konfiguriere Wine
Name[el]=Ρύθμιση Wine
Name[es]=Configurar Wine
Name[eu]=Konfiguratu Wine
Name[fi]=Winen asetukset
Name[fr]=Configurer Wine
Name[he]=תצורת Wine
Name[hu]=A Wine beállítása
Name[it]=Configura Wine
Name[lt]=Wine nustatymai
Name[nl]=Wine configureren
Name[pl]=Konfiguracja Wine
Name[pt]=Configurar o Wine
Name[pt_br]=Configurar o Wine
Name[ru]=Настройка Wine
Name[sv]=Konfigurera Wine
Name[zh_CN]=Wine 设置
Comment=Change application-specific and general Wine options
Comment[ca]=Canvieu la configuració general del Wine i especifiqueu opcions per a programes concrets
Comment[cs]=Upravit specifická nastavení aplikací a obecné nastavení Wine
Comment[de]=Ändere Wine Optionen und Applikations-spezifische Einstellungen
Comment[el]=Αλλαγή γενικών ρυθμίσεων του Wine ή επιλογών εφαρμογών
Comment[es]=Cambia la configuración de Wine en general o de una aplicación específica
Comment[fi]=Muuta yleisiä ja sovelluskohtaisia Winen asetuksia
Comment[hu]=Alkalmazásspecifikus és általános Wine beállítások módosítása
Comment[it]=Cambia le opzioni delle singole applicazioni e quelle generali di Wine
Comment[nl]=Verander instellingen voor specifieke programma's en Wine in het algemeen
Comment[pl]=Konfigurowanie ustawień aplikacji i ogólnych opcji Wine
Comment[pt_br]=Configurar as opções do Wine e dos programas nele instalados
Comment[ru]=Изменение общих параметров Wine и настройка параметров для отдельных приложений
Comment[sv]=Ändra programspecifika och allmänna Wine-alternativ
Comment[zh_CN]=修改用于特定应用程序和常规的 Wine 选项
Exec=winecfg
Terminal=false
Icon=wine-winecfg
Type=Application
Categories=Applications;WineConfig

FOO

		fi
	fi

	if [ -x "`which update-menus 2>/dev/null`" ]; then
		update-menus
	fi
fi
