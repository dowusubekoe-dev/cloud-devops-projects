import mysql.connector
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello, Flask is running!"

def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="student",
        password="password123",
        database="testdb"
    )

@app.route('/users')
def users():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users")
    data = cursor.fetchall()
    conn.close()
    return str(data)

if __name__ == "__main__":
    # Run on all interfaces (so host can reach it), port 5000
    app.run(host="0.0.0.0", port=5000, debug=True)
