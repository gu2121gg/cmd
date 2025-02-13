import tkinter as tk
from tkinter import messagebox

def show_success():
    root = tk.Tk()
    root.withdraw()  # Oculta a janela principal
    messagebox.showinfo("Sucesso", "Download e Execução bem-sucedidos! 🐸")

if __name__ == "__main__":
    show_success()
