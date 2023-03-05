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

    def getOneUser(self,mat):
        req= "SELECT * FROM users WHERE matricule = %s"
        self.cursor.execute(req,(mat,))
        data = self.cursor.fetchone()
        self.db.commit()
        return data

    def postPost(self,title,content,author_id):
        req = "INSERT INTO posts(title,content,created_at,author_id) VALUES (%s,%s,CURDATE(),%s)"
        self.cursor.execute(req, (title,content,author_id))
        self.db.commit()

    def postPostFic(self,title,content,fil,author_id):
        req = "INSERT INTO posts(title,content,created_at,file,author_id) VALUES (%s,%s,CURDATE(),%s,%s)"
        self.cursor.execute(req, (title,content,fil,author_id))
        self.db.commit()
