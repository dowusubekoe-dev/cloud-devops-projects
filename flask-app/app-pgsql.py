import psycopg2
from flask import Flask

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        host="localhost",
        user="student",
        password="password123",
        dbname="testdb"
    )

@app.route('/users')
def users():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT * FROM users")
    data = cur.fetchall()
    conn.close()
    return str(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=6000)
