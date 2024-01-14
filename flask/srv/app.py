from flask import Flask, render_template

app = Flask(__name__)

# filtros,
from datetime import datetime

# Filtros pa def
@app.add_template_filter 
def today(date):
    return date.strftime("%d-%m-%Y")
# = app.add_template_filter(today, "today")


@app.route("/")
def principal():
    var_1 = "Criss"
    friends = ["pepe", "jose", "raul"]
    date = datetime.now()
    return render_template("index.html", 
                           var_1 = var_1, 
                           friends= friends,
                           date = date
                           )
    

@app.route("/pag2")
@app.route("/pag2/<string:name>")
def pag2(name= None):
    if name == None:
        return "<h1>hola</h1>"
    else:
        return f"<h1>hola {name}</h1>"


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

