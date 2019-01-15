#!/usr/bin/python2.7
# encoding: utf-8

from Tkinter import *
import Tkinter, Tkconstants, tkFileDialog
import mysql.connector as mariadb
from datetime import datetime
import hashlib
import time

filename = ''

def callback():
    global filename
    filename = tkFileDialog.askopenfilename(initialdir = "/",title = "Select file",filetypes = (("jpeg files","*.jpg"),("all files","*.*")))

def register():
    global label_end_text
    print "Título: " + entry_title.get()
    print "Fecha de lanzamiento: " + entry_date1.get() + "-" + entry_date2.get() + "-" +  entry_date3.get()
    print "Autor: " + entry_author.get()
    print "Género: " + entry_genre.get()
    print "Álbum: " + entry_album.get()

    if entry_date3.get() == '':
        date = datetime(year=9999,month=12,day=31)
    else:
        date = datetime(year=int(entry_date3.get()), month=int(entry_date2.get()), day=int(entry_date1.get()))

    hash = hashlib.sha1()
    hash.update(str(time.time()))

    try:
        cursor.execute("INSERT INTO cancion (identificador, titulo, fecha, autor, genero, album, portada) VALUES (%s, %s, %s, %s, %s, %s, LOAD_FILE(%s))", (hash.hexdigest()[:16], entry_title.get(), date, entry_author.get(), entry_genre.get(), entry_album.get(), filename))
        label_end_text.set("¡Completado!")
    except mariadb.Error as error:
        print("Error: {}".format(error))
        label_end_text.set("Error: " + format(error))

    mariadb_connection.commit()


mariadb_connection = mariadb.connect(user=sys.argv[1], password=sys.argv[2], database=sys.argv[3])
cursor = mariadb_connection.cursor()

root = Tk()
root.geometry('500x600')
root.title("Añadir una canción")

label_end_text = StringVar(root)

label_end = Label(root, textvariable=label_end_text)
label_end.place(x=10,y=480)

label_0 = Label(root, text="Añadir canción",width=20,font=("bold", 20))
label_0.place(x=90,y=53)

label_title = Label(root, text="Título de la canción",width=20,font=("bold", 10))
label_title.place(x=80,y=130)

entry_title = Entry(root)
entry_title.place(x=240,y=130)

label_date = Label(root, text="Fecha de lanzamiento",width=20,font=("bold", 10))
label_date.place(x=80,y=180)

entry_date1 = Entry(root,width=5)
entry_date1.place(x=240,y=180)
entry_date2 = Entry(root,width=5)
entry_date2.place(x=270,y=180)
entry_date3 = Entry(root, width=8)
entry_date3.place(x=300,y=180)

label_author = Label(root, text="Identificador del Autor",width=20,font=("bold", 10))
label_author.place(x=80,y=230)

entry_author = Entry(root)
entry_author.place(x=240,y=230)

label_genre = Label(root, text="Género",width=20,font=("bold", 10))
label_genre.place(x=80,y=280)

entry_genre = Entry (root)
entry_genre.place(x=240, y=280)

label_album = Label(root, text="Álbum",width=20,font=("bold", 10))
label_album.place(x=80,y=330)

entry_album = Entry (root)
entry_album.place(x=240, y=330)


label_photo = Label(root, text="Portada",width=20,font=("bold", 10))
label_photo.place(x=80,y=380)

upload= Button( root, text = 'Upload', command=callback).place(x = 240, y = 380)


Button(root, text='Submit',width=20,bg='brown',fg='white', command=register).place(x=180,y=430)

root.mainloop()


