from flask import Flask, request, jsonify
import os, time
import psycopg2
from prometheus_client import Counter, generate_latest
from dotenv import load_dotenv

app = Flask(__name__)

REQS = Counter('api_requests_total', 'Total API requests', ['endpoint'])

def db_conn():
    return psycopg2.connect(
        host=os.environ['DB_HOST'],
        dbname=os.environ['DB_NAME'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'],
        port=int(os.environ.get('DB_PORT', 5432)),
        connect_timeout=5
    )

def ensure_table():
    for _ in range(10):
        try:
            with db_conn() as conn, conn.cursor() as cur:
                cur.execute("""CREATE TABLE IF NOT EXISTS items(
                    id SERIAL PRIMARY KEY,
                    name TEXT NOT NULL,
                    created_at TIMESTAMP DEFAULT NOW()
                );""")
                conn.commit()
            return
        except Exception:
            time.sleep(2)
ensure_table()

# --- NEW ROOT ROUTE ---
@app.get("/")
def index():
    REQS.labels('/').inc()
    return jsonify(message="Welcome to the Flask REST API! Try /health, /items, or /metrics.")
# --- END NEW ROOT ROUTE ---

@app.get("/health")
def health():
    REQS.labels('/health').inc()
    return jsonify(status="ok")

@app.get("/items")
def list_items():
    REQS.labels('/items').inc()
    with db_conn() as conn, conn.cursor() as cur:
        cur.execute("SELECT id, name, created_at FROM items ORDER BY id DESC;")
        rows = cur.fetchall()
    return jsonify([{"id": r[0], "name": r[1], "created_at": r[2].isoformat()} for r in rows])

@app.post("/items")
def create_item():
    REQS.labels('/items').inc()
    name = request.json.get("name")
    if not name: return jsonify(error="name required"), 400
    with db_conn() as conn, conn.cursor() as cur:
        cur.execute("INSERT INTO items(name) VALUES (%s) RETURNING id;", (name,))
        item_id = cur.fetchone()[0]
        conn.commit()
    return jsonify(id=item_id, name=name), 201

@app.get("/metrics")
def metrics():
    return generate_latest(), 200, {'Content-Type': 'text/plain; version=0.0.4; charset=utf-8'}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
