
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import json
import argparse
import subprocess

msj1 = "Envio de correos agregando parametros, que esten dentro del mismo path"
msj2= "Nombre del script"
description =""" Modo de uso 😃:
    send_email.py -t "algo.txt" -s "Asunto" -b "Nombre del script"
    """
parser = argparse.ArgumentParser(description=msj1,
                                epilog=description, 
                                formatter_class=argparse.RawDescriptionHelpFormatter)
parser.add_argument("-t", dest="to", type=str, help="Nombre del txt con correos", required=True)                            
parser.add_argument("-s", dest="subject", type=str, help="Asunto del mensaje", required=True)
parser.add_argument("-b", dest="body", type=str, help=msj2, required=True)
params = parser.parse_args()

data = {}

# 
# {
# "user": "user@uanl.edu.mx"
# "pass": "password_super_secreto"
# }
#

def cuerpo():
    command = f"powershell -ExecutionPolicy ByPass -File {params.body}"
    psResult = subprocess.run(command, stdout=subprocess.PIPE)

    if psResult.stderr == None:
        
        result = psResult.stdout.splitlines()
        resultchido = [x.decode("utf-8") for x in result]
    return '\n'.join(map(str, resultchido))

def sendemail():
    with open("pass.json") as f:    #Leemos las credenciales
        data = json.load(f)

    email_msg = MIMEMultipart()
    email_msg["From"] = data["user"]

    with open(params.to) as c:     #Abrimos el archivos de correos y lo leemos
        lineas = c.readlines()
        for linea in lineas:
            destinatarios = linea.strip('\n')
                
            email_msg["To"] = destinatarios
            email_msg["Subject"] = params.subject

            message = cuerpo()     # Añadir mensaje al body
            email_msg.attach(MIMEText(message, "plain"))

            server = smtplib.SMTP("smtp.office365.com:587")     # Crear el servidor
            server.starttls()

            server.login(data["user"], data["pass"])     # Iniciar sesión con las credenciales 
                                                        # dadas para mandar el mail

            # Mandar el mensaje por el server creado
            server.sendmail(email_msg["From"], destinatarios, email_msg.as_string())
            server.quit()
            print("Mensaje correctamente enviado a:", destinatarios)

if __name__ == "__main__":
    
    sendemail()