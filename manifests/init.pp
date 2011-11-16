class variance {

# Example declaration of the defined resource type in users.pp to build these four users.
# This allows you to just declare the variance class in your ENC. 
  variance::user { ['ryan',
                    'web-user',
                    'db-user',
                    'admin-user']: }
}
