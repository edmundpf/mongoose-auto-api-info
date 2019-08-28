//: Secret Key Model
var secretKey, userAuth;

secretKey = {
  name: 'secretKey',
  schema: {
    key: {
      type: String,
      unique: true,
      required: true,
      encrypt: true,
      primaryKey: true
    }
  }
};

//: User Auth Model
userAuth = {
  name: 'userAuth',
  schema: {
    username: {
      type: String,
      unique: true,
      required: true,
      primaryKey: true
    },
    password: {
      type: String,
      unique: true,
      required: true,
      encrypt: true
    }
  }
};

//: Exports
module.exports = {
  secretKey: secretKey,
  userAuth: userAuth
};

//::: End Program :::
