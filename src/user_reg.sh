#!/bin/python2.7
# encoding: utf-8
from Tkinter import *
import Tkinter, Tkconstants, tkFileDialog
import mysql.connector as mariadb
from datetime import datetime
import time
import sys

filename = ''

def callback():
    global filename
    filename = tkFileDialog.askopenfilename(initialdir = "/home/",title = "Select file",filetypes = (("jpeg files","*.jpg"),("all files","*.*")))

def register():
    global label_end_exit
    print "Usuario: " + entry_user.get()
    print "Clave: " + entry_pass.get()
    print "Correo: " + entry_mail.get()
    print "Fecha de nacimiento: " + entry_bd1.get() + "-" + entry_bd2.get() + "-" +  entry_bd3.get()
    print filename

    print sys.argv[1]

    if entry_bd3.get() == '':
        date = datetime(year=9999, month=12, day=31)
    else:
        date = datetime(year=int(entry_bd3.get()), month=int(entry_bd2.get()), day=int(entry_bd1.get()))

    try:
        cursor.execute("INSERT INTO usuario (alias, contrasenia, correo_electronico, foto, biografia, fecha_de_nacimiento) VALUES (%s,%s,%s,LOAD_FILE(%s),%s,%s)", (entry_user.get(), entry_pass.get(), entry_mail.get(), filename, entry_bio.get(), date))
        label_end_text.set("¡Completado!")
    except mariadb.Error as error:
        print("Error: {}".format(error))
        label_end_text.set("Error: " + format(error))

    mariadb_connection.commit()


mariadb_connection = mariadb.connect(user=sys.argv[1], password=sys.argv[2], database=sys.argv[3])
cursor = mariadb_connection.cursor()

root = Tk()
root.geometry('500x500')
root.title("Formulario de registro")
label_end_text = StringVar(root)

label_end = Label(root, textvariable=label_end_text)
label_end.place(x=100,y=480)

label_0 = Label(root, text="Registration form",width=20,font=("bold", 20))
label_0.place(x=90,y=53)

label_user = Label(root, text="User",width=20,font=("bold", 10))
label_user.place(x=80,y=130)

entry_user = Entry(root)
entry_user.place(x=240,y=130)

label_mail = Label(root, text="Email",width=20,font=("bold", 10))
label_mail.place(x=80,y=180)

entry_mail = Entry(root)
entry_mail.place(x=240,y=180)

label_pass = Label(root, text="Password",width=20,font=("bold", 10))
label_pass.place(x=80,y=230)

entry_pass = Entry (root, show = '*')
entry_pass.place(x=240, y=230)

label_bd = Label(root, text="Birthdate",width=20,font=("bold", 10))
label_bd.place(x=80,y=280)

entry_bd1 = Entry(root,width=5)
entry_bd1.place(x=240,y=280)
entry_bd2 = Entry(root,width=5)
entry_bd2.place(x=270,y=280)
entry_bd3 = Entry(root, width=8)
entry_bd3.place(x=300,y=280)


label_photo = Label(root, text="Photo",width=20,font=("bold", 10))
label_photo.place(x=80,y=320)

label_bio = Label(root, text="Biografia", width=20, font=("bold", 10))
label_bio.place(x=80, y=360)

entry_bio = Entry(root)
entry_bio.grid(column=10, row= 10)
entry_bio.place(x=240, y=360)

upload= Button( root, text = 'Upload', command=callback).place(x = 240, y = 320)


Button(root, text='Submit',width=20,bg='brown',fg='white', command=register).place(x=180,y=800)

root.mainloop()


