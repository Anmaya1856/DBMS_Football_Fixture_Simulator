from tkinter import *
from tkinter.messagebox import askyesno
from tkinter import ttk, messagebox
import mysql.connector
import os

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


def generate_score():
    mycursor.execute("CALL InsertRand();")
    messagebox.showinfo("Confirmation", "Simulation Successfull !")
    master.destroy()
    os.system('Main.py')

def drop_tables():
    mycursor.execute("call drop_all_tables();")

def create_tables():
    mycursor.execute("call create_all_tables();")

def check_team(team1, team2,team3,team4,team5,team6, total_teams):
    totol_no_of_teams = total_teams
    total_no_of_matches = totol_no_of_teams * (totol_no_of_teams - 1)

    team_list = []
    team_list.append(team1)
    team_list.append(team2)
    team_list.append(team3)
    team_list.append(team4)
    team_list.append(team5)
    team_list.append(team6)
    while('' in team_list) :
        team_list.remove('')

    if(len(team_list) != len(set(team_list))):
        messagebox.showerror("Error", "Duplicate Team Names Selected")

    else:
        if 'Manchester United FC' in team_list:
            mycursor.execute("call man_utd();")
        if 'Manchester City FC' in team_list:
            mycursor.execute("call man_city();")
        if 'Chelsea F.C.' in team_list:
            mycursor.execute("call chelsea();")
        if 'Liverpool FC' in team_list:
            mycursor.execute("call liverpool();")
        if 'Tottenham Hotspur FC' in team_list:
            mycursor.execute("call tottenham();")
        if 'Paris Saint Germain' in team_list:
            mycursor.execute("call psg();")
        if 'Real Madrid' in team_list:
            mycursor.execute("call real_madrid();")
        if 'FC Barcelona' in team_list:
            mycursor.execute("call barcelona();")
        if 'Juventus FC' in team_list:
            mycursor.execute("call juventus();")
        if 'FC Bayern Munich' in team_list:
            mycursor.execute("call bayern();")

        messagebox.showinfo("Confirmation", "Teams have been inserted Successfully !")

        mycursor.execute("CALL InsertFixtures();")

        b4 = Button(f, text = "Generate Fixtures", height = 2, width = 15 ,command= lambda : generate_score())
        b4.grid(row = totol_no_of_teams+3, column = 0)


def select_team(total_teams):
    global f

    f.destroy()
    f = Frame(master, bg="white")
    team1 = ttk.Combobox(f, width = 30, height = 50)
    team2 = ttk.Combobox(f, width = 30)
    team3 = ttk.Combobox(f, width = 30)
    team4 = ttk.Combobox(f, width = 30)
    team5 = ttk.Combobox(f, width = 30)
    team6 = ttk.Combobox(f, width = 30)

    anmaya = int(total_teams)
    for x in range(0, anmaya):

        if x == 0:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team1['values'] = l
            team1.grid(column = 1, row = x+1)
            team1.current(0)
            f.grid(column = 0 )

        if x == 1:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team2['values'] = l
            team2.grid(column = 1, row = x+1)
            team2.current(0)
            f.grid(column = 0 )

        if x == 2:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team3['values'] = l
            team3.grid(column = 1, row = x+1)
            team3.current(0)
            f.grid(column = 0 )

        if x == 3:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team4['values'] = l
            team4.grid(column = 1, row = x+1)
            team4.current(0)
            f.grid(column = 0 )

        if x == 4:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team5['values'] = l
            team5.grid(column = 1, row = x+1)
            team5.current(0)
            f.grid(column = 0 )

        if x == 5:

            l = ['Manchester United FC' , 'Manchester City FC' , 'Chelsea F.C.' , 'Liverpool FC' , 'Tottenham Hotspur FC' , 'Paris Saint Germain' , 'Real Madrid' , 'FC Barcelona' , 'Juventus FC' , 'FC Bayern Munich']
            team6['values'] = l
            team6.grid(column = 1, row = x+1)
            team6.current(0)
            f.grid(column = 0 ) #for loop for all Comboboxes


    b3 = Button(f, text = "Confirm Teams", height = 2, width = 15 ,command= lambda : check_team(team1.get(), team2.get(), team3.get(), team4.get(), team5.get(), team6.get(), anmaya))
    b3.grid(row = anmaya+2, column = 0)




def no_of_team():
    global f

    f.destroy()
    f = Frame(master, bg="white")

    total_teams = ttk.Combobox(f, width = 30, height = 50)
    l= ['2','3','4','5','6']

    total_teams['values'] = l
    total_teams.grid(column = 0, row = 1)
    total_teams.current(0)
    b2 = Button(f, text = "Select Teams", height = 2, width = 15 ,command= lambda : select_team(total_teams.get()))
    b2.grid(row = 2, column = 0)

    f.grid(column = 0 )


drop_tables()
create_tables()

b1 = Button(master, text = "No of Teams", height = 2, width = 15 ,command = no_of_team)
b1.grid(row = 0, column = 0, sticky = E)



master.mainloop()
