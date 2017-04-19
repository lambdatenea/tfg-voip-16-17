#!/usr/bin/python
import os
import time

lista_conferancia = [1002,2001,2002]
ruta_conferencia = "/var/spool/asterisk/confbridge/"
ruta_miembros_conferencia = "/var/spool/asterisk/voicemail/default/"

for i in range(length(lista_conferancia)):
	os.system("cp " + ruta_conferencia + "confbridge1234.wav " + ruta_miembros_conferencia + lista_conferancia[i] + "/INBOX/msgconferencia.wav")

        