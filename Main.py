from tkinter import *
import tkinter.messagebox as MessageBox
from tkinter import ttk
import mysql.connector

master = Tk ()
f = Frame(master, bg="white")
g = Frame(master, bg="white")
master.geometry("1000x1000")
master.title("English Premiere League")

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Idontcare@123",
  database = "englishpremiereleague"
)

mycursor = mydb.cursor()

def points():
    global f
    global g
    mycursor.execute("select * from team order by points desc, goals_difference desc, goals_scored desc, goals_conceded asc;")

    points_table = mycursor.fetchall()
    mycursor.execute("desc team")
    points_table_heading = mycursor.fetchall()

    f.destroy()
    g.destroy()
    f = Frame(master, bg="white")
    i = 1
    j = 0
    k = 0
    for x in points_table_heading:
        e = Entry(f, width =len(x[j])+3, fg = "red", bd= 0)
        e.grid(row = i, column = k)
        e.insert(END, x[j])
        k = k + 1

    i = i +1

    for x in points_table:
        for j in range(len(x)):
            if isinstance(x[j], str):
                e = Entry(f, width =len(x[j])+3, fg = "blue", bd= 0)
                e.grid(row = i, column = j)
                e.insert(END, x[j])
            else:
                e = Entry(f, width =5, fg = "blue", bd= 0)
                e.grid(row = i, column = j)
                e.insert(END, x[j])
        i = i +1


    f.grid(columnspan = len(points_table), column = 0 )


def player(club):
    global g
    g.destroy()
    g = Frame(master, bg="white")

    mycursor.execute("desc player_and_team")
    player_heading = mycursor.fetchall()


    mycursor.execute("select * from player_and_team where Team_name = '%s'"%(club))
    player = mycursor.fetchall()


    i = 4
    j = 0
    k = 1
    for x in player_heading:
        e = Entry(g, width =len(x[j])+3, fg = "red", bd= 0)
        e.grid(row = i, column = k)
        e.insert(END, x[j])
        k = k + 1

    i = i +1
    global temp
    for x in player:
        for j in range(len(x)):
            if isinstance(x[j], str):
                e = Entry(g, width =len(x[j])+3, fg = "blue", bd= 0)
                e.grid(row = i, column = j+1)
                e.insert(END, x[j])
            else:
                e = Entry(g, width =8, fg = "blue", bd= 0)
                e.grid(row = i, column = j+1)
                e.insert(END, x[j])
        i = i +1


    g.grid(columnspan = len(player), column = 1 )

def teams():
    global f
    mycursor.execute("select name from team order by name asc")

    team_names = mycursor.fetchall()

    f.destroy()
    f = Frame(master, bg="white")

    teams = ttk.Combobox(f, width = 30)
    l= []
    for x in team_names:
        z = str(x)
        l.append(z[2:len(z)-3])

    teams['values'] = l
    teams.grid(column = 1, row = 1)
    teams.current(0)
    b3 = Button(f, text = "Fetch", command= lambda : player(teams.get()))
    b3.grid(row = 2, column = 1)

    f.grid(column = 1 ,columnspan = len(team_names))

def managers():
    global f
    global g
    mycursor.execute("select * from manager_and_team;")

    manager = mycursor.fetchall()
    mycursor.execute("desc manager_and_team")
    manager_heading = mycursor.fetchall()

    f.destroy()
    g.destroy()
    f = Frame(master, bg="white")
    i = 1
    j = 0
    k = 2
    for x in manager_heading:
        e = Entry(f, width =len(x[j])+3, fg = "red", bd= 0)
        e.grid(row = i, column = k)
        e.insert(END, x[j])
        k = k + 1

    i = i +1

    for x in manager:
        for j in range(len(x)):
            if isinstance(x[j], str):
                e = Entry(f, width =len(x[j])+3, fg = "blue", bd= 0)
                e.grid(row = i, column = j+2)
                e.insert(END, x[j])
            else:
                e = Entry(f, width =5, fg = "blue", bd= 0)
                e.grid(row = i, column = j+2)
                e.insert(END, x[j])
        i = i +1


    f.grid(columnspan = len(manager), column = 2 )


def fixtures():
    global f
    global g
    mycursor.execute("select * from team_fixtures;")

    fixture = mycursor.fetchall()
    mycursor.execute("desc team_fixtures")
    fixture_heading = mycursor.fetchall()

    f.destroy()
    g.destroy()
    f = Frame(master, bg="white")
    i = 1
    j = 0
    k = 3
    for x in fixture_heading:
        e = Entry(f, width =len(x[j])+3, fg = "red", bd= 0)
        e.grid(row = i, column = k)
        e.insert(END, x[j])
        k = k + 1

    i = i +1

    for x in fixture:
        for j in range(len(x)):
            if isinstance(x[j], str):
                e = Entry(f, width =len(x[j])+3, fg = "blue", bd= 0)
                e.grid(row = i, column = j+3)
                e.insert(END, x[j])
            else:
                e = Entry(f, width =5, fg = "blue", bd= 0)
                e.grid(row = i, column = j+3)
                e.insert(END, x[j])
        i = i +1


    f.grid(columnspan = len(fixture), column = 3 )


def stadiums():
    global f
    global g
    mycursor.execute("select * from stadium_and_team;")

    stadium = mycursor.fetchall()
    mycursor.execute("desc stadium_and_team")
    stadium_heading = mycursor.fetchall()

    f.destroy()
    g.destroy()
    f = Frame(master, bg="white")
    i = 1
    j = 0
    k = 4
    for x in stadium_heading:
        e = Entry(f, width =len(x[j])+3, fg = "red", bd= 0)
        e.grid(row = i, column = k)
        e.insert(END, x[j])
        k = k + 1

    i = i +1

    for x in stadium:
        for j in range(len(x)):
            if isinstance(x[j], str):
                e = Entry(f, width =len(x[j])+3, fg = "blue", bd= 0)
                e.grid(row = i, column = j+4)
                e.insert(END, x[j])
            else:
                e = Entry(f, width =5, fg = "blue", bd= 0)
                e.grid(row = i, column = j+4)
                e.insert(END, x[j])
        i = i +1


    f.grid(columnspan = len(stadium), column = 4 )



b1 = Button(master, text = "Points Table",height = 2, width = 15 , command = points)
b1.grid(row = 0, column = 0, sticky = E)

b2 = Button(master, text = "Players",height = 2, width = 15 , command = teams)
b2.grid(row = 0, column = 1, sticky = E )

b4 = Button(master, text = "Managers", height = 2, width = 15 ,command = managers)
b4.grid(row = 0, column = 2, sticky = E )

b5 = Button(master, text = "Fixtures", height = 2, width = 15 ,command = fixtures)
b5.grid(row = 0, column = 3, sticky = E )

b6 = Button(master, text = "Stadiums",height = 2, width = 15 , command = stadiums)
b6.grid(row = 0, column = 4, sticky = E )

master.mainloop()
