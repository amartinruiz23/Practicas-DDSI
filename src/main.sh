#!/bin/python2.7


import Tkinter as tk

def user_reg():
     execfile("/home/ludvins/test.sh")

root = tk.Tk()
b = tk.Button(root, text="Registro de usuarios", command=user_reg).place(x=100, y=200)

root.mainloop()
