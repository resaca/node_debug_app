mongoose = require('mongoose')
bcrypt   = require('bcrypt-nodejs')

# define the schema for our user model
userSchema = mongoose.Schema(
  local:
    email: String
    password: String
  facebook:
    id: String
    token: String
    email: String
    name: String
  linkedin:
    id: String
    token: String
    email: String
    name: String
  google:
    id: String
    token: String
    email: String
    name: String
  name: String
  email: String
  designation: String
  company: String
  phone: String
  website: String
  previous_work: String
  about_me: String
)

# methods ======================
# generating a hash
userSchema.methods.generateHash = (password) ->
  bcrypt.hashSync password, bcrypt.genSaltSync(8), null

# checking if password is valid
userSchema.methods.validPassword = (password) ->
  bcrypt.compareSync password, this.local.password

# create the model for users and expose it to our app
module.exports = mongoose.model('User', userSchema)
