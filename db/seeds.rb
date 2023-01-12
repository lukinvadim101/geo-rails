# frozen_string_literal: true

User.create({ email: 'admin@app.com', password: 'password', admin: true })
User.create({ email: 'user@app.com', password: 'password' })
