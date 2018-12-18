#!/bin/python2.7

from Tkinter import *
import Tkinter, Tkconstants, tkFileDialog
import mysql.connector as mariadb



def register():

    global labels

    for label in labels:
      label.destroy()

    labels = []

    print "Texto: " + entry_text.get()

    try:
      cursor.execute("SELECT titulo FROM cancion WHERE titulo LIKE '%"+entry_text.get()+"%'" )
    except mariadb.Error as error:
      print("Error: {}".format(error))

    #mariadb_connection.commit()
    label = Label(root, text = "-> Canciones:")
    label.place (x=30, y=100)
    labels.append(label)
    print ("Canciones: ")
    i = 15
    for nombre in cursor:
      label = Label(root, text = nombre)
      label.place(x=30, y= 100+i)
      labels.append(label)
      print(nombre)
      i+=15

    try:
      cursor.execute("SELECT nombre FROM genero WHERE nombre LIKE '%"+entry_text.get()+"%'" )
    except mariadb.Error as error:
      print("Error: {}".format(error))

    i+=15
    label = Label(root, text = "-> Generos:")
    label.place (x=30,y=100+i)
    labels.append(label)
    print ("Generos: ")
    i +=15
    for nombre in cursor:
      label = Label(root, text = nombre)
      label.place(x=30, y= 100+i)
      labels.append(label)
      print(nombre)
      i+=15

    try:
      cursor.execute("SELECT nombre FROM autor WHERE nombre LIKE '%"+entry_text.get()+"%'" )
    except mariadb.Error as error:
      print("Error: {}".format(error))

    i+=15
    label = Label(root, text = "-> Autores:")
    label.place (x=30,y=100+i)
    labels.append(label)
    print ("Autores: ")
    i +=15
    for nombre in cursor:
      label = Label(root, text = nombre)
      label.place(x=30, y= 100+i)
      labels.append(label)
      print(nombre)


mariadb_connection = mariadb.connect(user='user', password='1234', database='ddsi')
cursor = mariadb_connection.cursor()

root = Tk()
root.geometry('500x500')
root.title("Busqueda")

labels = []
button = Button(root, text='Buscar', command=register).place(x=30,y=56)


entry_text = Entry(root, width=45)
entry_text.place(x=108,y=60)

# label_photo = Label(root, text="Photo",width=20,font=("bold", 10))
# label_photo.place(x=80,y=320)

# Button(root, text='Submit',width=20,bg='brown',fg='white', command=register).place(x=180,y=380)

root.mainloop()
