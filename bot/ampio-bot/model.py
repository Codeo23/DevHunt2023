from ampalibe import Model

class UserModel(Model):
    def __init__(self):
        super().__init__()
    @Model.verif_db
    def getUsers(self):
        req = "SELECT * from users"
        self.cursor.execute(req)
        data = self.cursor.fetchall()
        self.db.commit()
        return data