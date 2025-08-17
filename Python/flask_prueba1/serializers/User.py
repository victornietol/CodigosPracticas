from models.User import UserModel

def UserSerializer(userModel: UserModel) -> dict:
    return {
        "id": userModel.id,
        "username": userModel.username,
        "password": userModel.password
    }