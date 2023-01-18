require 'cgi'
require 'active_support'

def verify_and_decrypt_session_cookie(cookie, secret_key_base, session_key)
  cookie = CGI.unescape(cookie)
  salt   = 'authenticated encrypted cookie'
  encrypted_cookie_cipher = 'aes-256-gcm'
  serializer = ActiveSupport::MessageEncryptor::NullSerializer

  key_generator = ActiveSupport::KeyGenerator.new(secret_key_base, iterations: 1000)
  key_len = ActiveSupport::MessageEncryptor.key_len(encrypted_cookie_cipher)
  secret = key_generator.generate_key(salt, key_len)
  encryptor = ActiveSupport::MessageEncryptor.new(secret, cipher: encrypted_cookie_cipher,
                                                          serializer: serializer)

  encryptor.decrypt_and_verify(cookie, purpose: "cookie.#{session_key}")
end

puts 'add cookie'
cookie = 'qW4UPsl5rD%2FlkuZhKraqyQZhDZ0NwLmp4aUY6niczD6cF6HAi0QJEd7I0vvmEDKxlpy437YPb65Wvk10krb%2FAzClY7aCKjfYAbD%2Fa%2FrQhWQ9QnweT8wr%2FnV9u%2F1IcBdks7d3viN3RyfOEW69GqXpOPbOY8zPZ9JJYamNraEZLtP6nim2u5EJCHsBxZF3h%2Byse7TbzpRwNI80mX5yQXhP%2BhjxQcAtKd6QIVQ5z60kcdi3qMabCGvwnOM3q%2FP85qp1T0Li3v8PYqMj3WN4D5MXv05%2F%2FPuY5LQXZI5YLnoy9xBi%2BzI3BtblP4KJUUeIM%2BqEMOJiBeol5J9UUsLk57tTmqdCcABjeVjznMNuGSLhKm6lwVg8ToBWANC08VXL4UgXT7VB0RdJawTiJqlGIQ7FDQZTWUg%3D--4Oio5rBYEYBheQD1--0UnYBQTlYaIvG6RRhYP1gg%3D%3D'
secret_key_base = '00b97428f62ee03ec8346369546e55a0fa697146e3b968ad26fb9594f02ba37bd2e28afb318cad8cf29d911a78725783c84232c49bd36a74c869197e46696f40'
session_key = '_geo_session'
result = verify_and_decrypt_session_cookie(cookie, secret_key_base, session_key)

puts result.inspect
