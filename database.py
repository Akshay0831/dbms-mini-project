from hashlib import md5
import mysql.connector


class Database:
    #Connect Database

    def __init__(self):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user='root',
            password='root',
            database='bookstore',
            autocommit=True
        )
        self.__cursor = self.__mydb.cursor()

    def addUser(self, user: dict):
        #Adds a user_id to the database, by accepting a list consisting of email and password.
        #And returns the updated table values in a list of key value pairs
        try:
            self.__cursor.execute(
                f"""INSERT INTO Users VALUES (null, 
                '{user['email']}', 
                '{md5(user['password'].encode()).hexdigest()}', 
                '{user['name']}', 
                '{user['phone']}', '{str(user['dob'])}')""")
        except mysql.connector.errors.IntegrityError:
            return None
        self.__cursor.execute(f"SELECT * FROM Users")

        return [{
            "uId": userData[0],
            "email": userData[1],
            "password": userData[2],
            "name": userData[3],
            "phone": userData[4],
            "dob": str(userData[5])
        } for userData in self.__cursor.fetchall()]

    def addAddress(self, address: dict):
        #Adds a user_id to the database, by accepting a list consisting of email and password.
        #And returns the updated table values in a list of key value pairs
        try:
            self.__cursor.execute(f'''INSERT INTO Users VALUES (
                    {address['uId']}, 
                    '{address['address']}', 
                    '{address['pincode']}')''')
        except mysql.connector.errors.IntegrityError:
            return None

        self.__cursor.execute(f"SELECT * FROM Address")

        return [{
            "uId": userData[0],
            "address": userData[1],
            "pincode": userData[2]
        } for userData in self.__cursor.fetchall()]

    def checkUser(self, userData: list):
        #Checks if the user_id exists in the database
        self.__cursor.execute(
            f"""SELECT *
                FROM Users
                WHERE email = '{userData[0]}' AND
                password = '{md5(userData[1].encode()).hexdigest()}'"""
        )
        return self.__cursor.fetchone()

    