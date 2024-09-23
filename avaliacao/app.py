from flask import Flask, request, jsonify
from flask_cors import CORS
import random
import string

app = Flask(__name__)
CORS(app)

# Base de dados de exemplo
students = [
    {'matricula': '20210001', 'nome': 'Ana', 'nota': 75},
    {'matricula': '20210002', 'nome': 'Carlos', 'nota': 55},
    {'matricula': '20210003', 'nome': 'Bruna', 'nota': 100},
    {'matricula': '20210004', 'nome': 'Daniel', 'nota': 60},
    {'matricula': '20210005', 'nome': 'Raquel', 'nota': 1}
]

# Token de exemplo gerado sem validação de login
def generate_token(length=10):
    letters_and_digits = string.ascii_letters + string.digits
    token = ''.join(random.choice(letters_and_digits) for i in range(length))
    return token

# Endpoint de login que gera um token sem validar credenciais
@app.route('/login', methods=['POST'])
def login():
    random_token = generate_token()
    return jsonify({'token': random_token})

# Endpoint de notas dos alunos
@app.route('/notasAlunos', methods=['GET'])
def get_student_notes():
    auth_header = request.headers.get('Authorization')
    
    if auth_header:
        return jsonify(students)
    else:
        return jsonify({'message': 'Unauthorized'}), 403

if __name__ == '__main__':
    app.run(debug=True)
