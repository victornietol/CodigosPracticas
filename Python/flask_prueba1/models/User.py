class UserModel:
    def __init__(self, username: str, password: str):
        self.__id = None
        self.__username = username
        self.__password = password

    @property
    def id(self):
        return self.__id
    
    @id.setter
    def id(self, id: str):
        self.__id = id

    @property
    def username(self):
        return self.__username
    
    @username.setter
    def username(self, username: str):
        self.__username = username

    @property
    def password(self):
        return self.__password
    
    @password.setter
    def password(self, password: str):
        self.__password = password

    def __str__(self):
        return f"User [id={self.__id}, username={self.username}, password={self.password}]"