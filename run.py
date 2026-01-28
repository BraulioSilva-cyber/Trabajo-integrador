from app import create_app

app = create_app()

if __name__ == '__main__':
    print("--> Iniciando servidor y verificando base de datos...")
    app.run(debug=True)