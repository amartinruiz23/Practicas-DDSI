# -*- coding: utf-8 -*-

from Tkinter import *
import Tkinter, Tkconstants, tkFileDialog
import mysql.connector as mariadb

def callback():
    root.filename = tkFileDialog.askopenfilename(initialdir = "/",title = "Select file",filetypes = (("jpeg files","*.jpg"),("all files","*.*")))

def check_pass():
    cursor.execute("SELECT contrasenia FROM usuario WHERE alias='%s'", (entry_user.get()))
    valid = False
    
    for contrasenia in cursor:
        if contrasenia == entry_pass.get():
            valid = True

    if valid:
        comment()
    else:
        label_error = Label(root, text="Usuario o contraseña incorrecto",width=50,font=("bold", 10))
        label_error.place(x=80,y=370)
        
    
def comment():
    print "Usuario: " + entry_user.get()
    print "Clave: " + entry_pass.get()
    print "Identificación de canción: " + entry_song.get()
    print "Comentario: " + entry_comment.get()

    try:
        cursor.execute("INSERT INTO comenta (alias, identificador, texto) VALUES (%s,%s,%s)", (entry_user.get(), entry_song.get(), entry_comment.get()))
    except mariadb.Error as error:
        print("Error: {}".format(error))

    mariadb_connection.commit()


mariadb_connection = mariadb.connect(user='testuser', password='testuser', database='ddsi')
cursor = mariadb_connection.cursor()

root = Tk()
root.geometry('500x500')
root.title("Formulario de comentario")

label_0 = Label(root, text="Formulario de comentario",width=26,font=("bold", 20))
label_0.place(x=50,y=53)

label_user = Label(root, text="Usuario",width=20,font=("bold", 10))
label_user.place(x=80,y=130)

entry_user = Entry(root)
entry_user.place(x=240,y=130)

label_pass = Label(root, text="Contraseña",width=20,font=("bold", 10))
label_pass.place(x=80,y=180)

entry_pass = Entry (root, show = '*')
entry_pass.place(x=240, y=180)

label_song = Label(root, text="Canción",width=20,font=("bold", 10))
label_song.place(x=80,y=230)

entry_song = Entry (root)
entry_song.place(x=240, y=230)

label_comment = Label(root, text="Comentario",width=20,font=("bold", 10))
label_comment.place(x=80,y=280)

entry_comment = Entry(root)
entry_comment.place(x=240, y=280)

Button(root, text='Añadir',width=20,bg='pink',fg='black', command=check_pass).place(x=180,y=320)

root.mainloop()


